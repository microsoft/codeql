# PowerShell equivalent of InsecureSQLConnection tests
# Using Microsoft.Data.SqlClient.SqlConnectionStringBuilder

# Load the Microsoft.Data.SqlClient assembly if needed
# Add-Type -AssemblyName "Microsoft.Data.SqlClient"

function Test1 {
    # Okay, set in initializer
    $hostingConnectionString = "localhost"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
    $hostingConnStringBuilder.Encrypt = $true
}

function Test2 {
    # Okay, context string: https://learn.microsoft.com/en-us/sql/relational-databases/clr-integration/data-access/context-connection?view=sql-server-ver16&tabs=csharp
    $hostingConnectionString = "context connection=true"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test3 {
    # Flagged
    $hostingConnectionString = "localhost"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}
