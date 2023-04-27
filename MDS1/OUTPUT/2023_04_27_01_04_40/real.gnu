################################################################################
# GRAPHIC OF THE ENERGIES, INSTANTANEOUS TEMPERATURE AND PRESSURE (REAL UNITS) #
################################################################################

# SET TERMINAL
set term png

# ENERGIES ---------------------------------------------------------------------
set title '<Energies> vs time'
set xlabel 'time (ps)'
set ylabel '<Energies> (kJ/mol)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'energy_real.png'

plot 'kin_pot_real.dat' u 1:($2) t '<Kinetic Energy>' w l lw 1 lc rgb "orange",\
'' u 1:($3) t '<Potential Energy>' w l lw 1 lc rgb "green",\
'total_real.dat' u 1:($2) t '<Total Energy>' w l lw 1 lc rgb "#9400d3"


# INSTANTANEOUS TEMPERATURE ----------------------------------------------------
set title 'Instantaneous Temperature vs time'
set xlabel 'time (ps)'
set ylabel 'Temperature (K)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'temperature_real.png'

plot 'temp_pres_real.dat' u 1:2 notitle w l lw 1 lc rgb "#00008b"


# PRESSURE ----------------------------------------------------------------------
set title 'Pressure vs time'
set xlabel 'time (ps)'
set ylabel 'Pressure (Pa)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'pressure_real.png'

plot 'temp_pres_real.dat' u 1:3 notitle w l lw 1 lc rgb "red"
