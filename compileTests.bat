@ECHO OFF
setlocal EnableDelayedExpansion
TITLE Nadav183 JackOS TestCompiler

::Change the path to your nand2tetris\tools folder (absolute path required)
set compiler_folder=folder_path_here
::Change the path to your project 12 folder (absolute path required)
set project_folder=folder_path_here

::set tests folders (name of folder in which the test files are in, NOT ABSOLUTE PATH)
::folders must be in project 12 folder
::compiled files of every module will be placed in each folder
set exTests[0]=Pong
set exTests[1]=Game
set exTests[2]=Snake
::numTests - actual number of tests - 1
set numTests=2

echo ******************************************
echo ****** Nadav183 JackOS TestCompiler ******
echo.
echo This is an extension of the JackCompiler for Nand2Tetris
echo The program will call JackCompiler on the current folder
echo and then move all the xxx.vm files to their xxxTest folders.
echo and then will call JackCompiler on each xxxTest folder.
echo.
echo Please make sure of the following:
echo     1) compileTest.bat file is in the project 12 folder.
echo     2) All 8 OS class jack files are in the folder.
echo     3) All 8 xxxTest folders are in the folder.
echo     4) The path to JackCompiler and project folder were configured.
echo ******************************************
echo.
::Check if user wants to continue running the program
echo Compiler folder: %compiler_folder%
echo Project folder: %project_folder%
echo Is this correct?
goto askContinue

::If code will continue from here if user wants to run the program
:continue
call cls

echo ********** JackCompiler **********
echo Running JackCompiler on the current folder
call "%compiler_folder%\JackCompiler" "%project_folder%"
echo **********************************

echo.
echo Moving result vm files to their test folders:
echo.

Call :checkAndMove Array.vm, ArrayTest
Call :checkAndMove Keyboard.vm, KeyboardTest
Call :checkAndMove Math.vm, MathTest
Call :checkAndMove Memory.vm, MemoryTest
Call :checkAndMove Output.vm, OutputTest
Call :checkAndMove Screen.vm, ScreenTest
Call :checkAndMove String.vm, StringTest
Call :checkAndMove Sys.vm, SysTest

Call :compileExt

echo Program ended successfully
goto askContinue

::Code will jump here if user wanted to close the program
:endOfProgram
PAUSE
EXIT /B 0

:checkAndMove
::Checks if the requested file exists, if it does, moves it to the requested folder and compiles the folder
echo *************** %~1 ***************
echo Checking if %~1 exists in folder
if not exist "%project_folder%\%~1" (
	echo %~1 was not found.
	EXIT /B 0
)


for /l %%i in (0,1,%numtests%) do (
	echo copying vm file to !exTests[%%i]! external test folder
	call copy "%project_folder%\%~1" "%project_folder%\!exTests[%%i]!"
)

echo Moving %~1 to %~2:
move "%project_folder%\%~1" "%project_folder%\%~2"
echo Compiling %~2 folder:
call "%compiler_folder%\JackCompiler" "%project_folder%\%~2"
echo ***************************************
echo.
echo.
EXIT /B 0

:compileExt
::This will call JackCompiler on all external Test folders
for /l %%i in (0,1,%numtests%) do (
	echo ********** Compiling !exTests[%%i]! **********
	call "%compiler_folder%\JackCompiler" "%project_folder%\!exTests[%%i]!"
	echo **********************************************
	echo.
	echo.
)


EXIT /B 0

:askContinue
::This will prompt the user asking if they want to run the program (after showing them the requirements)
choice /m "Run JackCompiler? "
if %ERRORLEVEL%==1 goto continue
if %ERRORLEVEL%==2 goto endOfProgram
EXIT /B 0