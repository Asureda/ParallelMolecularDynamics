###################################################################################
# GRAPHIC OF THE ENERGIES, INSTANTANEOUS TEMPERATURE AND PRESSURE (REDUCED UNITS) #
###################################################################################

# SET TERMINAL
set term png

# ENERGIES ---------------------------------------------------------------------
set title '<Energies> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Energies> (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'energy_reduced.png'

plot 'kin_pot_red.dat' u 1:($2) t '<Kinetic Energy>' w l lw 1 lc rgb "orange",\
'' u 1:($3) t '<Potential Energy>' w l lw 1 lc rgb "green",\
'total_red.dat' u 1:($2) t '<Total Energy>' w l lw 1 lc rgb "#9400d3"


# INSTANTANEOUS TEMPERATURE ----------------------------------------------------
set title 'Instantaneous Temperature vs time'
set xlabel 'time (a.u.)'
set ylabel 'Temperature (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'temperature_reduced.png'

plot 'temp_pres_red.dat' u 1:2 notitle w l lw 1 lc rgb "#00008b"


# PRESSURE ----------------------------------------------------------------------
set title 'Pressure vs time'
set xlabel 'time (a.u.)'
set ylabel 'Pressure (a.u.)'
set tics font ", 10"
set autoscale

set key outside
set key bottom
set key horizontal

# Generate output file
set output 'pressure_reduced.png'

plot 'temp_pres_red.dat' u 1:3 notitle w l lw 1 lc rgb "red"
