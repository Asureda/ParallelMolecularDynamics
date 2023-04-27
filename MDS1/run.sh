#Execute file
#Getting the temporal file name
tmp_folder=$(date +'%d_%m_%Y_%H_%M_%S')

# Creating the tmp file in PROGRM

mkdir PROGRAM/$tmp_folder/
mkdir OUTPUT/

# Copy input parametters to tmp file
rm PROGRAM/*.dat
cp INPUT/*.dat PROGRAM/$tmp_folder/

# Enter in PROGRAM folder

cd PROGRAM/

# Execute Makefile to get the last version

make

# Copy the programs and scripts to the tmp folder
# The thing we need start with "r_*"

cp main $tmp_folder/
cp *.gnu $tmp_folder/

#Enter in tmp folder

cd $tmp_folder/

#Execute the progrm
##Execute the progrm
./main > log.dat
gnuplot gr.gnu
gnuplot real.gnu
gnuplot red.gnu

## After the program finalizes, we go back

##rm r_*

cd ..
cd ..
mkdir OUTPUT/$tmp_folder/
## We crate the output folder in OUTPUT and copy results

cp PROGRAM/$tmp_folder/* OUTPUT/$tmp_folder/

##Delete the tmp folder from PROGRAM

 cd PROGRAM/
 rm -r $tmp_folder/
## cd ..
