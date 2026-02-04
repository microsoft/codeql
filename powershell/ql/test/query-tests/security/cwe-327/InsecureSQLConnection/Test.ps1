# PowerShell equivalent of InsecureSQLConnection tests
# Using Microsoft.Data.SqlClient.SqlConnectionStringBuilder

# Load the Microsoft.Data.SqlClient assembly if needed
# Add-Type -AssemblyName "Microsoft.Data.SqlClient"

function Test1 {
    # Okay, set in initializer
    $hostingConnectionString = "localhost;Encrypt=false"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
    $hostingConnStringBuilder.Encrypt = $true
}

function Test2 {
    # Okay, context string: https://learn.microsoft.com/en-us/sql/relational-databases/clr-integration/data-access/context-connection?view=sql-server-ver16&tabs=csharp
    $hostingConnectionString = "context connection=true"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test3 {
    # Okay - Using property assignment with boolean $true
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder
    $hostingConnStringBuilder.DataSource = "localhost"
    $hostingConnStringBuilder.Encrypt = [bool]$true
}

function Test4 {
    # Okay - Connection string with Encrypt=true in the string
    $hostingConnectionString = "Data Source=localhost;Encrypt=true"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test5 {
    # Flagged
    $hostingConnectionString = "localhost;Encrypt=false"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test6 {
    # Flagged - Using New-Object cmdlet
    $hostingConnectionString = "localhost;Encrypt=false"
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder -ArgumentList $hostingConnectionString
}

function Test7 {
    # Flagged - Setting Encrypt to false explicitly
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new()
    $hostingConnStringBuilder.DataSource = "localhost"
    $hostingConnStringBuilder.Encrypt = $false
}
