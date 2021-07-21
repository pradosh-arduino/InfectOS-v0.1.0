#------------------------------------------------------
# this make file is made by Pradosh.S / pradosh-arduino
#------------------------------------------------------
.PHONY: all clean bootloader kernel

all: bootloader kernel clean

KERNELNAME = InfectKernel
OSBUILDNAME = InfectOS-ARM
ARMDIR = ARM_Root

clean:
	rm *.o
	
deep-clean:
	rm *.elf
	rm $(ARMDIR)/*.*

bootloader:
	@ echo building Bootloader for ARM...
	arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c bootloader/bootloader.S -o bootloader.o
	@ echo

kernel:
	@ echo Compiling $^
	arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c kernel/kernelInit.c -o kernelInit.o -O2 -Wall -Wextra
	arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c kernel/kernel.c -o kernel.o -O2 -Wall -Wextra
	@ echo
	@ echo Linking...
	arm-none-eabi-gcc -T linker.ld -o $(KERNELNAME).elf -ffreestanding -O2 -nostdlib *.o -lgcc

image:
	arm-none-eabi-objcopy $(KERNELNAME).elf -O binary kernel7.img

real-boot:
	cp firmwareBoot/bootcode.bin firmwareBoot/fixup.dat firmwareBoot/start.elf kernel7.img ARM_Root
	dd if=/dev/zero of=$(OSBUILDNAME).img bs=512 count=93750
	mformat -v InfectOS -F -c 1 -i $(OSBUILDNAME).img ::
	mcopy -i $(OSBUILDNAME).img $(ARMDIR)/bootcode.bin
	mcopy -i $(OSBUILDNAME).img $(ARMDIR)/fixup.dat
	mcopy -i $(OSBUILDNAME).img $(ARMDIR)/start.elf
	mcopy -i $(OSBUILDNAME).img $(ARMDIR)/kernel7.img
