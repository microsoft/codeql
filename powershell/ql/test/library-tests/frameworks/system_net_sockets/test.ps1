param($server) # $ type="command line argument"

$tcpClient = [System.Net.Sockets.TcpClient]::new($server, 8080)
$networkStream = $tcpClient.GetStream() # $ type="remote flow source"


$localEndpoint = [System.Net.IPEndPoint]::new([System.Net.IPAddress]::Any, 8080)
$udpClient = [System.Net.Sockets.UdpClient]::new($localEndpoint)
$asyncResult = $udpClient.BeginReceive($null, $null)
$asyncResult.AsyncWaitHandle.WaitOne()
$remoteEndpoint = $null
$data = $udpClient.EndReceive($asyncResult, [ref]$remoteEndpoint) # $ type="remote flow source"

$remoteEndpoint2 = $null
$data2 = $udpClient.Receive([ref]$remoteEndpoint2) # $ type="remote flow source"

$receiveTask = $udpClient.ReceiveAsync() # $ type="remote flow source"

$webclient = [System.Net.WebClient]::new()
$data = $webclient.DownloadData("https://example.com/data.txt") # $ type="remote flow source"

$positionalWebClient = New-Object System.Net.WebClient
$positionalData = $positionalWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$quotedWebClient = New-Object "System.Net.WebClient"
$quotedData = $quotedWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$namedWebClient = New-Object -TypeName System.Net.WebClient
$namedData = $namedWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$partialWebClient = New-Object Net.WebClient
$partialData = $partialWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$unqualifiedWebClient = New-Object WebClient
$unqualifiedData = $unqualifiedWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$mixedCaseWebClient = New-Object sYsTeM.nEt.WeBcLiEnT
$mixedCaseData = $mixedCaseWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"

$dynamicWebClientType = "System.Net.WebClient"
$dynamicWebClient = New-Object -TypeName $dynamicWebClientType
$dynamicData = $dynamicWebClient.DownloadData("https://example.com/data.txt") # $ MISSING: type="remote flow source"
