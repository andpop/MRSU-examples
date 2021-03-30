@echo off
if exist temp.txt del temp.txt
for /D %%f in (C:\odb\201612*) DO (
  dir /s/b  %%f\od_*.htm >> temp.txt)
sort /+17 temp.txt /o odb.txt
del temp.txt
