@echo off
:prompt
echo Do you want to run the program as a Server[s] or as a Client[c]?
set /P runningType=""
IF "%runningType%"=="s" (
	echo Loading program...
	pause
	cd ChatServer
	cd application.windows64
	ChatServer.exe
) ELSE (
	IF "%runningType%"=="c" (
		echo Loading program...
		pause
		cd ChatClient
		cd application.windows64
		ChatClient.exe
	) ELSE (
		GOTO prompt
	)
)