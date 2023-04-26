module parallel_routines
    use read_data
    IMPLICIT NONE

    contains
    SUBROUTINE simple_loop_matrix()
        IMPLICIT NONE
        integer :: i,j,a,res
        a=INT(REAL(n_particles)/REAL(numproc))
        res=mod(n_particles,numproc)
        allocate(index_matrix(numproc,2),desplac(numproc),num_send(numproc))
!Compute the number of particles assigned to each worker
            DO i=1,numproc
              IF((i-1)<res)then
                index_matrix(i,1)=(a+1)*(i-1)+1
                index_matrix(i,2)=index_matrix(i,1)+a
              else
              index_matrix(i,1)=(i-1)*a+res+1
              index_matrix(i,2)=index_matrix(i,1)+a-1
              end if
            END DO
!Compute de relative displacement and the number of particles for each worker
            DO i=1,numproc
              if(i.eq.1)then
                desplac(i)=0
                else
                desplac(i)=index_matrix(i-1,2)
                end if
                num_send(i)=index_matrix(i,2)-index_matrix(i,1)+1
            end do      
    END SUBROUTINE
END module
