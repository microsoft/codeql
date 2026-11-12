using System;
using System.IO;
using Microsoft.Win32;
using SharePointEntry = Microsoft.SharePoint.Utilities.Cab.CabinetFileInfo;
using LegacyCabEntry = Microsoft.Deployment.Compression.Cab.CabFileInfo;

class CabReceiverPrecision
{
    public static void EntryToString(SharePointEntry entry, string root)
    {
        using (File.Create(Path.Combine(root, entry.ToString()))) { } // $ Sink=cabToString
    }

    public static void ObjectTypedEntry(SharePointEntry entry, string root)
    {
        object value = entry;
        using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
    }

    public static void UnrelatedString(string value, string root)
    {
        object boxed = value;
        using (File.Create(Path.Combine(root, boxed.ToString()))) { }
    }

    public static void RegistryValue(RegistryKey key, string root)
    {
        object value = key.GetValue("OutputDirectory");
        using (File.Create(Path.Combine(root, value.ToString()))) { }
    }

    public static void ScalarValue(object value, string root)
    {
        if (value is string || value is int || value is Guid)
            using (File.Create(Path.Combine(root, value.ToString()))) { }
    }

    public static void EntryFullName(LegacyCabEntry entry, string root)
    {
        string destination = Path.Combine(root, entry.FullName); // $ Alert=cab7
        using (File.Create(destination)) { } // $ Sink=cab7 $ Sink=cabGetter
    }

    public static void ContainerFullName(Microsoft.Deployment.Compression.ArchiveInfo archive)
    {
        Console.WriteLine(archive.Length);
    }

    private static object SafeString() => "file.txt";

    public static void HelperValue(string root)
    {
        using (File.Create(Path.Combine(root, SafeString().ToString()))) { }
    }

    public static void RegistryDefaultEntry(RegistryKey key, SharePointEntry entry, string root)
    {
        object value = key.GetValue("OutputDirectory", entry);
        using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
    }

    public static void UnknownValue(object value, string root)
    {
        using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
    }

    public static void AlternativeToTypeGuard(object value, bool other, string root)
    {
        if (value is string || other)
            using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
    }

    public static void AfterTypeGuard(object value, string root)
    {
        if (value is string)
            Console.WriteLine(value);
        using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
    }

    public static void ReassignedAfterGuard(object value, SharePointEntry entry, string root)
    {
        if (value is string)
        {
            value = entry;
            using (File.Create(Path.Combine(root, value.ToString()))) { } // $ Sink=cabToString
        }
    }

    public static void WmiValue(System.Management.ManagementBaseObject obj, string root)
    {
        using (File.Create(Path.Combine(root, obj["Name"].ToString()))) { }
        using (File.Create(Path.Combine(root, obj.GetPropertyValue("Name").ToString()))) { }
    }

    public static void OleDbValue(System.Data.OleDb.OleDbConnectionStringBuilder builder, string root)
    {
        using (File.Create(Path.Combine(root, builder["Data Source"].ToString()))) { }
    }
}

namespace System.Management
{
    public class ManagementBaseObject
    {
        public object this[string propertyName] { get { return null; } set { } }
        public object GetPropertyValue(string propertyName) { throw new NotImplementedException(); }
    }
}

namespace System.Data.OleDb
{
    public sealed class OleDbConnectionStringBuilder
    {
        public object this[string keyword] { get { return null; } set { } }
    }
}

namespace Microsoft.Deployment.Compression
{
    public class ArchiveInfo : FileSystemInfo
    {
        public override string Name => "archive.cab";
        public override bool Exists => true;
        public override void Delete() { }
        public long Length => new FileInfo(this.FullName).Length;
    }
}
