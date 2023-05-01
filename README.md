
[![Fortran Compilation Workflow](https://github.com/Asureda/MPI-NVT/actions/workflows/ci_compile.yml/badge.svg)](https://github.com/Asureda/MPI-NVT/actions/workflows/ci_compile.yml)

# Molecular Dynamics Simulations

* Motivation

Master's computational project to learn the basic knowledge of parallel computing applied to molecular dynamics. 
The main objectives of this project are:
- Develop a molecular dynamics program.
- Once the sequential program is done, develop programs where the tasks of each loop are distributed in different processors and check the optimization characteristics for each one. 
- Analyze the speed-up and compare time execution with different number of particles in parallel program.
The execution has been performed at the BSC Mare Nostrum where large number of CPUs where used; we worked almost with 400 processors.

* The system

We work with a Van der Waals gas, specifically helium gas, described by Lennard-Jones potential model to approach the interactions between pairs of particles. We consider a system of N particles in a canonical ensemble (NVT ensemble) under periodic boundary conditions.
First, we create a FCC lattice taking care that there are no overlaps between particles. At this point, we can study the molecular dynamics of interest.

* Molecular dynamics

The integrator used to solve the Newton’s equations of motion is the velocity Verlet. The user can choose whether the system is in contact with a heat bath by activating the Andersen thermostat or not. During the simulation, we calculate the positions and the velocities of the system many times, obtaining its evolution.

## First steps 💡
Information to install and execute the programs.

### Pre-requisites 📋

Working environment:

```
Linux Shell and Bash
```

Sequential compilers:

```
ifort (Default)
gfortran (Must configure Makefile)
```

Parallel compilers:
```
intel openmpi (Default)
```

### Installation 🔧

The programs are ready-to-use. The user has to download the repository in a local computer folder or computing cluster and configure the compiler and flags options in the Makefile.

Sequential program
```
Makefile:  configure compiler and flags variables (ifort by default)

```
Parallel program (computing cluster)
```
Makefile:  configure the compiler and flags variables (mpifort by default)
"run_sub.sh" (1): Check the execution order ( mpirun by default)
"run_sub.sh" (2): Configure the submit options ( BSC by default)
"run.sh" (1): Check Makefile flags for ifort or gfortran.
"run.sh" (2): Configure "run.sh" number of processors.

```

## Execution 🚀

Sequential program
```
(1) Configure the simulation parameters (INPUT folder)
(2) Execute the "run.sh" script.
(3) Collect results in the OUTPUT folder.
    The results folder name is the date-time when the task was submitted.

```
Parallel program (computing cluster)
```
(1) Configure the simulation parameters (INPUT folder)
(2) Execute the "run_sub.sh" script.
(3) Collect results in the OUTPUT folder.
    The results folder name is the date-time when the task was executed.
```
### Program-check 🔎

In the OUTPUT folder is provided a run_check subfolder with input configuration parameters and graphs. 
Put the same parameters in the INPUT files, run the program and compare the graphs; they should be similar except for a random factor.

### Main theoretical characteristics ⌨️

```
- Initial FCC structure in a cubic volume.
- Uniform distribution of initial velocities.
- Melting and equilibration at a customizable temperature.
- Velocity Verlet algorithm to integrate the equations.
- Andersen Thermostat to control the bath temperature.
- Pair interactions with Lennard-Johnes potential.
- Periodic boundary conditions.
- Thermodynamic results in real and reduced units.
```

## Technologies 🛠️

```
- Fortran
- Open MPI subroutines
- Random numbers: CALL RANDOM_NUMBER(x) (no explicit seed)
- Gnuplot
- Bash shell scripts
- Computing Cluster
```

## Version 📌

Outcome : 21 / 04 / 2020 (version 1.0)

Last moified:  NONE (version --)

## Authors ✒️

* **Alexandre Sureda**
* **Elena Ricart**
* **Laia Navarro**
* **Oriol Cabanas**
* **Silvia Àlvarez**


## Acknowledgments 🎁

To Sergio Madurga, Romualdo Pastor and Juan Torras for guiding and helping us develop this project.
To Barcelona Supercomputing Center-Centro Nacional de Supercomputación (BSC-CNS) for allowing us to perform calculations with their platforms.

# Appendix
* Input parameters
* Speed up and running time recommendations
## A1: Input parameters
parameters.dat
```
particles        # Number of particles (x^3 *4 ; with x natural and positive)
density          # Density (reduced units)
time             # Simulation time (reduced units)
h                # Time step (reduced units)
sigma            # Sigma of the gas (Angstroms)
epsilon          # Epsilon of the gas (kJ/mol)
mass             # Mass (g/mol)
(boolean)        # To add a thermostat
temperature      # If true, temperature of the thermostat (reduced units)
dx               # Precision for the radial distribution function (reduced units)
```
config.dat
```
temperature      # Temperature of the initial melting (reduced units)
iterations       # Melting Velo Verlet Integration steps
(boolean)        # Print thermodynamic magnitudes
iterations       # Delta iterations to measure thermodynamic magnitudes
(boolean)        # Compute the radial distribution function
iterations       # Delta iterations to compute the Rad. Dist. Func.
(boolean)        # Time-positions of the particles (.xyz file)
iterations       # Delta iterations to save the positions
```
constants.dat
```
0.008314462      # Boltzman constant in kJ/molK
6.022d23         # Avogadro number
```
## A2: Speed up and running time recommendations
MDP-Double Work
```
- Same number of interactions for each processor. 
- No symmetric reduction is made to compute the half of the matrix.
- Every processor has the same work.
```
MDP- Pair
```
- Same number of interactions for each processor.
- List of pairs distributed for each processor.
- Every processor has the same work.
```
MDP- Symmetric Matrix
```
- Different number of interactions for each processor.
- Use of the symmetry force to parallelize.
- Different distribution of work between processors.
```

