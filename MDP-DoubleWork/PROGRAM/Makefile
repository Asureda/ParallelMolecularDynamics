##Makefile per una simulacio de Dinamica Molecular


# Compilador
comp=mpif90 

# Main program
TARGET=main

# Optimitzador i Flags
OPT=-O3 -g -debug all

# Compilacio del main program
$(TARGET) : read_data.o parallelization.o PBC.o Full_modul_Inicialitzar.o Full_Modul_Andersen.o Full_Modul_Distrib_Radial.o L_J.o  energy.o main_vars.o verlet.o sample.o $(TARGET).o 
	@echo "From MAKEFILE. Compiling main program"
	$(comp) -o $(TARGET) $(TARGET).o energy.o PBC.o verlet.o Full_Modul_Andersen.o Full_modul_Inicialitzar.o Full_Modul_Distrib_Radial.o L_J.o read_data.o main_vars.o parallelization.o sample.o

# Tots els fitxers amb extensio .f90 son compilats a objectes .o
%.o : %.f90
	@echo "From MAKEFILE. Compiling all modules"
	$(comp) -c $<


## backup : fer una copia comprimida del codi basic
.PHONY : backup
backup:
	tar -czvf "backup.tar.gz" *.f90


## clean_exe : regla per fer un clean nomes dels objectes executables
.PHONY : clean
clean:
	@echo Removing compiled objects only
	rm *.o *.mod
