PROGRAM SEQUENTIAL_MD
  use READ_DATA
  use ALLOCATE_VARS
  use Inicialitzar
  use Interaction_Cutoff_Modul
  use Verlet_Algorithm
  use Andersen_modul
  use Distribucio_Radial
  use parallel_routines
  use SAMPLE
  IMPLICIT NONE
  integer master, k
  REAL*8 starttime, endtime
!##########################
! INITIAL CONTIGURATION
!#########################
  call MPI_INIT(ierror)
  call MPI_COMM_RANK(MPI_COMM_WORLD,taskid,ierror)
  call MPI_COMM_SIZE(MPI_COMM_WORLD,numproc,ierror)
  starttime = MPI_WTIME()
  master = 0

 
  call read_all_data()
  call other_global_vars()
  call INITIALIZE_VARS()
  call simple_loop_matrix()


  call FCC_Initialize(r)
  call Uniform_velocity(v)
  call VELO_RESCALING_MOD(v,T_therm_prov)

!Sharing the initial state for all the workers
    call MPI_BCAST(r, n_particles*3, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, IERROR)
    call MPI_BCAST(v, n_particles*3, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, IERROR)
!##########################
! MELTING AND THERMALIZATION
!#########################
    DO nstep=1,n_melting
     call velo_verlet(r,v,F)
     call andersen(v,T_therm_prov)
    END DO

  if (taskid==0) then
    open(41,file='kin_pot_red.dat')
    open(42,file='total_red.dat')
    open(43,file='temp_pres_red.dat')
    open(44,file='kin_pot_real.dat')
    open(45,file='total_real.dat')
    open(46,file='temp_pres_real.dat')
    open(53,file='distrib_funct.dat')
    open(54,file='positions.xyz')
  end if
!##########################
! VERLET EVOLUTION
!#########################
  DO nstep=1,n_verlet
    t=t_a+nstep*h
    !Verlet integration
    call VELO_VERLET(r,v,F)
    if(is_thermostat.eqv..true.)THEN
       call andersen(v,T_therm)
    end if
    !Measuring observables
    CALL SAMPLES()
  end do
!##########################
! FINAL COMPUTATIONS
!#########################
    !Final form for the gdr
    CALL gdr()
  endtime = MPI_WTIME()
  IF (taskid==0) then
    print*,numproc,endtime-starttime
  END IF
  call MPI_FINALIZE(ierror)
END PROGRAM SEQUENTIAL_MD
