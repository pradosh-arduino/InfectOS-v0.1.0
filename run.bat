@echo off
set DIR=\\wsl$\Ubuntu-20.04\home\pradosh\InfectedOS
cd C:\Program Files
cd qemu
qemu-system-arm -m 1G -M raspi2 -kernel %DIR%/kernel.elf
pause