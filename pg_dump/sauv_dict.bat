@echo off

:: Decomposition de la date actuelle
set /a J=100%DATE:~0,2% %% 100
set /a M=100%DATE:~3,2% %% 100
set /a A=%DATE:~6,4%

:: Calcul du jour
set /a N=(1461 * (%A% + 4800 + (%M% - 14) / 12)) / 4 + (367 * (%M% - 2 - 12 * ((%M% - 14) / 12))) / 12 - (3 * ((%A% + 4900 + (%M% - 14) / 12) / 100)) / 4 + %J% - 32075

:: Calcul numero du jour [Lundi = 0 ... Dimanche = 6]
set /a N%%=7

:: Affectation Jours
if %N%==0 set JOUR=lundi
if %N%==1 set JOUR=mardi
if %N%==2 set JOUR=mercredi
if %N%==3 set JOUR=jeudi
if %N%==4 set JOUR=vendredi
if %N%==5 set JOUR=samedi
if %N%==6 set JOUR=dimanche

:: Nom user bdd
set dbuser=postgres

:: Postgresql EXE Path
set postgresdumpexe="E:\Program Files\PostgreSQL\9.2\bin\pg_dump.exe"

:: Path backup
set backupfldr=E:\backup

:: List BDD
set list=base1 base2
(for %%a in (%list%) do ( 
   %postgresdumpexe% -U %dbuser% -Ft %%a | bzip2 > %backupfldr%\%JOUR%\%%a.tar.bz2
))