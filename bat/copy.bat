SETLOCAL ENABLEDELAYEDEXPANSION

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
for /f "tokens=1-3 delims=_LANG" %%d in ('dir "%deploy%\*_LANG.swf" /b') do move "%deploy%\%%d_%%e_LANG.swf" "%deploy%\lesson1\vl1154s_glidereflection\vl1154s_glidereflection_files\%%d_%%e.swf"



REM  *****************LESSON 2**********************


rmdir /s /q "%deploy%\lesson2"
xcopy /i /y /s /q  "%lessons%\lesson2" "%deploy%\lesson2"
copy "%root%AS3 Template\content_player.swf" "%deploy%\lesson2\assets\players\content_player.swf"
xcopy /i /y /s /q "%lessons%\lesson2\vl1081class1_es_es_takeawaystory\vl1081class1_es_es_takeawaystory_flas\*_LANG.swf" "%deploy%"
for /f "tokens=1-3 delims=_LANG" %%d in ('dir "%deploy%\*_LANG.swf" /b') do move "%deploy%\%%d_%%e_LANG.swf" "%deploy%\lesson2\vl1081class1_es_es_takeawaystory\vl1081class1_es_es_takeawaystory_files\%%d_%%e.swf"



REM  *********** CLEAN UP *******************

cd %deploy%

del /q /s *.fla

copy "%jsfl%" %root%



