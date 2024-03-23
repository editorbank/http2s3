@if not defined GIT_HOME if exist "C:\Program Files\Git" set GIT_HOME=C:\Program Files\Git
@if not defined GIT_HOME (echo Not defined GIT_HOME! & exit 1)
@for %%I in ( "%GIT_HOME%" ) do @if exist %%~sI set GIT_HOME=%%~sI
@set PATH=%GIT_HOME%\bin;%GIT_HOME%\usr\bin;%GIT_HOME%\mingw64\bin;%PATH%
@call %*
