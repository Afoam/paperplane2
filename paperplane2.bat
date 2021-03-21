@echo off

: 
: Welcome to paperplane2!
: 
: paperplane2 is a continuation of my project paperplane that provides a modern solution to create a minecraft server on windows in minutes
: 
: Current paperplane Version = 2.0.0
: Current Minecraft Version - 1.16.5
: 
: https://github.com/afoam/paperplane2
: 


: config - set minimum, maximum ram and change server software

: Allocate memory (mb)
: RamMinimum must be at least 512mb
set RamMinimum=512
set RamMaximum=1024

: Change server software, choose from "vanilla", "craftbukkit", "spigot", "paper"*, "tuinity", "custom" (custom must be defined in :DefineURI)
set ServerPlatform=paper

: end of config

:DefineURI
    if "%ServerPlatform%" == "vanilla" (
        set ServerURI="https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
        )
    if "%ServerPlatform%" == "craftbukkit" (
        set uri="https://cdn.getbukkit.org/craftbukkit/craftbukkit-1.16.5.jar"
        goto Startup
        )
    if "%ServerPlatform%" == "spigot" (
        set uri="https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar"
        goto Startup
        )
    if "%ServerPlatform%" == "paper" (
        set uri="https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/549/downloads/paper-1.16.5-549.jar"
        goto Startup
        )
    if "%ServerPlatform%" == "tuinity" (
        set uri="https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/artifact/tuinity-paperclip.jar"
        goto Startup
        ) 
    if "%ServerPlatform%" == "custom" (
        set uri="https://example.com/file.jar"
        goto Startup
        ) else (
            echo Server platform "%ServerPlatform%" is invalid.
            goto CommonExit
        )

: generated with https://www.askapache.com/online-tools/figlet-ascii/ because i didnt want to install figlet
:Startup
    echo                                      __                     ______ 
    echo .-----.---.-.-----.-----.----.-----.^|  ^|.---.-.-----.-----.^|__    ^|
    echo ^|  _  ^|  _  ^|  _  ^|  -__^|   _^|  _  ^|^|  ^|^|  _  ^|     ^|  -__^|^|    __^|
    echo ^|   __^|___._^|   __^|_____^|__^| ^|   __^|^|__^|^|___._^|__^|__^|_____^|^|______^|
    echo ^|__^|        ^|__^|             ^|__^|    
    echo.
        goto ServerJarCheck

: checks if the specificed server jar is downloaded
:ServerJarCheck
    if exist "%ServerPlatform%.jar" (
        goto CustomMOTD
    ) else (
        powershell -Command "Invoke-WebRequest %uri% -OutFile %ServerPlatform%.jar"
        goto CustomMOTD
    )

: just a simpe motd
:CustomMOTD
    if exist "server.properties" (
       goto ServerStart
    ) else (
       break>"server.properties"
       echo motd=\u00A7rA Portable Minecraft Server\u00A7r\nPowered by \u00A71paperplane> server.properties
       goto ServerStart
       )

: starts server - define RamMinimum and RamMaximum in config 
:ServerStart
    java -jar -Xms%RamMinimum%m -Xmx%RamMaximum%m %ServerPlatform%.jar nogui
    goto CommonExit 

:CommonExit
    echo                                      __                     ______ 
    echo .-----.---.-.-----.-----.----.-----.^|  ^|.---.-.-----.-----.^|__    ^|
    echo ^|  _  ^|  _  ^|  _  ^|  -__^|   _^|  _  ^|^|  ^|^|  _  ^|     ^|  -__^|^|    __^|
    echo ^|   __^|___._^|   __^|_____^|__^| ^|   __^|^|__^|^|___._^|__^|__^|_____^|^|______^|
    echo ^|__^|        ^|__^|             ^|__^|    
    echo.
pause
exit