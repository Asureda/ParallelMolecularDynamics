set term png
set title '<Energies> vs time'
set xlabel 'time (a.u.)'
set ylabel '<Energies> (a.u.)'
set key outside
set autoscale

set key outside
set key bottom
set key horizontal
set output 'energy_red.png'
plot 'kin_pot_red.dat' u 1:2 w l t'<kinetic>','kin_pot_red.dat' u 1:3 w l t'<potential>','total_red.dat' u 1:2 w l t'<total>'


# INSTANTANEOUS TEMPERATURE ----------------------------------------------------
set title 'Instantaneous Temperature vs time'
set xlabel 'time (a.u.)'
set ylabel 'Temperature (a.u.)'
set output 'temperature_red.png'
plot 'temp_pres_red.dat' u 1:2 w p t'temperature'

# PRESSURE ----------------------------------------------------------------------
set title 'Pressure vs time'
set xlabel 'time (a.u.)'
set ylabel 'Pressure (a.u.)'

set output 'pressure_red.png'
plot 'temp_pres_red.dat' u 1:3 w l t'pressure'