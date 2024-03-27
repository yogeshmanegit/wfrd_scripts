for %%G in (*.sql) do sqlcmd /S USDCSHRSQLPD005 /d OneView -E -i"%%G"

for %%G in (*.sql) do del /s %%G

pause