MODULE ALLOCATE_VARS
    USE READ_DATA
    IMPLICIT NONE
    INTEGER seed,n_verlet,n_gr_meas, nstep
    REAL*8 time_re,energy_re,dist_re,temp_re,press_re,n_mols,total_mass,rho_re,t,temp_instant,cutoff_aux
    REAL*8,DIMENSION(:,:),ALLOCATABLE :: r, v, f
    REAL*8,DIMENSION(:),ALLOCATABLE :: g_r

    CONTAINS
    SUBROUTINE INITIALIZE_VARS()
        IMPLICIT NONE

        ALLOCATE(r(n_particles,3),v(n_particles,3),F(n_particles,3),g_r(0:n_radial+1))
        seed=1996


        !dimensional factors
        temp_re=epsi/k_B   !Kelvin
        energy_re=epsi     !kJ/mol
        dist_re=sigma         !Angstroms
        time_re=0.1*sqrt(mass*sigma**2d0/epsi)  !Picoseconds
        press_re=1d33*epsi/(n_avog*sigma**3d0)  !Pascals
        n_mols=n_particles/n_avog
        total_mass=n_mols*mass
        rho_re=mass*1d24/(sigma**3d0*n_avog)

        !verlet integration vars
        n_verlet=int((t_b-t_a)/h)  !number of time integration steps
        t=t_a
        g_r=0d0
        n_gr_meas=0

    END SUBROUTINE
END MODULE
