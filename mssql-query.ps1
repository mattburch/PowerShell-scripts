# SQL Query function
function ExecuteSqlQuery ($Server, $Database, $SQLQuery) {
  $Datatable = New-Object System.Data.DataTable

  $Connection = New-Object System.Data.SQLClient.SQLConnection
  $Connection.ConnectionString = "server='$Server';database='$Database';trusted_connection=true;"
  $Connection.Open()
  $Command = New-Object System.Data.SQLClient.SQLCommand
  $Command.Connection = $Connection
  $Command.CommandText = $SQLQuery
  $Reader = $Command.ExecuteReader()
  $Datatable.Load($Reader)
  $Connection.Close()

  return $Datatable
}

function printData ($results) {
  if ($results.Length -lt 1) {
    Write-Host ("[-] No Results Returned")
  }
  else {
    $results
    Write-host ("`n[+] " + [string]$results.Length + " Results Returned")
  }
}

function QueryTable-PCI {

  # Pull in required parameters
  param(
    [string]$Server,
    [string]$Database
  )

  # Variable declaration
  $SQLQuery = "SELECT t.name AS table_name," +
              " SCHEMA_NAME(schema_id) AS schema_name," +
              " c.name AS column_name " +
              "FROM sys.tables AS t " +
              "INNER JOIN sys.columns c" +
              " ON t.OBJECT_ID = c.OBJECT_ID " +
              "WHERE LOWER(c.name) LIKE '%cc%'" +
              " or LOWER(c.name) LIKE '%cvv%'" +
              " or LOWER(c.name) LIKE '%card%'" +
              " or LOWER(c.name) LIKE '%routing%' " +
              " or LOWER(c.name) LIKE '%rtn%' " +
              "ORDER BY schema_name, table_name;"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function QueryAll-PCI {
  # Pull in required parameters
  param(
    [string]$Server
  )

  # Variable declaration
  $Database = "master"
  $SQLQuery = "SELECT t.name AS table_name," +
              " SCHEMA_NAME(schema_id) AS schema_name," +
              " c.name AS column_name " +
              "FROM sys.tables AS t " +
              "INNER JOIN sys.columns c" +
              " ON t.OBJECT_ID = c.OBJECT_ID " +
              "WHERE LOWER(c.name) LIKE '%cc%'" +
              " or LOWER(c.name) LIKE '%cvv%'" +
              " or LOWER(c.name) LIKE '%card%'" +
              " or LOWER(c.name) LIKE '%routing%' " +
              " or LOWER(c.name) LIKE '%rtn%' " +
              "ORDER BY schema_name, table_name;"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function QueryTable-PII {

  # Pull in required parameters
  param(
    [string]$Server,
    [string]$Database
  )

  # Variable declaration
  $SQLQuery = "SELECT t.name AS table_name," +
              " SCHEMA_NAME(schema_id) AS schema_name," +
              " c.name AS column_name " +
              "FROM sys.tables AS t " +
              "INNER JOIN sys.columns c" +
              " ON t.OBJECT_ID = c.OBJECT_ID " +
              "WHERE LOWER(c.name) LIKE '%ssn%'" +
              " or LOWER(c.name) LIKE '%birth%'" +
              " or LOWER(c.name) LIKE '%address%'" +
              "ORDER BY schema_name, table_name;"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function QueryAll-PII {

  # Pull in required parameters
  param(
    [string]$Server
  )


  # Variable declaration
  $Database = "master"
  $SQLQuery = "SELECT t.name AS table_name," +
              " SCHEMA_NAME(schema_id) AS schema_name," +
              " c.name AS column_name " +
              "FROM sys.tables AS t " +
              "INNER JOIN sys.columns c" +
              " ON t.OBJECT_ID = c.OBJECT_ID " +
              "WHERE LOWER(c.name) LIKE '%ssn%'" +
              " or LOWER(c.name) LIKE '%birth%'" +
              " or LOWER(c.name) LIKE '%address%'" +
              "ORDER BY schema_name, table_name;"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function ListTable-Columns {

  # Pull in required parameters
  param(
    [string]$Server,
    [string]$Database,
    [string]$Table
  )

  # Variable declaration
  $SQLQuery = "SELECT t.name AS table_name," +
              " c.name AS column_name " +
              "FROM sys.tables AS t " +
              "INNER JOIN sys.columns c" +
              " ON t.OBJECT_ID = c.OBJECT_ID " +
              "WHERE t.name = '$Table' " +
              "ORDER BY column_name;"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function DumpTable-Top1000 {

  # Pull in required parameters
  param(
    [string]$Server,
    [string]$Database,
    [string]$Table
  )

  # Variable declaration
  $SQLQuery = "SELECT TOP 1000 * " +
              "FROM " + $Table + ";"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function DumpTableCustom-Top1000 {

  # Pull in required parameters
  param(
    [string]$Server,
    [string]$Database,
    [string]$Table,
    [string]$Columns
  )

  # Variable declaration
  $SQLQuery = "SELECT TOP 1000 " + $Columns +
              "FROM " + $Table + ";"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}

function Get-Databases {

  # Pull in required parameters
  param(
    [string]$Server
  )

  # Variable declaration
  $Database = "master"
  $SQLQuery = "SELECT name " +
              "FROM master.dbo.sysdatabases"
  $resultsDataTable = New-Object System.Data.DataTable
  $resultsDataTable = ExecuteSqlQuery $Server $Database $SQLQuery

  printData $resultsDataTable

}
