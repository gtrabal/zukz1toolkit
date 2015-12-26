@echo off
color 21
echo.
echo -------------------------------------------------------------------------------
echo.
echo                          Zuk Z1 Toolkit 
echo.
echo                                                               Hecho por gtrabal
echo.
echo -------------------------------------------------------------------------------
echo.
echo test > %windir%/atest.txt
if exist %windir%\atest.txt goto :adminok ELSE goto :EXIT
echo.
echo.
echo ***    HA HABIDO UN ERROR     *** 
echo.
echo.
echo No eres administrador 
echo.
echo * o *
echo.
echo No has iniciado en administrador
echo.
echo.
echo ***    ERROR ERROR ERROR     ***
echo.
echo.
pause
goto :EXIT

:adminok
del %windir%\atest.txt
echo.
echo Este batch te ayudara a hacer muchas cosas en tu Zuk Z1.
echo.
echo. Has de tener esto para utilizar el batch:
echo.
echo   1. Has de tener los drivers.
echo   2. Has de tener la depuracion USB activada.
echo.
setlocal enableextensions
cd /d "%~dp0
if /i NOT EXIST %windir%\adb.exe copy adb.exe %windir%
if /i NOT EXIST %windir%\AdbWinApi.dll copy AdbWinApi.dll %windir%
if /i NOT EXIST %windir%\AdbWinUsbApi.dll copy AdbWinUsbApi.dll %windir%
if /i NOT EXIST %windir%\fastboot.exe copy fastboot.exe %windir%
if /i NOT EXIST %windir%\wget.exe copy wget.exe %windir%
echo.
echo Comprobando conectividad ADB....
echo.
adb kill-server
adb devices >nul
for /f "eol=; tokens=1,2,3,4 delims= " %%i in ('adb devices') do call :checkdev %%i
if /i "%check%"=="list" goto :driver-error
goto :exit

:checkdev

set check=%1
if /i "%check%"=="list" goto :EOF
if /i "%check:~0,-10%"=="MB" goto :menu
if /i "%check:~0,-10%"=="HT" goto :menu
if /i "%check:~0,-10%"=="SH" goto :menu
if /i "%check:~0,-10%"=="HS" goto :menu
if /i "%check:~0,-10%"=="HC" goto :menu
goto :menu

:menu
echo --------------------------------------------------------------------
echo.
echo      1. Desbloquear el bootloader
echo.
echo      2. Bloquear Bootloader
echo.
echo      3. Instalar TWRP
echo.
echo      4. Rootear Zuk Z1
echo.
echo      5. Instalar stock recovery
echo.
echo      6. Instalar imagen de fabrica
echo.
echo      7. Comandos de ADB y Fastboot
echo.
echo      8. Instalar Xposed
echo.
echo      9. Desinstalar Xposed
echo.
echo      10. Desinstalar Xposed en Brick-Bootloop
echo.
echo      0. Exit
echo.
echo --------------------------------------------------------------------
echo.
set /P d="[Que quieres hacer]"
echo.
if /i "%d%"=="1" goto :bootloader
if /i "%d%"=="2" goto :lockbootloader
if /i "%d%"=="3" goto :twrp
if /i "%d%"=="4" goto :root
if /i "%d%"=="5" goto :recoverystock
if /i "%d%"=="6" goto :imagenfabrica
if /i "%d%"=="7" goto :adbfastboot
if /i "%d%"=="8" goto :ixposed
if /i "%d%"=="9" goto :uxposed
if /i "%d%"=="10" goto :uxposedBB
if /i "%d%"=="0" goto :exit
goto :EXIT


:driver-error
echo.
echo.
echo ***ERROR ERROR ERROR***
echo No has conectado el pc
echo O 
echo No tienes los drivers instalados
echo OR
echo La depuracion usb no esta activada.
echo ***ERROR ERROR ERROR***
echo.
echo.
pause
echo.
echo.
echo Vamos a instalar los drivers y activar la depuracion usb.
echo.
echo.
goto :menu2

:menu2
echo --------------------------------------------------------------------
echo.
echo      1. Instalar los Drivers del Zuk Z1
echo.
echo      2. Activar depuracion USB
echo.
echo      3. Hacer la prueba de ADB y acceder al menu principal.
echo.
echo      4. Salir del toolkit
echo.
echo --------------------------------------------------------------------
echo.
set /P d="[Que quieres hacer]"
echo.
if /i "%d%"=="1" goto :drivers
if /i "%d%"=="2" goto :depusb
if /i "%d%"=="3" goto :adbprueba
if /i "%d%"=="4" goto :exit
goto :EXIT

:drivers

echo Con este proceso vamos a instalar los drivers del Zuk Z1 muy rapidamente.
echo.
echo No hay requisitos para hacer este proceso.
start Drivers/ZUK_Z1_Drivers.msi
echo Seguid los pasos de la instalacion y eso es todo en este paso ;).
pause
echo.
echo Si tienes activada la depuracion usb que es la segunda opcion del toolkit
echo haz una prueba para comprobar si detecta el dispositivo y asi poder hacer el
echo resto de opciones del toolkit.
echo.
echo.
goto :menu2

:depusb

echo Para activar la depuracion usb seguid estos pasos:
echo.
echo 1- Id a Ajustes --> Info del telefono --> 7 clics en numero de compilacion.
echo.
echo 2- Ve a ajustes de nuevo y ve a ajustes del desarrollador.
echo.
echo 3- Una vez estes ahi, activa la depuracion usb y eso es todo.
echo.
echo.
pause
goto :menu2

:adbprueba

echo Si estas aqui, debes haber instalado los drivers y tener la depuracion usb activada.
echo.
echo.
echo Cumples los requisitos para continuar?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :adbpruebac
IF /I '%INPUT%'=='2' GOTO :menu2

:adbpruebac

echo Vamos a hacer la prueba. Entonces, cuando el toolkit ejecute los comandos adecuados
echo saldra una ventana flotante para comprobar si este pc es seguro para ejecutar
echo los comandos de adb. Tenerlo en cuenta.
pause
adb kill-server
adb devices >nul
for /f "eol=; tokens=1,2,3,4 delims= " %%i in ('adb devices') do call :checkdev %%i
if /i "%check%"=="list" goto :driver-error
goto :menu

:bootloader

echo.
echo Con este proceso vamos a desbloquear el bootloader del Zuk Z1
echo.
echo Con este proceso pierdes los datos. Mucha alerta.
pause
goto :bootloader1

:bootloader1

echo Si cumples los requisitos anteriores ya tienes un paso hecho para desbloquear el bootloader.
echo.
echo Para desbloquear el bootloader hay que tener la opcion OEM Unlock.
echo.
echo.
echo Tienes activada la opcion OEM Unlock?

echo 1- Si.
echo.
echo 2- No.

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :bootloaderC
IF /I '%INPUT%'=='2' GOTO :oemunlock

:oemunlock

echo Para activar la opcion OEMUnlock seguid estos pasos:
echo.
echo 1- Id a Ajustes --> Info del telefono --> 7 clics en numero de compilacion.
echo.
echo 2- Ve a ajustes de nuevo y ve a ajustes del desarrollador.
echo.
echo 3- Una vez estes ahi, activa la opcion OEM Unlock, y eso es todo.
echo.
echo.
echo Una vez lo hayas hecho, haz clic para continuar el proceso.
pause
goto :bootloaderC

:bootloaderC

echo Ahora que nos has confirmado que cumples los requisitos, vamos a desbloquear el bootloader.
pause
adb devices
adb wait-for-device
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c oem unlock-go
echo Y eso es todo; una vez hecho esto el dispositivo se reiniciara y ya tendras el bootloader desbloqueado.
echo.
echo Ahora tienes que activar la depuracion usb; y eso es todo :D.
pause
echo Sabes activar la depuracion usb?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :menu
IF /I '%INPUT%'=='2' GOTO :depusb

:lockbootloader

echo En el paso vamos a bloquear el bootloader.
echo.
echo Cuando estés listo para proceder, haz clic en el toolkit para continuar.
pause
adb devices
adb wait-for-device
adb reboot bootloader
fastboot devices
fastboot oem lock
fastboot reboot
echo Una vez se reinicie ya no hay que hacer nada mas. Eso es todo ;).
pause
goto :menu

:twrp

echo El requisito para instalar el recovery TWRP es este:
echo.
echo.
echo 1- Tener el bootloader desbloqueado.
pause
echo Cumples el requisito?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :twrpinst
IF /I '%INPUT%'=='2' GOTO :menu

:twrpinst

echo En el paso anterior nos has confirmado que cumples los requisitos.
echo.
echo Asi que vamos a hacer el proceso rapidamente ;).
adb devices
adb wait-for-device
adb reboot bootloader
fastboot devices
fastboot flash recovery Recovery/TWRP.img
fastboot reboot
echo Una vez se reinicie ya no hay que hacer nada mas. Eso es todo ;).
pause
goto :menu

:recoverystock

echo El requisito para instalar el recovery stock es este:
echo.
echo.
echo 1- Tener el bootloader desbloqueado.
pause
echo Cumples el requisito?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :recstockinstall
IF /I '%INPUT%'=='2' GOTO :menu

:recstockinstall

echo En el paso anterior nos has confirmado que cumples los requisitos.
echo.
echo Asi que vamos a hacer el proceso rapidamente ;).
adb devices
adb wait-for-device
adb reboot bootloader
fastboot devices
fastboot flash recovery Recovery/stock.img
fastboot reboot
echo Una vez se reinicie ya no hay que hacer nada mas. Eso es todo ;).
pause
goto :menu

:root

echo El requisito para rootear el Zuk Z1 es el siguiente:
echo.
echo.
echo 1- Tener el bootloader desbloqueado.
pause
echo Cumples el requisito?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :rootz1
IF /I '%INPUT%'=='2' GOTO :menu

:rootz1

echo Ahora necesitamos saber si tienes el recovery TWRP instalado.
echo.
echo.
echo Tienes instalado el recovery TWRP?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :roottwrp
IF /I '%INPUT%'=='2' GOTO :rootboottwrp

:roottwrp

echo Una vez ya confirmado que tienes los requisitos para rootear; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Root/SuperSU-2.46.zip /sdcard/
adb reboot recovery
echo.
echo Ahora seguid estos faciles pasos para rootear el Zuk Z1.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo SuperSU-2.46.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal rooteado.
pause
goto :menu

:rootboottwrp

echo Una vez ya confirmado que tienes los requisitos para rootear; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Root/SuperSU-2.46.zip /sdcard/
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c boot Recovery/TWRP.img
echo Ahora con el booteo se reiniciara al recovery, el proceso tarda de 30s a 1min.
echo.
echo Sed pacientes... Cuando se haya reiniciado al recovery haced clic para continuar.
pause
echo.
echo Ahora seguid estos faciles pasos para rootear el Zuk Z1.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo SuperSU-2.46.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal rooteado.
pause
goto :menu

:imagenfabrica

echo Con este proceso vamos a instalar la imagen de fabrica rapidamente.
echo.
echo.
echo No hay ningun requisito para usar este proceso.
echo.
echo.
echo Con este proceso vas a PERDER TOOOOODOS LOS DATOS.
echo.
echo El primer paso sera la descarga de la rom y despues flashearemos la imagen de fabrica.
pause
wget http://builds.cyngn.com/factory/ham/cm-12.1-YOG4PAS3OH-ham-signed-fastboot.zip -O Cyanogen/cm-12.1-YOG4PAS3OH-ham-signed-fastboot.zip
cd Cyanogen
7za.exe x cm-12.1-YOG4PAS3OH-ham-signed-fastboot.zip
cd ..
echo Cuando se haya descargado, haz clic para continuar.
pause
adb devices
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c flash Cyanogen/persist persist.img
fastboot -i 0x2b4c flash Cyanogen/modem NON-HLOS.bin
fastboot -i 0x2b4c flash Cyanogen/sbl1 sbl1.mbn
fastboot -i 0x2b4c flash Cyanogen/dbi sdi.mbn
fastboot -i 0x2b4c flash Cyanogen/aboot emmc_appsboot.mbn
fastboot -i 0x2b4c flash Cyanogen/rpm rpm.mbn
fastboot -i 0x2b4c flash Cyanogen/splash splash.img
fastboot -i 0x2b4c flash Cyanogen/tz tz.mbn
fastboot -i 0x2b4c flash Cyanogen/boot boot.img
fastboot -i 0x2b4c flash Cyanogen/recovery recovery.img
fastboot -i 0x2b4c flash Cyanogen/system system.img
fastboot -i 0x2b4c flash Cyanogen/cache cache.img
fastboot -i 0x2b4c flash Cyanogen/userdata userdata_64G.img
echo Ahora el dispositivo se reiniciara y eso es todo. Recuerda activar la depuracion usb cuando se haya iniciado.
echo.
echo.
echo Sabes activar la depuracion usb?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :menu
IF /I '%INPUT%'=='2' GOTO :depusb

:ixposed

echo Los requisitos para poder instalar xposed al Zuk Z1 son esos:
echo.
echo.
echo 1- Tener el bootloader desbloqueado.
echo.
echo 2- Tener root
echo.
echo Cumples los requisitos?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :ixposed1
IF /I '%INPUT%'=='2' GOTO :menu

:ixposed1

echo Ahora necesitamos saber si tienes el recovery TWRP instalado.
echo.
echo.
echo Tienes instalado el recovery TWRP?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :ixposedtwrp
IF /I '%INPUT%'=='2' GOTO :ixposedboottwrp

:ixposedtwrp

echo Una vez ya confirmado que tienes los requisitos para instalar xposed; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Xposed/xposed.zip /sdcard/
adb reboot recovery
echo.
echo Ahora seguid estos faciles pasos para instalar xposed.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo xposed.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed instalado.
pause
goto :menu

:rootboottwrp

echo Una vez ya confirmado que tienes los requisitos para instalar xposed; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Xposed/xposed.zip /sdcard/
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c boot Recovery/TWRP.img
echo Ahora con el booteo se reiniciara al recovery, el proceso tarda de 30s a 1min.
echo.
echo Sed pacientes... Cuando se haya reiniciado al recovery haced clic para continuar.
pause
echo.
echo Ahora seguid estos faciles pasos para instalar xposed.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo xposed.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed instalado.
pause
goto :menu

:uxposed

echo Los requisitos para poder desinstalar xposed al Zuk Z1 son esos:
echo.
echo.
echo 1- Tener el bootloader desbloqueado.
echo.
echo 2- Tener root
echo.
echo Cumples los requisitos?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :uxposed1
IF /I '%INPUT%'=='2' GOTO :menu

:uxposed1

echo Ahora necesitamos saber si tienes el recovery TWRP instalado.
echo.
echo.
echo Tienes instalado el recovery TWRP?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :uxposedtwrp
IF /I '%INPUT%'=='2' GOTO :uxposedboottwrp

:uxposedtwrp

echo Una vez ya confirmado que tienes los requisitos para desinstalar xposed; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Xposed/xposeduninstall.zip /sdcard/
adb reboot recovery
echo.
echo Ahora seguid estos faciles pasos para instalar xposed.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo xposeduninstall.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed desinstalado.
pause
goto :menu

:rootboottwrp

echo Una vez ya confirmado que tienes los requisitos para desinstalar xposed; vamos alla.
echo.
echo El proceso no es al 100% automatico pero vamos a detallar los pasos.
echo.
adb devices
adb push Xposed/xposeduninstall.zip /sdcard/
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c boot Recovery/TWRP.img
echo Ahora con el booteo se reiniciara al recovery, el proceso tarda de 30s a 1min.
echo.
echo Sed pacientes... Cuando se haya reiniciado al recovery haced clic para continuar.
pause
echo.
echo Ahora seguid estos faciles pasos para instalar xposed.
echo.
echo 1- Ve a install
echo.
echo 2- Selecciona el archivo xposeduninstall.zip
echo.
echo 3- Desliza de izquierda a derecha donde pone Swipe to confirm flash.
echo.
echo 4- Cuando se haya flasheado selecciona Reboot system.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed desinstalado.
pause
goto :menu

:uxposedBB
echo.
echo Si por desgracia por culpa del xposed teneis el terminal brickeado; sigue estos
echo pasos para revivirlo.
echo.
echo.
echo Tienes instalado el recovery TWRP?

echo 1- Si.
echo.
echo 2- No

SET INPUT=
SET /P INPUT=- Ingresa la opcion deseada: 

IF /I '%INPUT%'=='1' GOTO :uxposedtwrpBB
IF /I '%INPUT%'=='2' GOTO :uxposedboottwrpBB

:uxposedtwrpBB

echo El proceso no es manual pero vamos a detallar los pasos para facilitarlo lo maximo posible.
echo.
echo 1- Pulsa vol+ mas power durante varios segundos para acceder a TWRP
echo.
echo Una vez estes ahí sigue los pasos siguientes:
echo.
echo 2- Ve a advanced --> adb sideload.
echo.
echo Ahora vamos a desinstalar xposed. Selecciona cualquier boton para continuar.
pause
echo.
adb sideload Xposed/xposeduninstall.zip
echo.
echo Una vez flasheado el archivo seleccionad reboot system y se reiniciara el dispositivo.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed desinstalado y sin brick.
pause
goto :menu

:rootboottwrpBB

echo El proceso no es manual pero vamos a detallar los pasos para facilitarlo lo maximo posible.
echo.
echo 1- Pulsa vol- mas power durante varios segundos para acceder al bootloader.
echo.
pause
fastboot devices
fastboot -i 0x2b4c boot Recovery/TWRP.img
echo Ahora con el booteo se reiniciara al recovery, el proceso tarda de 30s a 1min.
echo.
echo Sed pacientes... Cuando se haya reiniciado al recovery haced clic para continuar.
pause
echo.
echo Ahora seguid estos faciles pasos para instalar xposed.
echo.
echo 1- Ve a advanced --> adb sideload.
echo.
echo Ahora vamos a desinstalar xposed. Selecciona cualquier boton para continuar.
pause
echo.
adb sideload Xposed/xposeduninstall.zip
echo.
echo Una vez flasheado el archivo seleccionad reboot system y se reiniciara el dispositivo.
echo.
echo Y eso es todo :D.
echo.
echo Ahora se reiniciara y ya tendreis el terminal con xposed desinstalado y sin brick.
pause
goto :menu

:adbfastboot

echo --------------------------------------------------------------------
echo.
echo      1. Reiniciar el terminal.
echo.
echo      2. Reiniciar al recovery
echo.
echo      3. Reiniciar al bootloader
echo.
echo      4. Reinicio Fastboot --> Recovery
echo.
echo      5. Reinicio Fastboot --> System
echo.
echo      6. Bootear TWRP
echo.
echo      7. Bootear recovery stock
echo.
echo      8. Adb devices
echo.
echo      9. Adb sideload
echo.
echo      10. Backup del sistema
echo.
echo      11. Restore de sistema
echo.
echo      12. Menu 2
echo.
echo      13. Ir al menu principal.
echo.
echo      0. Exit
echo.
echo --------------------------------------------------------------------
echo.
set /P d="[Que quieres hacer]"
echo.
if /i "%d%"=="1" goto :reboot
if /i "%d%"=="2" goto :recovery
if /i "%d%"=="3" goto :bootloader
if /i "%d%"=="4" goto :fastrec
if /i "%d%"=="5" goto :fastsyst
if /i "%d%"=="6" goto :boottwrp
if /i "%d%"=="7" goto :bootstock
if /i "%d%"=="8" goto :devices
if /i "%d%"=="9" goto :sideload
if /i "%d%"=="10" goto :backup
if /i "%d%"=="11" goto :restore
if /i "%d%"=="12" goto :adbfastboot2
if /i "%d%"=="13" goto :menu
if /i "%d%"=="0" goto :exit

:reboot

echo Vamos a reiniciar el sistema con este comando.
adb reboot
pause
goto adbfastboot

:recovery

echo Vamos a reiniciar al recovery con este comando.
adb reboot recovery
pause
goto adbfastboot

:bootloader

echo Vamos a reiniciar al bootloader con este comando.
adb reboot bootloader
pause
goto adbfastboot

:fastrec

echo Vamos a hacer un reinicio al recovery desde el modo fastboot.
fastboot -i 0x2b4c reboot recovery
pause
goto adbfastboot

:fastsyst

echo Vamos a hacer un reinicio al recovery desde el modo fastboot.
fastboot -i 0x2b4c reboot
pause
goto adbfastboot

:boottwrp

echo Vamos a reiniciar al bootloader para bootear el recovery
echo y ahi lo booteamos; una vez hecho, esperad 30s a 1min y entrareis al recovery.
adb devices
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c boot Recovery/TWRP.img
pause
goto adbfastboot

:bootstock

echo Vamos a reiniciar al bootloader para bootear el recovery
echo y ahi lo booteamos; una vez hecho, esperad 30s a 1min y entrareis al recovery.
adb devices
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c boot Recovery/stock.img
pause
goto adbfastboot

:backup

echo Vamos a hacer una copia de seguridad de todo el terminal.
echo.
echo Se hace copia de seguridad de:
echo.
echo.
echo  - Apps (Sistema y normales)
echo.
echo  - Memoria interna
echo.
echo  - Paquetes (ej: com.google.android.apps.plus)
echo.
echo.
pause
adb devices
mkdir Backup
adb backup -all -f Backup/backup.ab
echo Ahora te pedira que desbloquees el terminal y que aceptes para hacer el backup.
echo.
echo Eso es todo :D
pause
goto adbfastboot

:restore

echo Ahora vamos a hacer el restore del terminal.
echo.
echo El unico requisito es tener el backup ya hecho.
pause
adb devices
adb restore Backup/backup.ab
echo Ahora te pedira que desbloquees el terminal y que aceptes para hacer el restore,
echo entonces, cuando haya acabado el terminal se reiniciará y eso es todo :D.
pause
goto adbfastboot

:devices

echo Vamos a ejecutar el comando adb devices para saber si el movil esta bien conectado
echo al pc con depuracion usb y drivers para hacer otros procesos del cual necesita
echo que este bien conectado
pause
adb devices
echo Eso es todo :)
pause
goto adbfastboot

:sideload

mkdir sideload
echo Para ejecutar este comando hay que estar en el recovery en el modo sideload.
echo.
echo Vamos a poner los pasos para acceder a este menu en cwm/philz y twrp:
echo.
echo.
echo TWRP: Advanced --> ADB Sideload
echo.
echo CWM/PHILZ: Install zip --> Install zip from sideload
echo.
echo.
echo Pon el archivo a flashear en la carpeta sideload.
pause
set /p siderom=Pon el nombre del archivo(sin el .zip):
adb sideload sideload\%siderom%.zip
echo.
echo Ahora se flashearia el archivo. Explicamos los pasos posteriores al sideload que es
echo el reinicio "despues de flashear una rom o un zip (es normalmente), porque en algunas
echo roms hay que hacer wipe cache/dalvik cache, y no es general al 100%"
echo.
echo.
echo TWRP: Reboot system.
echo.
echo CWM: Ir al menu principal y reboot system now.
pause
goto adbsideload

:adbfastboot2

echo --------------------------------------------------------------------
echo.
echo      1. Informacion del estado del bootloader
echo.
echo      2. Copiar un archivo al movil
echo.
echo      3. Instalar un kernel
echo.
echo      4. Hacer wipe cache desde fastboot
echo.
echo      5. Instalar una radio "no radio fm"
echo.
echo      6. Instalar una app.
echo.
echo      7. Hacer logcat
echo.
echo      8. Cambiar el bootanimation
echo.
echo      9. Restaurar desde fabrica desde fastboot
echo.
echo      10. Menu 1
echo.
echo      11. Menu del toolkit
echo.
echo      0. Exit
echo.
echo --------------------------------------------------------------------
echo.
set /P d="[Que quieres hacer]"
echo.
if /i "%d%"=="1" goto :infoboot
if /i "%d%"=="2" goto :copiarmovil
if /i "%d%"=="3" goto :kernel
if /i "%d%"=="4" goto :wipecache
if /i "%d%"=="5" goto :radio
if /i "%d%"=="6" goto :instalarapp
if /i "%d%"=="7" goto :logcat
if /i "%d%"=="8" goto :bootanimation
if /i "%d%"=="9" goto :restaurarfabrica
if /i "%d%"=="10" goto :adbfastboot
if /i "%d%"=="11" goto :menu
if /i "%d%"=="0" goto :exit

:infoboot

echo Vamos a saber la informacion del estado del bootloader con esta opcion.
pause
adb devices
adb reboot bootloader
fastboot devices
fastboot -i 0x2b4c oem device-info
echo Esa es la informacion del estado del bootloader.
echo.
echo Cuando quieras haz clic en el toolkit para reiniciar el smartphone.
pause
fastboot reboot
goto adbfastboot2

:copiarmovil

echo En este proceso vamos a copiar un archivo al movil.
mkdir copiar
echo.
echo Pon el archivo en la carpeta copiar.
pause
set /p copy=Pon el nombre de tu archivo (con la extension): 
main\adb.exe push copy/%copy% sdcard/
echo Eso es todo :)
pause
goto adbfastboot2

:kernel

echo Con este proceso vamos a instalar un kernel.
mkdir kernel
echo Pon el kernel en la carpeta kernel.
pause
adb devices
adb reboot bootloader
fastboot devices
set /p kernel=Pon el nombre del kernel a flashear (sin la extension):
fastboot flash boot kernel\%kernel%.img
fastboot erase cache
fastboot reboot
echo Eso es todo :)
pause
goto adbfastboot2

:wipecache

echo Vamos a hacer un wipe cache muy rapidamente.
adb devices
adb reboot bootloader
fastboot devices
fastboot erase cache
fastboot reboot
echo Eso es todo :)
pause
goto adbfastboot2

:radio

echo Con este proceso vamos a instalar una radio.
mkdir radio
echo Pon la radio en la carpeta radio.
pause
adb devices
adb reboot bootloader
fastboot devices
set /p radio=Pon el nombre de la radio a flashear (sin la extension):
fastboot flash boot radio\%radio%.img
fastboot erase cache
fastboot reboot
echo Eso es todo :)
pause
goto adbfastboot2

:instalarapp

echo Con este proceso vamos a instalar una app.
mkdir instalarapp
echo Pon la app en la carpeta instalarapp
pause
adb devices
set /p instalarapp=Pon el nombre de la app a instalar (sin la extension):
adb install instalarapp\%instalarapp%.apk
echo Eso es todo :)
pause
goto adbfastboot2

:logcat

echo Con este proceso vamos a hacer un logcat, o sea, crear un txt con la informacion
echo de un problema de sistema. Si has seleccionado esta opcion es porque quieres reportar
echo o evidenciar un error de sistema.
pause
set /p problema=Pon el nombre del problema que tengas en tu movil (sin la extensiont txt):
adb logcat -v long > %problema%.txt
echo Eso es todo, ahora tendras un txt con la descripcion del problema.
pause
goto adbfastboot2

:bootanimation

echo Hay un requisito para usar este paso:
echo.
echo Pon el sistema en r/w, de lo contrario, no funcionara.
pause
mkdir bootanimation
echo Renombra el archivo a bootanimation.zip "si no, no funcionara" ya
echo mueve el archivo a la carpeta bootanimation.
adb push bootanimation\bootanimation.zip /system/media/bootanimation.zip
echo Eso es todo, ahora solo hay que reiniciar el dispositivo y finito :).
pause
adb reboot
goto adbfastboot

:restaurarfabrica

echo Vamos a restaurar el sistema con esta opcion:
adb devices
adb reboot bootloader
fastboot devices
fastboot erase cache
fastboot erase data
fastboot reboot
echo Eso es todo :)
pause
goto adbfastboot2

:exit

echo Muchas gracias por utilizar este toolkit; espero que te haya servido. Salu2.
echo.
echo Si ha habido algun problema pueden consultar conmigo en multiroot o en htcmania mediante un mp.
pause
exit
