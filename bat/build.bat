SETLOCAL ENABLEDELAYEDEXPANSION

set lib=..\langHMLib\langHMLib.swc

compc -source-path ..\langHM\src -include-sources ..\langHM\src -external-library-path+="%lib%" -output ..\langHM\langHM.swc