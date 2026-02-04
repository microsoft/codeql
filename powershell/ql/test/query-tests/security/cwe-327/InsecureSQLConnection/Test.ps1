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

function Test4 {
    # Flagged - Using New-Object cmdlet
    $hostingConnectionString = "localhost"
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder($hostingConnectionString)
}

function Test5 {
    # Okay - Using New-Object with encryption enabled
    $hostingConnectionString = "localhost"
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder($hostingConnectionString)
    $hostingConnStringBuilder.Encrypt = $true
}

function Test6 {
    # Flagged - Empty constructor then setting DataSource
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new()
    $hostingConnStringBuilder.DataSource = "localhost"
}

function Test7 {
    # Okay - Empty constructor with encryption enabled
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new()
    $hostingConnStringBuilder.DataSource = "localhost"
    $hostingConnStringBuilder.Encrypt = $true
}

function Test8 {
    # Flagged - New-Object with empty constructor
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder
    $hostingConnStringBuilder.DataSource = "localhost"
}

function Test9 {
    # Okay - Connection string with Encrypt=true in the string
    $hostingConnectionString = "Data Source=localhost;Encrypt=true"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test10 {
    # Flagged - Connection string with Encrypt=false
    $hostingConnectionString = "Data Source=localhost;Encrypt=false"
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new($hostingConnectionString)
}

function Test11 {
    # Okay - Using property assignment with boolean $true
    $hostingConnStringBuilder = New-Object Microsoft.Data.SqlClient.SqlConnectionStringBuilder
    $hostingConnStringBuilder.DataSource = "localhost"
    $hostingConnStringBuilder.Encrypt = [bool]$true
}

function Test12 {
    # Flagged - Setting Encrypt to false explicitly
    $hostingConnStringBuilder = [Microsoft.Data.SqlClient.SqlConnectionStringBuilder]::new()
    $hostingConnStringBuilder.DataSource = "localhost"
    $hostingConnStringBuilder.Encrypt = $false
}
