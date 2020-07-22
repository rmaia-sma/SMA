########## Start documenting here ##########
param (
	$Schedule="",															# Schedule name for the report
	$ReportPath="C:\Temp",												# Placeholder for the PDF file. Replace with your value, if desired.
	$BirtCmdLine="C:\Program Files\OpConxps\Utilities\BIRTRptGen.exe",	# Command line for for BIRTRptGen.exe
	$ReportName="",														# Report code in OpCon; gonna be used as part of the file name
	$SkdDateIni="",															# Date or Initial date for the report
	$SkdDateEnd="",														# End date for the report; if not provided, assumes it's only the initial date
	$to="smademos@smatechnologies.com",								# To for the email. Replace with your value, if desired.
	$password,																# Password for the email authentication
	$SkdDate="",															# Variable that will contain the Date/Date Range
	$SkdID="",																# Name of the schedule and the -pSKDID= parameter
	$History_SkdDate="",													# Date for History information
	$DeptID="",															# DeptID for the report
	$SendEmail,															# Send and email or not (true or false)
	$smtp="smtp.office365.com",											# Email server smtp. Replace with your value, if desired.
	$from="smademos@smatechnologies.com",							# From for the email. Replace with your value, if desired.
	$user="smademos@smatechnologies.com",							# User login for the email authentication. Replace with your value, if desired.
	$port=587,       															# Port for the email config. Replace with your value, if desired.
	$body="Attached file contains the result of the requested report. `r`n" 	#Body of the email. Replace with your value, if desired.
)

########## Getting Sechedule ID based on Schedule Name ##########
$SkdID   ='"SKDID='   + $Schedule   + '"'

########## Checking Date ########## 
if ($SkdDateIni -eq $SkdDateEnd)
	{
		$SkdDate ='"SKDDATE=' + $SkdDateIni   + '"'
		$History_SkdDate ='"HISTORY_SKDDATE=' + $SkdDateIni   + '"'
	}
if ($SkdDateEnd -eq "")
	{
		$SkdDate ='"SKDDATE=' + $SkdDateIni   + '"'
		$History_SkdDate ='"HISTORY_SKDDATE=' + $SkdDateIni   + '"'
	}

if ($SkdDateEnd -ne "")
	{
		$SkdDate ='"SKDDATE=' + $SkdDateIni   + ' to ' + $SkdDateEnd  + '"'
		$History_SkdDate ='"HISTORY_SKDDATE=' + $SkdDateIni   + ' to ' + $SkdDateEnd  + '"'
	}

$DeptID = '"DEPTID>0"'
Write-Host "History Date is: $History_SkdDate `r`n"

########## Running BIRT ##########
######## Check the location of your BIRTRptGen.exe program and replace the path in the command line if needed ########
######## The file name for the report is the report name. Change it in the -o"$ReportPath\$ReportName.pdf" parameter, if needed ########
&"$BirtCmdLine" -r"$ReportName" -p"$SkdID" -p"$SkdDate" -p"$DeptID" -p"$History_SkdDate" -o"$ReportPath\$ReportName.pdf"
Write-Host "Exit Code for BIRT is: $LastExitCode `r`n"
########## Checking the Exit Code for BIRT and exiting the script if not 0 ##########
if ($LastExitCode -ne 0)
	{
		Exit $LastExitCode
	}

if ($SendEmail -eq "Yes")
{
    ########## Send email if $SendEmail is true ########## 
    $subject = "OpCon Report: $Reportname"
    $secpasswd = ConvertTo-SecureString "$password" -AsPlainText -Force
    $mycreds = New-Object System.Management.Automation.PSCredential ($user, $secpasswd) 
    $Attachment="$ReportPath" + "\" + "$ReportName.pdf"
    Send-MailMessage -SmtpServer $smtp -To $to -From $from -Subject $subject -Body $body -BodyAsHtml -UseSSL -Attachment $Attachment -Credential $mycreds -Port $port
}
