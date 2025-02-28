// This file contains auto-generated code.
// Generated from `Microsoft.AspNetCore.Server.Kestrel.Transport.NamedPipes, Version=9.0.0.0, Culture=neutral, PublicKeyToken=adb9793829ddae60`.
namespace Microsoft
{
    namespace AspNetCore
    {
        namespace Hosting
        {
            public static partial class WebHostBuilderNamedPipeExtensions
            {
                public static Microsoft.AspNetCore.Hosting.IWebHostBuilder UseNamedPipes(this Microsoft.AspNetCore.Hosting.IWebHostBuilder hostBuilder) => throw null;
                public static Microsoft.AspNetCore.Hosting.IWebHostBuilder UseNamedPipes(this Microsoft.AspNetCore.Hosting.IWebHostBuilder hostBuilder, System.Action<Microsoft.AspNetCore.Server.Kestrel.Transport.NamedPipes.NamedPipeTransportOptions> configureOptions) => throw null;
            }
        }
        namespace Server
        {
            namespace Kestrel
            {
                namespace Transport
                {
                    namespace NamedPipes
                    {
                        public sealed class CreateNamedPipeServerStreamContext
                        {
                            public CreateNamedPipeServerStreamContext() => throw null;
                            public Microsoft.AspNetCore.Connections.NamedPipeEndPoint NamedPipeEndPoint { get => throw null; set { } }
                            public System.IO.Pipes.PipeOptions PipeOptions { get => throw null; set { } }
                            public System.IO.Pipes.PipeSecurity PipeSecurity { get => throw null; set { } }
                        }
                        public sealed class NamedPipeTransportOptions
                        {
                            public static System.IO.Pipes.NamedPipeServerStream CreateDefaultNamedPipeServerStream(Microsoft.AspNetCore.Server.Kestrel.Transport.NamedPipes.CreateNamedPipeServerStreamContext context) => throw null;
                            public System.Func<Microsoft.AspNetCore.Server.Kestrel.Transport.NamedPipes.CreateNamedPipeServerStreamContext, System.IO.Pipes.NamedPipeServerStream> CreateNamedPipeServerStream { get => throw null; set { } }
                            public NamedPipeTransportOptions() => throw null;
                            public bool CurrentUserOnly { get => throw null; set { } }
                            public int ListenerQueueCount { get => throw null; set { } }
                            public long? MaxReadBufferSize { get => throw null; set { } }
                            public long? MaxWriteBufferSize { get => throw null; set { } }
                            public System.IO.Pipes.PipeSecurity PipeSecurity { get => throw null; set { } }
                        }
                    }
                }
            }
        }
    }
}
