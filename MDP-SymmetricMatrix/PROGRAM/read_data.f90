MODULE READ_DATA

    IMPLICIT NONE
    include 'mpif.h'
    !MPI vars
    integer comm, taskid, numproc, ierror, partner,request
    integer reslen
    integer message
    integer stat(MPI_STATUS_SIZE)


    integer, dimension(:,:), allocatable :: index_matrix!, double_matrix
    integer, dimension(:), allocatable :: desplac,num_send

    ! Variables of parameters.dat file
    INTEGER :: n_particles
    REAL*8 :: density,t_b,h,sigma,epsi,mass,T_ini, T_therm, dx_radial
    LOGICAL :: is_thermostat

    ! Variables del fitxer config.dat
    INTEGER :: n_meas,n_meas_gr,n_meas_time_ev,n_melting, n_sample
    REAL*8 :: T_therm_prov
    LOGICAL :: is_print_thermo,is_compute_gr,is_time_evol,paral_simple,paral_double

    ! Variables of config.dat file
    REAL*8 :: k_b,n_avog

    ! Variables of constants.dat file
    INTEGER :: M,n_radial
    REAL*8 :: L,a,T_a,kinetic,potential,pressure
    !LOGICAL :: is_thermostat
    CONTAINS
    ! Subroutine to define global variables that will be used in the different modules
    SUBROUTINE READ_ALL_DATA()
        IMPLICIT NONE
        !---------------------------------------------------
        !      WE READ THE PARAMETERS FILE
        !---------------------------------------------------
        OPEN(11,FILE='parameters.dat',status='OLD')
        READ(11,*)n_particles
        READ(11,*)density
        READ(11,*)t_b
        READ(11,*)h
        READ(11,*)sigma
        READ(11,*)epsi
        READ(11,*)mass
        READ(11,*)is_thermostat
        READ(11,*)T_therm
        READ(11,*)dx_radial
        CLOSE(11)
        !--------------------------------------------------
        !      WE READ THE CONFIGURATION FILE
        !--------------------------------------------------
        OPEN(12,FILE='config.dat',status='OLD')
        READ(12,*)T_therm_prov
        READ(12,*)n_melting
        READ(12,*)is_print_thermo
        READ(12,*)n_meas
        READ(12,*)is_compute_gr
        READ(12,*)n_meas_gr
        READ(12,*)is_time_evol
        READ(12,*)n_meas_time_ev
 
        CLOSE(12)

        OPEN(13,FILE='constants.dat',status='OLD')
        READ(13,*)k_b
        READ(13,*)n_avog
        CLOSE(13)
    END SUBROUTINE

      ! We calculate some other global variables useful for the calculations
    SUBROUTINE OTHER_GLOBAL_VARS()
        IMPLICIT NONE
        L=((n_particles*1d0)/density)**(1d0/3d0)     ! Longitud de la caixa de simulacio
        M=nint(((n_particles*1d0)/4d0)**(1d0/3d0))   ! Numero de nodes en cada dimensio
        a=L/(M*1d0)                                  ! Aresta de cada cel·la unitat
        n_radial=int(0.5*L/dx_radial)
        t_a=0d0
        kinetic=0d0
        potential=0d0
        pressure=0d0
    END SUBROUTINE

    ! Function to calculate the kinetic energy initially for the rescaling of the velocities
    FUNCTION KINETIC_ENERGY(v)
        IMPLICIT NONE
        INTEGER i
        REAL*8 :: v(:,:),KINETIC_ENERGY
        KINETIC_ENERGY=0d0
        DO i=1,n_particles
            KINETIC_ENERGY=KINETIC_ENERGY+5d-1*(v(i,1)**2d0+v(i,2)**2d0+v(i,3)**2d0)
        END DO
        RETURN
    END FUNCTION

END MODULE
