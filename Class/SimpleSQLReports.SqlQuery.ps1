
class SqlQuery {

    [string]$ConnectionString
    [system.data.SqlClient.SQLConnection]$Connection
    [string]$QueryText
    [string]$QueryPath
    [pscredential]$Credentials
    [System.Data.DataSet]$QueryResults
    [System.Data.SqlClient.SqlCredential]$sqlCredentials

    SqlQuery([string]$connStr, [string]$query, [pscredential]$creds){

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
        $this.Connection.Credential = $this.sqlCredentials

    }

}