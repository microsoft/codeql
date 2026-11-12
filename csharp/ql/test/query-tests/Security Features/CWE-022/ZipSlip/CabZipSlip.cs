using System;
using System.IO;
using SharePointEntry = Microsoft.SharePoint.Utilities.Cab.CabinetFileInfo;
using LegacyCabEntry = Microsoft.Deployment.Compression.Cab.CabFileInfo;
using CabEntry = WixToolset.Dtf.Compression.Cab.CabFileInfo;

class CabZipSlip
{
    public static void SharePointPath(SharePointEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.Path, entry.Name); // $ Alert=cab1
        using (File.Open(destination, FileMode.Create)) { } // $ Sink=cab1
    }

    public static void SharePointFullName(SharePointEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.FullName); // $ Alert=cab2
        using (File.Create(destination)) { } // $ Sink=cab2
    }

    public static void LegacyInheritedPath(LegacyCabEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.Path, entry.Name); // $ Alert=cab3
        using (new FileStream(destination, FileMode.Create)) { } // $ Sink=cab3
    }

    public static void LegacyFullNameWithoutContainment(LegacyCabEntry entry, string root)
    {
        string destination = Path.GetFullPath(Path.Combine(root, entry.FullName)); // $ Alert=cab4
        using (File.Create(destination)) { } // $ Sink=cab4 $ Sink=cabGetter
    }

    public static void InheritedPathThroughHelper(CabEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.Path, entry.Name); // $ Alert=cab5
        WriteEntry(destination);
    }

    private static void WriteEntry(string destination)
    {
        using (File.OpenWrite(destination)) { } // $ Sink=cab5
    }

    public static void FullName(CabEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.FullName); // $ Alert=cab6
        using (File.Create(destination)) { } // $ Sink=cab6
    }

    public static void ContainedSharePointPath(SharePointEntry entry, string root)
    {
        string destination = Path.GetFullPath(Path.Combine(root, entry.Path, entry.Name));
        string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
        if (!destination.StartsWith(fullRoot, StringComparison.OrdinalIgnoreCase))
            throw new InvalidOperationException();
        using (File.Create(destination)) { }
    }

    public static void ContainedInheritedPath(CabEntry entry, string root)
    {
        string destination = Path.GetFullPath(Path.Combine(root, entry.Path, entry.Name));
        string fullRoot = Path.GetFullPath(root + Path.DirectorySeparatorChar);
        if (!destination.StartsWith(fullRoot, StringComparison.OrdinalIgnoreCase))
            throw new InvalidOperationException();
        using (File.Create(destination)) { }
    }

    public static void NameOnly(SharePointEntry entry, LegacyCabEntry legacyEntry, CabEntry cabEntry, string root)
    {
        using (File.Create(Path.Combine(root, entry.Name))) { }
        using (File.Create(Path.Combine(root, legacyEntry.Name))) { }
        using (File.Create(Path.Combine(root, cabEntry.Name))) { }
    }

    public static void ExtractLeafName(SharePointEntry entry, string root)
    {
        string name = Path.GetFileName(Path.Combine(entry.Path, entry.Name));
        using (File.Create(Path.Combine(root, name))) { }
    }

    public static void UnrelatedEntry(Unrelated.CabinetFileInfo entry, string root)
    {
        using (File.Create(Path.Combine(root, entry.Path, entry.FullName, entry.Name))) { }
    }
}

// Minimal archive metadata fixtures; filesystem APIs come from the framework test dependency.
namespace Microsoft.SharePoint.Utilities.Cab
{
    internal sealed class CabinetFileInfo
    {
        internal CabinetFileInfo(string filePath)
        {
            this.Path = System.IO.Path.GetDirectoryName(filePath);
            this.Name = System.IO.Path.GetFileName(filePath);
            this.FullName = filePath;
        }

        internal string Path { get; }
        public string Name { get; }
        public string FullName { get; }

        public override string ToString() => this.FullName; // $ Alert=cabToString
    }
}

namespace Microsoft.Deployment.Compression
{
    public abstract class ArchiveFileInfo : FileSystemInfo
    {
        protected ArchiveFileInfo(string filePath)
        {
            this.Path = System.IO.Path.GetDirectoryName(filePath);
            this.Name = System.IO.Path.GetFileName(filePath);
        }

        public string Path { get; }
        public override string Name { get; }
        public override string FullName => System.IO.Path.Combine(this.Path, this.Name); // $ Alert=cabGetter
        public override bool Exists => true;
        public override void Delete() { }
    }
}

namespace Microsoft.Deployment.Compression.Cab
{
    public class CabFileInfo : ArchiveFileInfo
    {
        public CabFileInfo(string filePath) : base(filePath) { }
    }
}

namespace WixToolset.Dtf.Compression
{
    public abstract class ArchiveFileInfo
    {
        protected ArchiveFileInfo(string filePath)
        {
            this.Path = System.IO.Path.GetDirectoryName(filePath);
            this.Name = System.IO.Path.GetFileName(filePath);
            this.FullName = filePath;
        }

        public string Path { get; }
        public string Name { get; }
        public string FullName { get; }
    }
}

namespace WixToolset.Dtf.Compression.Cab
{
    public class CabFileInfo : ArchiveFileInfo
    {
        public CabFileInfo(string filePath) : base(filePath) { }
    }
}

namespace Unrelated
{
    public class CabinetFileInfo
    {
        public string Path { get; }
        public string Name { get; }
        public string FullName { get; }
    }
}
