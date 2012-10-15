SETLOCAL ENABLEDELAYEDEXPANSION

set pwd = %cd%

set root=..\

set lessons=%root%lessons

set proj=%root%\langHM

set deploy=C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\nandp\lang

set jsfl=C:\Users\John\AppData\Local\Adobe\Flash CS5\en_US\Configuration\Commands\langHM.jsfl


REM  *****************LESSON 1**********************


rmdir /s /q "%deploy%\lesson1"
xcopy /i /y /s /q  "%lessons%\lesson1" "%deploy%\lesson1"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson1\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson1\vl1154s_glidereflection\vl1154s_glidereflection_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson1\vl1154s_glidereflection\vl1154s_glidereflection_files\!_file:~0,-10!.swf"
)



REM  *****************LESSON 2**********************


rmdir /s /q "%deploy%\lesson2"
xcopy /i /y /s /q  "%lessons%\lesson2" "%deploy%\lesson2"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson2\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson2\vl1081class1_es_es_takeawaystory\vl1081class1_es_es_takeawaystory_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson2\vl1081class1_es_es_takeawaystory\vl1081class1_es_es_takeawaystory_files\!_file:~0,-10!.swf"
)




REM  *****************LESSON 3**********************


rmdir /s /q "%deploy%\lesson3"
xcopy /i /y /s /q  "%lessons%\lesson3" "%deploy%\lesson3"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson3\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson3\vl1002class1_ordinalnumbers\vl1002class1_ordinalnumbers_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson3\vl1002class1_ordinalnumbers\vl1002class1_ordinalnumbers_files\!_file:~0,-10!.swf"
)



REM  *****************LESSON 4**********************


rmdir /s /q "%deploy%\lesson4"
xcopy /i /y /s /q  "%lessons%\lesson4" "%deploy%\lesson4"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson4\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson4\vl1005class2_repaddnumline\vl1005class2_repaddnumline_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson4\vl1005class2_repaddnumline\vl1005class2_repaddnumline_files\!_file:~0,-10!.swf"
)



REM  *****************LESSON 5**********************


rmdir /s /q "%deploy%\lesson5"
xcopy /i /y /s /q  "%lessons%\lesson5" "%deploy%\lesson5"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson5\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson5\vl1006class1_addnumlineten\vl1006class1_addnumlineten_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson5\vl1006class1_addnumlineten\vl1006class1_addnumlineten_files\!_file:~0,-10!.swf"
)




REM  *****************LESSON 6**********************


rmdir /s /q "%deploy%\lesson6"
xcopy /i /y /s /q  "%lessons%\lesson6" "%deploy%\lesson6"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson6\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson6\phyl10006_1101\phyl10006_1101_flas\*_LANG.swf" "%deploy%"
for /f %%d in ('dir "%deploy%\*_LANG.swf" /b') do (
	set _file=%%d 
	move "%deploy%\%%d" "%deploy%\lesson6\phyl10006_1101\phyl10006_1101_files\!_file:~0,-10!.swf"
)






REM  *********** CLEAN UP *******************

copy "%jsfl%" %root%\jsfl\langHM.jsfl

cd %deploy%

del /q /s *.fla *.zip *.mp3 *.flv *.pdf *.doc *.xls *.gif *.as *.jpg *.jpeg *.png


