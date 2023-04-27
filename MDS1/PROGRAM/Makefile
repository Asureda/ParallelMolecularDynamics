##Makefile per una simulacio de Dinamica Molecular


# Compilador
F90=gfortran

# Main program
TARGET=main

# Optimitzador
OPT=-O3

# Flags
FLAGS=-g

# Compilacio del main program
$(TARGET) : read_data.o PBC.o Full_modul_Inicialitzar.o Full_Modul_Andersen.o Full_Modul_Distrib_Radial.o L_J.o energy.o main_vars.o verlet.o sample.o $(TARGET).o 
	@echo "From MAKEFILE. Compiling main program"
	$(F90) $(OPT) $(FLAGS) -o $(TARGET) $(TARGET).o energy.o PBC.o verlet.o Full_Modul_Andersen.o Full_modul_Inicialitzar.o Full_Modul_Distrib_Radial.o L_J.o read_data.o main_vars.o sample.o

# Tots els fitxers amb extensio .f90 son compilats a objectes .o
%.o : %.f90
	@echo "From MAKEFILE. Compiling all modules"
	$(F90) $(OPT) $(FLAGS) -c $<


## backup : fer una copia comprimida del codi basic
.PHONY : backup
backup:
	tar -czvf "backup.tar.gz" *.f90

## clean_exe : regla per fer un clean nomes dels objectes executables
.PHONY : clean
clean:
	@echo Removing compiled objects only
	rm *.o *.mod
