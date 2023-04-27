set term png
set title '<Energies> vs time'
set xlabel 'time (ps)'
set ylabel '<Energies> (kJ/mol)'
set key outside
set autoscale

set key outside
set key bottom
set key horizontal
set output 'energy_real.png'
plot 'kin_pot_real.dat' u 1:2 w l t'<kinetic>','kin_pot_real.dat' u 1:3 w l t'<potential>','total_real.dat' u 1:2 w l t'<total>'

# INSTANTANEOUS TEMPERATURE ----------------------------------------------------
# INSTANTANEOUS TEMPERATURE ----------------------------------------------------
set title 'Instantaneous Temperature vs time'
set xlabel 'time (ps)'
set ylabel 'Temperature (K)'
set output 'temperature_real.png'
plot 'temp_pres_real.dat' u 1:2 w p t'temperature'

# PRESSURE ----------------------------------------------------------------------
set title 'Pressure vs time'
set xlabel 'time (ps)'
set ylabel 'Pressure (Pa)'
set output 'pressure_real.png'
plot 'temp_pres_real.dat' u 1:3 w l t'pressure'