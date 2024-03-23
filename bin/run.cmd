@set this_file=%~dpn0
@set this_file=%this_file:\=/%
@set this_file=%this_file::=%
@call %~dp0gw.cmd bash %this_file%.sh

