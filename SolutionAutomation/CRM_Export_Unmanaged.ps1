Import-Module *PATH*\SolutionAutomation\Cdmlet\Export_Solution_BH.dll

Function LogWrite
				{
				   Param ([string]$logstring)
				   Add-content $Logfile -value $logstring
				}
Try{
	#Update name of solution in below line
	$solutionToExport = "*PATH*\SolutionAutomation\Exportar\SolucionesExportar.xml"
	$Managed= $FALSE
	$rootFolder =  "*PATH*\SolutionAutomation\Importar\Soluciones_a_importar\"	
	[xml]$XmlDocument = Get-Content -Path "*PATH*\SolutionAutomation\Exportar\AuthFileConnectionDataExport.xml"	
	$crmUrl = $XmlDocument.Authentication.crmUrl
	$organization=$XmlDocument.Authentication.organization
	Get-Export_Solution_BH -SolutionCreatePath $rootFolder -SolutionToExport $solutionToExport -ManagedSolution $Managed -CrmUrl $crmUrl -Organization $organization			
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    Write-host "Error: $ErrorMessage"
	LogWrite "---------------ERROR---------------"
	LogWrite "Error: $ErrorMessage"
	LogWrite "---------------ERROR---------------"
}
