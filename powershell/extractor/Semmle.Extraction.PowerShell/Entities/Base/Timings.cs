using System;

namespace Semmle.Extraction.PowerShell.Entities
{
    public struct Timings
    {
        public TimeSpan Elapsed { get; set; }
        public TimeSpan Cpu { get; set; }
        public TimeSpan User { get; set; }
    }
}
