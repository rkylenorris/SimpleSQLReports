
class SqlSelectQuery {

    [string]$ConnectionString
    $Connection
    [string]$QueryText
    [string]$QueryPath
    [pscredential]$Credentials
    [System.Data.DataSet]$QueryResults
    [System.Data.SqlClient.SqlCredential]$sqlCredentials

    SqlSelectQuery([string]$connStr, [string]$query, [pscredential]$creds){

        $this.ConnectionString = $connStr
        $this.Credentials = $creds
        $this.Credentials.Password.MakeReadOnly()
        $this.sqlCredentials = [System.Data.SqlClient.SqlCredential]::new($This.Credentials.UserName, $This.Credentials.Password)

        if(Test-Path $query){
            $this.QueryPath = $query
            $this.QueryText = Get-Content $query -Raw
        }else{
            $this.QueryPath = $null
            $this.QueryText = $query
        }

        $this.Connection = new-object system.data.SqlClient.SQLConnection($this.ConnectionString)
        # $this.Connection.Credential = $this.sqlCredentials
        # $this.Connection.Open()

    }

    [System.Data.DataSet] InvokeQuery(){
        $sqlCmd = New-Object System.Data.SqlClient.SqlCommand($this.QueryText, $this.Connection)
        $this.Connection.Open()
        $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCmd
        $dataset = New-Object System.Data.DataSet
        $sqlAdapter.Fill($dataset) | Out-Null
        $this.Connection.Close()

        return $dataset
    }

}

$connStr = "Data Source=localhost\SQLEXPRESS;Initial Catalog=PoShTest;Integrated Security=SSPI;"
$q = "SELECT * FROM [ForTesting]"
$C = [pscredential]::new("rkynorris", ('Sup3rG4y!' | ConvertTo-SecureString -AsPlainText -Force))

$sqlSelect = [SqlSelectQuery]::new($connStr, $q, $C)
$data = $sqlSelect.InvokeQuery()


