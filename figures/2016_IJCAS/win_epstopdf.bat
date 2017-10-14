FOR %%a in (*.eps) DO (
ECHO %%-na
C:/texlive/2015/bin/win32/epstopdf.exe %%a
)