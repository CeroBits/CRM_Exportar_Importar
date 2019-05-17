Import-Module *PATH*\SolutionAutomation\Cdmlet\Import_Solution_BH.dll
Function LogWrite
				{
				   Param ([string]$logstring)
				   Add-content $Logfile -value $logstring
				}
Try{
	[xml]$XmlDocument = Get-Content -Path "*PATH*\SolutionAutomation\Importar\AuthFileConnectionDataImport.xml"	
	$rootFolder =  "*PATH*\SolutionAutomation\Importar\"
	$destination = "*PATH*\SolutionAutomation\Importar\Soluciones_Importadas"
	$crmUrl = $XmlDocument.Authentication.crmUrl
	$organization=$XmlDocument.Authentication.organization
	$rootFolder =  "*PATH*\SolutionAutomation\Importar\Soluciones_a_importar"		
	Get-childitem -path $rootFolder -Filter *.zip | Sort CreationTime  | Foreach-object {
			$DateStr= Get-Date
			$filePath = $_.FullName
			$fileName = $_.BaseName
			$Logfile = "*PATH*\SolutionAutomation\Logs\$fileName.txt"
			write-host "------------$DateStr------------"
			LogWrite "------------$DateStr------------"
			Write-host "Se encontro la solucion $fileName"
			LogWrite "Se encontro la solucion $fileName"
			Write-host "Importando Solucion..."
			LogWrite "Importando Solucion..."
			Get-Import_Solution_BH -ManagedSolutionLocation $filePath -CrmUrl $crmUrl -Organization $organization
			Write-host "Finaliza el proceso de importacion"
			LogWrite  "Finaliza el proceso de importacion"
			Write-host "Se mueve archivo a carpeta de Soluciones Importadas"
			Move-Item -Path $filePath -Destination $destination
			}
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    Write-host "Error: $ErrorMessage"
	LogWrite "---------------ERROR---------------"
	LogWrite "Error: $ErrorMessage"
	LogWrite "---------------ERROR---------------"
}
