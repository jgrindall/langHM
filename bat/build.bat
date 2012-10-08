SETLOCAL ENABLEDELAYEDEXPANSION

set lib=..\langHMLib\langHMLib.swc

set tlf=..\langHM\lib\tlf.swc

set fonts=..\langHM\lib\fonts.swc

compc -source-path ..\langHM\src -include-sources ..\langHM\src -external-library-path+="%lib%" -external-library-path+="%tlf%" -external-library-path+="%fonts%" -output ..\langHM\langHM.swc