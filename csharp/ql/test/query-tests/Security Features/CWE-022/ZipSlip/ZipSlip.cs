using System;
using System.IO;
using System.IO.Compression;

namespace ZipSlip
{
    class Program
    {
        private static readonly char DirectorySeparatorChar = '\\';

        public static void UnzipFileByFile(ZipArchive archive, string destDirectory)
        {
            foreach (var entry in archive.Entries)
            {
                string fullPath_relative = Path.GetFullPath(entry.FullName);
                string filename_filenameOnly = Path.GetFileName(entry.FullName);
                string filename_noPathTraversal = entry.Name;
                string file_badDirectoryTraversal = entry.FullName;
                if (!string.IsNullOrEmpty(file_badDirectoryTraversal))
                {
                    // BAD
                    string destFileName = Path.Combine(destDirectory, file_badDirectoryTraversal);
                    entry.ExtractToFile(destFileName, true);

                    // GOOD
                    string sanitizedFileName = Path.Combine(destDirectory, filename_filenameOnly);
                    entry.ExtractToFile(sanitizedFileName, true);

                    // BAD
                    string destFilePath = Path.Combine(destDirectory, fullPath_relative);
                    entry.ExtractToFile(destFilePath, true);

                    unzipWrapperProtected(destDirectory, entry);

                    string destFilePath_notCanonicalized = destDirectory + "/" + fullPath_relative;
                    if (destFilePath_notCanonicalized.StartsWith(destDirectory)){
                        // BAD: no canonicalization has been applied. Directory traversal characters
                        // could still be present ie C:\some\dir\..\..\abc.exe
                        entry.ExtractToFile(destFilePath_notCanonicalized, true);
                    }

                    string destFilePath_fullyCanonicalized = Path.GetFullPath(destFilePath_notCanonicalized);
                    if (destFilePath_fullyCanonicalized.StartsWith(destDirectory)){
                        // GOOD: canonicalization has been applied by GetFullPath, +StartsWith Barrier.
                        entry.ExtractToFile(destFilePath_fullyCanonicalized, true);
                    }
                    
                    string destFilePath_fullyCanonicalized2 = Path.GetFullPath(destFileName);
                    if (destFilePath_fullyCanonicalized2.StartsWith(destDirectory)){
                        // GOOD: canonicalization has been applied by GetFullPath, +StartsWith Barrier.
                        entry.ExtractToFile(destFilePath_fullyCanonicalized2, true);
                    }
                }
            }
        }
        
        private static void unzipWrapperProtected(string destinationPath, ZipArchiveEntry entry){
            string fullpath = Path.Combine(destinationPath, entry.FullName);
            string entry_fullpath = Path.GetFullPath(entry.FullName);

            // BAD: no canonicalization, no validation/guard.
            entry.ExtractToFile(fullpath, true);

            if(ContainsPath(fullpath, destinationPath, true)){
                // GOOD - Barrier guard applied (canonicalization applied in ContainsPath)
                entry.ExtractToFile(fullpath, true);
            }
            
            if(!ContainsPath(fullpath, destinationPath, true)){
                // BAD: Failed guard
                entry.ExtractToFile(fullpath, true);
                Console.WriteLine("Path traversal detected");
                return;
            }

            // GOOD: Path has been sanitized above and guarded for (by returning early)
            entry.ExtractToFile(fullpath, true);

            if(ContainsPath(fullpath, destinationPath, true)){
                // GOOD: guarded by ContainsPath (with delegate calls to StartsWith)
                entry.ExtractToFile(fullpath, true);
            }

            // GOOD: path checking applied above (and function terminates early).
            string destFilePath = Path.Combine(destinationPath, entry_fullpath);
            if (!destFilePath.StartsWith(destinationPath)){
                return;
            }
            entry.ExtractToFile(fullpath, true);
        }

        private static int UnzipToStream(Stream zipStream, string installDir)
        {
            int returnCode = 0;
            try
            {
                // normalize InstallDir for use in check below
                var InstallDir = Path.GetFullPath(installDir + Path.DirectorySeparatorChar);

                using (ZipArchive archive = new ZipArchive(zipStream, ZipArchiveMode.Read))
                {
                    foreach (ZipArchiveEntry entry in archive.Entries)
                    {
                        // figure out where we are putting the file
                        String destFilePath = Path.Combine(InstallDir, entry.FullName);

                        Directory.CreateDirectory(Path.GetDirectoryName(destFilePath));

                        using (Stream archiveFileStream = entry.Open())
                        {
                            // BAD: writing to file stream
                            using (Stream tfsFileStream = new FileStream(destFilePath, FileMode.CreateNew, FileAccess.ReadWrite, FileShare.None))
                            {
                                Console.WriteLine(@"Writing ""{0}""", destFilePath);
                                archiveFileStream.CopyTo(tfsFileStream);
                            }

                            // BAD: can do it this way too
                            using (Stream tfsFileStream = File.Create(destFilePath))
                            {
                                Console.WriteLine(@"Writing ""{0}""", destFilePath);
                                archiveFileStream.CopyTo(tfsFileStream);
                            }

                            // BAD: creating stream using fileInfo
                            var fileInfo = new FileInfo(destFilePath);
                            using (FileStream fs = fileInfo.OpenWrite())
                            {
                                Console.WriteLine(@"Writing ""{0}""", destFilePath);
                                archiveFileStream.CopyTo(fs);
                            }

                            // BAD: creating stream using fileInfo
                            var fileInfo1 = new FileInfo(destFilePath);
                            using (FileStream fs = fileInfo1.Open(FileMode.Create))
                            {
                                Console.WriteLine(@"Writing ""{0}""", destFilePath);
                                archiveFileStream.CopyTo(fs);
                            }

                            // GOOD: Use substring to pick out single component
                            string fileName = destFilePath.Substring(destFilePath.LastIndexOf("\\"));
                            var fileInfo2 = new FileInfo(fileName);
                            using (FileStream fs = fileInfo2.Open(FileMode.Create))
                            {
                                Console.WriteLine(@"Writing ""{0}""", destFilePath);
                                archiveFileStream.CopyTo(fs);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error patching files: {0}", ex.ToString());
                returnCode = -1;
            }

            return returnCode;
        }

        public static string? AddBackslashIfNotPresent(string? path)
        {
            if (!string.IsNullOrEmpty(path) && path![path.Length - 1] != DirectorySeparatorChar)
            {
                path += DirectorySeparatorChar;
            }
            return path;
        }

        public static bool ContainsPath(string? fullPath, string? path){
            return ContainsPath(fullPath, path, true);
        }
        
        public static bool ContainsPath(string? fullPath, string? path, bool excludeSame)
        {
            try
            {
                fullPath = Path.GetFullPath(fullPath);
                path = Path.GetFullPath(path);

                fullPath = AddBackslashIfNotPresent(fullPath);
                path = AddBackslashIfNotPresent(path);

                var result = fullPath!.StartsWith(path, StringComparison.OrdinalIgnoreCase);
                if (result && excludeSame)
                {
                    return !fullPath.Equals(path, StringComparison.OrdinalIgnoreCase);
                }
                return result;
            }
            catch
            {
                // If there is any error, just return false
                return false;
            }
        }

        /* Test that the given `fullPath` exists within the given `path` directory.
         * If it does not, throw an exception to terminate the request.
        */
        public static void ContainsPathValidationThrowing(string? fullPath, string? path)
        {
            fullPath = Path.GetFullPath(fullPath);
            path = Path.GetFullPath(path);

            fullPath = AddBackslashIfNotPresent(fullPath);
            path = AddBackslashIfNotPresent(path);

            if (!fullPath!.StartsWith(path, StringComparison.OrdinalIgnoreCase)) {
                throw new Exception("Attempting path traversal");
            }
        }

        static void Main(string[] args)
        {
            string zipFileName;
            zipFileName = args[0];

            string targetPath = args.Length == 2 ? args[1] : ".";

            using (FileStream file = new FileStream(zipFileName, FileMode.Open))
            {
                using (ZipArchive archive = new ZipArchive(file, ZipArchiveMode.Read))
                {
                    UnzipFileByFile(archive, targetPath);

                    // GOOD: the path is checked in this extension method
                    archive.ExtractToDirectory(targetPath);

                    UnzipToStream(file, targetPath);
                }
            }
        }

        /**
        * Negative - dangerous path terminates early due to exception thrown by guarded condition.
        */
        static void fp_throw(ZipArchive archive, string root){
            foreach (var entry in archive.Entries){
                string destinationOnDisk = Path.GetFullPath(Path.Combine(root, entry.FullName));
                string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
                if (!destinationOnDisk.StartsWith(fullRoot)){
                    throw new Exception("Entry is outside of target directory. There may have been some directory traversal sequences in filename.");
                }
                // NEGATIVE, above exception short circuits on invalid input by path traversal.
                entry.ExtractToFile(destinationOnDisk, true);
            }
        }

        /**
        * Negative - dangerous path terminates early due to exception thrown by guarded condition in descendent call.
        */
        static void fp_throw_nested_exception(ZipArchive archive, string root){
            foreach (var entry in archive.Entries){
                string destinationOnDisk = Path.GetFullPath(Path.Combine(root, entry.FullName));
                string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
                ContainsPathValidationThrowing(destinationOnDisk, fullRoot);
                // NEGATIVE, above exception short circuits by exception on invalid input by path traversal.
                entry.ExtractToFile(destinationOnDisk, true);
            }
        }

        /**
        * Negative - no extraction, only sanitization
        */
        static void fp_throw_sanitizer_valid(string file, string root){
            string destinationOnDisk = Path.GetFullPath(file);
            string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
            if (!destinationOnDisk.StartsWith(fullRoot)){
                throw new Exception("Entry is outside of target directory. There may have been some directory traversal sequences in filename.");
            }
        }

        /**
        * Negative - dangerous path terminates early due to throw in fp_throw_sanitizer_valid
        */
        static void fp_throw_nested_exception_uncaught(ZipArchive archive, string root){
            foreach (var entry in archive.Entries){
                string destinationOnDisk = Path.GetFullPath(Path.Combine(root, entry.FullName));
                string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
                fp_throw_sanitizer_valid(destinationOnDisk, fullRoot);
                entry.ExtractToFile(destinationOnDisk, true);
            }
        }

        /**
        * Negative - no extraction, only sanitization
        */
        static void fp_throw_sanitizer_invalid(string file, string root){
            try{
                string destinationOnDisk = Path.GetFullPath(file);
                string fullRoot = Path.GetFullPath(root);
                if (!destinationOnDisk.StartsWith(fullRoot)){
                    throw new Exception("Entry is outside of target directory. There may have been some directory traversal sequences in filename.");
                }
            }catch(Exception e){}
        }

        /**
        * Positive - dangerous path does not terminate early due to try block in fp_throw_sanitizer_invalid
        */
        static void tp_throw_nested_exception_caught(ZipArchive archive, string root){
            foreach (var entry in archive.Entries){
                string destinationOnDisk = Path.GetFullPath(Path.Combine(root, entry.FullName));
                string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
                fp_throw_sanitizer_invalid(destinationOnDisk, fullRoot);
                entry.ExtractToFile(destinationOnDisk, true);
            }
        }
    }
}
