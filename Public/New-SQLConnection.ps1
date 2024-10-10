
# creates connection to sql server instance
function New-SQLConnection {
    [CmdletBinding()]
    param (
        # sql server connection string
        [Parameter(Mandatory=$False)]
        [string]
        $ConnectionString=$env:SIMPLESQLSERVER_CONNECTION_STRING,
        [switch]
        $Open
    )
    
    begin {
        if([string]::IsNullOrEmpty($ConnectionString) -or [string]::IsNullOrWhiteSpace($ConnectionString)){
            throw "Connection String is Empty"
        }
    }
    
    process {
        $connection = new-object system.data.SqlClient.SQLConnection($ConnectionString)
        if($Open){
            $connection.Open()
        }
        return $connection
    }
    
    end {
        
    }
}


