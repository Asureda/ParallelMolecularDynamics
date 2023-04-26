MODULE Interaction_Cutoff_Modul
use READ_DATA
use Lennard_Jones
use PBC
implicit none
contains

SUBROUTINE INTERACTION_CUTOFF(r,F,cutoff)
! Compute the forces, the potential energy of the
! system and the pressure taking into account PBC
    IMPLICIT NONE
    INTEGER :: i,j
    REAL*8 :: cutoff,pot
    REAL*8 :: dx,dy,dz,d,ff
    REAL*8, DIMENSION(:,:) :: r, F
    F=0d0
    potential=0d0
    pressure=0.0
    DO i=1,n_particles
        DO j=i+1,n_particles
            dx=PBC1(r(i,1)-r(j,1),L)
            dy=PBC1(r(i,2)-r(j,2),L)
            dz=PBC1(r(i,3)-r(j,3),L)
            d=(dx**2d0+dy**2d0+dz**2d0)**0.5
            CALL L_J(d,ff,pot,cutoff)
            F(i,1)=F(i,1)+ff*dx
            F(i,2)=F(i,2)+ff*dy
            F(i,3)=F(i,3)+ff*dz
            F(j,1)=F(j,1)-ff*dx
            F(j,2)=F(j,2)-ff*dy
            F(j,3)=F(j,3)-ff*dz
            potential=potential+pot
            pressure=pressure+(ff*dx**2d0+ff*dy**2d0+ff*dz**2d0)
        END DO
    END DO
END SUBROUTINE INTERACTION_CUTOFF

END MODULE Interaction_Cutoff_Modul
