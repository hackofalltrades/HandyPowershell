function popup {

 

param(

    [String] $Title,

    [String] $Message

)

 

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null

[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null

[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

 

$APP_ID = 'Your IT Team name'

 

$template = @"

<toast>

    <visual>

        <binding template='ToastImageAndText02'>

            <text id="1">$($Title)</text>

            <text id="2">$($Message)</text>

            <image id='1' src='file:///c:/users/$env:Username/Appdata/Local/logo.png' />

        </binding>

    </visual>

</toast>

"@

 

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument

$xml.LoadXml($template)

$toast = New-Object Windows.UI.Notifications.ToastNotification $xml

[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($APP_ID).Show($toast)

}

 

 

##############################################

#Get Disk Space

##############################################

$OS = Get-WMiobject -Class Win32_operatingsystem

$info = Get-WMIObject Win32_Logicaldisk -filter "deviceid='$($os.systemdrive)'"

$Free = $info.freespace/1000000000

 

if ($free -lt 100000){

#Toast Notification Begin

popup "

 
