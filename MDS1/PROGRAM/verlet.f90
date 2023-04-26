MODULE Verlet_Algorithm
use READ_DATA
use Interaction_Cutoff_Modul
use PBC
implicit none
contains
SUBROUTINE VELO_VERLET(r,v,F)
    ! We integrate the Newton's equations with the Velocity Verlet algorithm
    ! We obtain new positions, velocities and the forces
    INTEGER i
    REAL*8 r(:,:),v(:,:)
    REAL*8 F(:,:),cutoff
    cutoff=0.99*L*5d-1
    CALL INTERACTION_CUTOFF(r,F,cutoff)
    DO i=1,n_particles
        r(i,:)=r(i,:)+v(i,:)*h+5d-1*F(i,:)*h*h
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
        r(i,1)=PBC2(r(i,1),L)
        r(i,2)=PBC2(r(i,2),L)
        r(i,3)=PBC2(r(i,3),L)
    END DO
    CALL INTERACTION_CUTOFF(r,F,cutoff)
    DO i=1,n_particles
        v(i,:)=v(i,:)+5d-1*F(i,:)*h
    END DO
    RETURN
END SUBROUTINE
END MODULE Verlet_Algorithm
