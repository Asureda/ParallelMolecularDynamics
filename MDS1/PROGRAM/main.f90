PROGRAM SEQUENTIAL_MD
  use READ_DATA
  use ALLOCATE_VARS
  use Inicialitzar
  use Interaction_Cutoff_Modul
  use Verlet_Algorithm
  use Andersen_modul
  use Distribucio_Radial
  use SAMPLE
  IMPLICIT NONE
  real*8 :: starttime, endtime
!##########################
! INITIAL CONFIGURATION
!#########################  
  call read_all_data()
  call other_global_vars()
  call INITIALIZE_VARS()
  call FCC_Initialize(r)
  call Uniform_velocity(v)
  call VELO_RESCALING_MOD(v,T_therm_prov)
  call cpu_time(starttime)
!##########################
! MELING AND THERMALIZATION
!#########################
   DO nstep=1,n_melting
    call velo_verlet(r,v,F)
    call andersen(v,T_therm_prov)
   END DO
  
  open(41,file='kin_pot_red.dat')
  open(42,file='total_red.dat')
  open(43,file='temp_pres_red.dat')
  open(44,file='kin_pot_real.dat')
  open(45,file='total_real.dat')
  open(46,file='temp_pres_real.dat')
  open(53,file='distrib_funct.dat')
  open(54,file='positions.xyz')
!##########################
! VERLET EVOLUTION
!#########################
  DO nstep=1,n_verlet
    t=t_a+nstep*h
    !Verlet step
    call VELO_VERLET(r,v,F)
    if(is_thermostat.eqv..true.)THEN
      call andersen(v,T_therm)
    end if
  !Computing the observables
  CALL SAMPLES()
  END DO
!##########################
! FINAL COMPUTATIONS
!#########################
  !Final form of the gdr
  CALL gdr()
  ! put code to test here
call cpu_time(endtime)
print*,'PROGRAM END'
print*, 'Time =',endtime-starttime, 's'
END PROGRAM SEQUENTIAL_MD
