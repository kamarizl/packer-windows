
::Turning off User Account Control (UAC)
%SystemRoot%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

::Set Execution Policy 32/64 Bit
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"
C:\Windows\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"
::C:\Windows\System32\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"


::Setting the Network Location to private
powershell -File a:\fixnetwork.ps1

::Changing remote UAC account policy
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

:: Configure WinRM
start "" /WAIT cmd.exe /c net stop winrm
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig -transport:http
cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"}
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="2048"}
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"}
cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"}
cmd.exe /c winrm set winrm/config/client/auth @{Basic="true"}
cmd.exe /c winrm set winrm/config/listener?Address=*+Transport=HTTP @{Port="5985"}

:: Fire up WinRM!
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm

::Opening WinRM port 5985 on the firewall
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall add portopening TCP 5985 "Port 5985"

::Disable Hibernation
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateFileSizePercent /t REG_DWORD /d 0 /f
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateEnabled /t REG_DWORD /d 0 /f

::Disable password expiration for vagrant user
cmd.exe /c wmic useraccount where "name='vagrant'" set PasswordExpires=FALSE

::Disabling new network prompt
%SystemRoot%\System32\reg.exe add "HKLM\System\CurrentControlSet\Control\Network\NewNetworkWindowOff"



