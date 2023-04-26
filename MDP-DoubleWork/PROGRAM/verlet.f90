MODULE Verlet_Algorithm
use READ_DATA
use Interaction_Cutoff_Modul
use PBC
use parallel_routines
implicit none
contains
SUBROUTINE VELO_VERLET(r,v,F)
 ! We integrate the Newton's equations with the Velocity Verlet algorithm
 ! We obtain new positions, velocities and the forces
    INTEGER i, k
    REAL*8 r(:,:),v(:,:),r0(n_particles,3),v0(n_particles,3),f0(n_particles,3)
    REAL*8 F(:,:),cutoff
    kinetic=0d0
    cutoff=0.99*L*5d-1
    CALL INTERACTION_CUTOFF(r,F,cutoff)

    DO i=index_matrix(taskid+1,1), index_matrix(taskid+1,2)
        r(i,:)=r(i,:)+v(i,:)*h+5d-1*F(i,:)*h*h
        v(i,:)=v(i,:)+5d-1*(F(i,:))*h
        r(i,1)=PBC2(r(i,1),L)
        r(i,2)=PBC2(r(i,2),L)
        r(i,3)=PBC2(r(i,3),L)
    END DO
    !Sharing the particle positions for all the workers to compute the force
    DO k=1,3
    CALL MPI_ALLGATHERV(r(index_matrix(taskid+1,1):index_matrix(taskid+1,2),k),&
                        & (index_matrix(taskid+1,2)-index_matrix(taskid+1,1)+1),MPI_DOUBLE_PRECISION, &
                        & r(:,k),num_send,desplac,MPI_DOUBLE_PRECISION,MPI_COMM_WORLD,ierror)
    END DO
    CALL INTERACTION_CUTOFF(r,F,cutoff)

    DO i=index_matrix(taskid+1,1), index_matrix(taskid+1,2)
        v(i,:)=v(i,:)+5d-1*(F(i,:))*h
    END DO
   
END SUBROUTINE
END MODULE Verlet_Algorithm
