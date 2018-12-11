# Restart engines
# Version 1.1
#
# bug retries count down needs looking into - it might be retrying for the amount of time specified.


[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')


[xml]$XAML = @'
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Restart Engines" Height="371" Width="630">
   
        <Grid>
        <Label Name="label" Content="Environment" HorizontalAlignment="Left" Height="28" Margin="3,15,0,0" VerticalAlignment="Top" Width="135"/>
        <CheckBox Name="CBDev" Content="Dev" HorizontalAlignment="Left" Height="19" Margin="224,21,0,0" VerticalAlignment="Top" Width="49"/>
        <CheckBox Name="CBStaging" Content="Staging" HorizontalAlignment="Left" Height="19" Margin="305,21,0,0" VerticalAlignment="Top" Width="70"/>
        <CheckBox Name="CBPreProd" Content="PreProd" HorizontalAlignment="Left" Height="19" Margin="425,21,0,0" VerticalAlignment="Top" Width="72"/>
        <CheckBox Name="CBProd" Content="Prod" HorizontalAlignment="Left" Height="19" Margin="547,21,0,0" VerticalAlignment="Top" Width="49"/>
        <Label Name="label1" Content="Engine" HorizontalAlignment="Left" Height="33" Margin="3,62,0,0" VerticalAlignment="Top" Width="127"/>
        <Label Name="label2" Content="Engine2" HorizontalAlignment="Left" Height="30" Margin="3,104,0,0" VerticalAlignment="Top" Width="149"/>
        <Label Name="label3" Content="Engine3" HorizontalAlignment="Left" Height="30" Margin="3,147,0,0" VerticalAlignment="Top" Width="149"/>
        <Label Name="label4" Content="Engine4" HorizontalAlignment="Left" Height="23" Margin="3,191,0,0" VerticalAlignment="Top" Width="149"/>
            <CheckBox Name="CBLive" Content="" HorizontalAlignment="Left" Height="17" Margin="149,72,0,0" VerticalAlignment="Top" Width="30"/>
            <CheckBox Name="CB2" Content="" HorizontalAlignment="Left" Height="17" Margin="149,109,0,0" VerticalAlignment="Top" Width="30"/>
            <CheckBox Name="CB3" Content="" HorizontalAlignment="Left" Height="17" Margin="149,154,0,0" VerticalAlignment="Top" Width="30"/>
            <CheckBox Name="CB4" Content="" HorizontalAlignment="Left" Height="17" Margin="149,197,0,0" VerticalAlignment="Top" Width="30"/>
            <TextBox Name="TBDev" HorizontalAlignment="Left" Height="23" Margin="186,66,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TBSTG" HorizontalAlignment="Left" Height="23" Margin="294,66,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TBPreProd" HorizontalAlignment="Left" Height="23" Margin="402,66,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TBProd" HorizontalAlignment="Left" Height="23" Margin="511,66,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB2Dev" HorizontalAlignment="Left" Height="23" Margin="186,108,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB2STG" HorizontalAlignment="Left" Height="23" Margin="294,108,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB2PreProd" HorizontalAlignment="Left" Height="23" Margin="402,108,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB2Prod" HorizontalAlignment="Left" Height="23" Margin="511,108,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB3Dev" HorizontalAlignment="Left" Height="23" Margin="186,152,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB3STG" HorizontalAlignment="Left" Height="23" Margin="294,152,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB3PreProd" HorizontalAlignment="Left" Height="23" Margin="402,152,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB3Prod" HorizontalAlignment="Left" Height="23" Margin="511,152,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB4Dev" HorizontalAlignment="Left" Height="23" Margin="186,194,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB4STG" HorizontalAlignment="Left" Height="23" Margin="294,194,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB4PreProd" HorizontalAlignment="Left" Height="23" Margin="402,194,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <TextBox Name="TB4Prod" HorizontalAlignment="Left" Height="23" Margin="511,194,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="95"/>
            <Button Name="BTGo" Content="Go" HorizontalAlignment="Left" Height="38" Margin="511,266,0,0" VerticalAlignment="Top" Width="78"/>
            <Label Name="label5" Content="Keep trying for " HorizontalAlignment="Left" Height="30" Margin="10,249,0,0" VerticalAlignment="Top" Width="158"/>
            <TextBox Name="retries" HorizontalAlignment="Left" Height="30" Margin="186,253,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="68" Text="5"/>
            <Label Name="label6" Content="seconds" HorizontalAlignment="Left" Height="30" Margin="269,249,0,0" VerticalAlignment="Top" Width="158"/>



        </Grid>

</Window>
'@  


 



#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}
  
#Function Get-FormVariables{
#if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
#write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
#get-variable WPF*
#}
 
#Get-FormVariables
#===========================================================================
# Add events to Form Objects
#===========================================================================



Function SQLEngineCheck 

<#

.REMARKS
test

.Description

This function connects to the selected SQL server, runs a T-SQL to find out if there are any manifests queued or being processed.

2 parameters are used.  1 for selecting the server, the other one to select the AthenaEngine.  

The function will then remotely connect to the server using integrated authentication, so make sure the user has necessary rights.

***

Parameters:

 $engine =                    EngineProcessID	Name
                                           1	Engine
                                           2	Engine2
                                           3	Engine3
                                           4	Engine4

 $server =  Int  SQL server 
              1  Dev
              2  Staging
              3  PreProd
              4  Prod
              5  Test

$engine = 2   test parameters convert correcly
$servers = 2

#>
    {
        #[cmdletbinding()]
        param([parameter(Mandatory=$true,Position=0)]
              [ValidateNotNullOrEmpty()]
              [int]$servers,
              [parameter(Mandatory=$true,Position=1)]
              [ValidateNotNullOrEmpty()]  
              [int]$engine)



switch ($servers)
{
    1{$server = 'dev-db01'; $database = 'Dev'}
    2{$server = 'stg-db01'; $database = 'STG'}
    3{$server = 'stg-db01'; $database = 'PreProd'}
    4{$server = 'Prod-db01'; $database = 'Live'}
    5{$server = 'sql-testsrv'; $database = 'Test'}
}



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server=$server;Database=$Database;Integrated Security=True"
write-host $SqlConnection.ConnectionString
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = "select * from ImportManifestLog where EngineProcessID = $engine AND processingStatusID in (1,2,3) and DownloadDate >=  CAST (getdate() as DATE)"
$SqlCmd.Connection = $SqlConnection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd

$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$SqlConnection.Close()

    }


function RestartEngines
<# 

Description.

This function restarts the selected AthenaEngine service on the selected server.

2 parameters are used.  1 for selecting the server, the other one to select the service.  

The function will then remotely connect to the server using integrated authentication, so make sure the user has rights, and restarts the service.

***

Parameters:

 $server =  App server 
              1  Dev
              2  Staging
              3  PreProd
              4  Prod

$engine =                    EngineProcessID	Name
                                           1	Engine
                                           2	Engine2
                                           3	Engine3
                                           4	Engine4

test parameters convert correcly

$engine = 1   
$servers = 1
#>

{
        param([parameter(Mandatory=$true,Position=0)]
              [ValidateNotNullOrEmpty()]
              [int]$server,
              [parameter(Mandatory=$true,Position=1)]
              [ValidateNotNullOrEmpty()]
              [int]$engine)


switch ($server)
    {
        1{$name = 'dev-app.local'}
        2{$name = 'stg-app.local'}
        3{$name = 'preprod-app.local'}
        4{$name = 'prodapp.local'}
    }

switch ($engine)
    {
        1{write-host "Invoke-Command -ComputerName $name {Restart-Service Engine}"
          Invoke-Command -ComputerName $name {Restart-Service Engine}}
        2{write-host "Invoke-Command -ComputerName $name {Restart-Service 'Engine2 service'}"
          Invoke-Command -ComputerName $name {Restart-Service 'Engine2 service'}}
        3{write-host "Invoke-Command -ComputerName $name {Restart-Service 'Engine3 service'}"
          Invoke-Command -ComputerName $name {Restart-Service 'Engine3 service'}}
        4{write-host "Invoke-Command -ComputerName $name {Restart-Service Engine4}"
          Invoke-Command -ComputerName $name {Restart-Service Engine4}}
    }

# write-host 'you selected' $service 
#Invoke-Command -ComputerName -dev-app..local {Restart-Service $service}
}


$BTGO.Add_Click(
{
   
  
   
   Do
    {
# Dev
    if ($CBDev.ischecked -eq $true)
        {
            if ($CBLive.IsChecked -eq $true)
                {
                   if((SQLEngineCheck 1 1) -eq 0)
                        {  
                         (RestartEngines 1 1)
                         $TBDev.text = 'Restarted'
                         $CBLive.IsChecked = $false
                        }
                   else 
                        {
                         $TBDev.text = 'Busy'
                        }
                }
        
            if ($CB2.IsChecked -eq $true)
               {
                   if((SQLEngineCheck 1 2) -eq 0)
                        {  
                         (RestartEngines 1 2)
                         $TB2Dev.text = 'Restarted'
                         $CB2.IsChecked = $false
                        }
                   else 
                        {
                         $TB2Dev.text = 'Busy'
                        }
                }
            if ($CB3.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 1 3) -eq 0)
                        {  
                         (RestartEngines 1 3)
                         $TB3Dev.text = 'Restarted'
                         $CB3.IsChecked = $false
                        }
                   else 
                        {
                         $TB3Dev.text = 'Busy'
                        }
                }
        
            if ($CB4.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 1 4) -eq 0)
                        {  
                         (RestartEngines 1 4)
                         $TB4Dev.text = 'Restarted'
                         $CB4.IsChecked = $false

                        }
                   else 
                        {
                         $TB4Dev.text = 'Busy'
                        }
                }
        }
        
# Staging 
if ($CBStaging.ischecked -eq $true)
        {
            if ($CBLive.IsChecked -eq $true)
                {
                   if((SQLEngineCheck 2 1) -eq 0)
                        {  
                         (RestartEngines 2 1)
                         $TBSTG.text = 'Restarted'
                         $CBLive.IsChecked = $false
                        }
                   else 
                        {
                         $TBSTG.text = 'Busy'
                        }
                }
        
            if ($CB2.IsChecked -eq $true)
               {
                   if((SQLEngineCheck 2 2) -eq 0)
                        {  
                         (RestartEngines 2 2)
                         $TB2STG.text = 'Restarted'
                         $CB2.IsChecked = $false
                        }
                   else 
                        {
                         $TB2STG.text = 'Busy'
                        }
                }
            if ($CB3.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 2 3) -eq 0)
                        {  
                         (RestartEngines 2 3)
                         $TB3STG.text = 'Restarted'
                         $CB3.IsChecked = $false
                        }
                   else 
                        {
                         $TB3STG.text = 'Busy'
                        }
                }
        
         
            if ($CB4.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 2 4) -eq 0)
                        {  
                         (RestartEngines 2 4)
                         $TB4STG.text = 'Restarted'
                         $CB4.IsChecked = $false

                        }
                   else 
                        {
                         $TB4TG.text = 'Busy'
                        }
                }
         }
# PreProd
if ($CBPreProd.ischecked -eq $true)
        {
            if ($CBLive.IsChecked -eq $true)
                {
                   if((SQLEngineCheck 3 1) -eq 0)
                        {  
                         (RestartEngines 3 1)
                         $TBPreProd.text = 'Restarted'
                         $CBLive.IsChecked = $false
                        }
                   else 
                        {
                         $TBPreProd.text = 'Busy'
                        }
                }
        
            if ($CB2.IsChecked -eq $true)
               {
                   if((SQLEngineCheck 3 2) -eq 0)
                        {  
                         (RestartEngines 3 2)
                         $TB2PreProd.text = 'Restarted'
                         $CB2.IsChecked = $false
                        }
                   else 
                        {
                         $TB2PreProd.text = 'Busy'
                        }
                }
            if ($CB3.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 3 3) -eq 0)
                        {  
                         (RestartEngines 3 3)
                         $TB3PreProd.text = 'Restarted'
                         $CB3.IsChecked = $false
                        }
                   else 
                        {
                         $TB3PreProd.text = 'Busy'
                        }
                }
         
            if ($CB4.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 3 4) -eq 0)
                        {  
                         (RestartEngines 3 4)
                         $TB4PreProd.text = 'Restarted'
                         $CB4.IsChecked = $false

                        }
                   else 
                        {
                         $TB4PreProd.text = 'Busy'
                        }
                }      
        }  

# Prod
if ($CBProd.ischecked -eq $true)
        {
            if ($CBLive.IsChecked -eq $true)
                {
                   if((SQLEngineCheck 4 1) -eq 0)
                        {  
                         (RestartEngines 4 1)
                         $TBProd.text = 'Restarted'
                         $CBLive.IsChecked = $false
                        }
                   else 
                        {
                         $TBProd.text = 'Busy'
                        }
                }
        
            if ($CB2.IsChecked -eq $true)
               {
                   if((SQLEngineCheck 4 2) -eq 0)
                        {  
                         (RestartEngines 4 2)
                         $TB2Prod.text = 'Restarted'
                         $CB2.IsChecked = $false
                        }
                   else 
                        {
                         $TB2Prod.text = 'Busy'
                        }
                }
            if ($CB3.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 4 3) -eq 0)
                        {  
                         (RestartEngines 4 3)
                         $TB3Prod.text = 'Restarted'
                         $CB3.IsChecked = $false
                        }
                   else 
                        {
                         $TB3Prod.text = 'Busy'
                        }
                }
         
            if ($CB4.IsChecked -eq $true)
                {
                    if((SQLEngineCheck 4 4) -eq 0)
                        {  
                         (RestartEngines 4 4)
                         $TB4Prod.text = 'Restarted'
                         $CB4.IsChecked = $false

                        }
                   else 
                        {
                         $TB4Prod.text = 'Busy'
                        }
                }

        }  

        sleep -s 1
        
        $retries.text = $retries.Text - 1 
       
        }  while ($retries.Text -gt 0)
     
})
     #$form.Close()})



#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan 
$Form.ShowDialog() | out-null

