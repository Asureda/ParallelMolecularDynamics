MODULE SAMPLE
use READ_DATA
use ALLOCATE_VARS
use Distribucio_Radial
IMPLICIT NONE
INTEGER kk, ii
contains
SUBROUTINE SAMPLES()
!Sharing the velocities of each worker to Master for each time step
  DO kk=1,3
   CALL MPI_GATHERV(v(index_matrix(taskid+1,1):index_matrix(taskid+1,2),kk),&
                        & (index_matrix(taskid+1,2)-index_matrix(taskid+1,1)+1),MPI_DOUBLE_PRECISION, &
                        & v(:,kk),num_send,desplac,MPI_DOUBLE_PRECISION,0,MPI_COMM_WORLD,ierror)
   END DO
   ! Master worker calculates the final values of these magnitudes and their statistical treatment
   if(taskid==0) then
  if((mod(nstep,n_meas).eq.0).and.(is_print_thermo.eqv..true.))then
    DO ii = 1,n_particles
      kinetic=kinetic+5d-1*(v(ii,1)**2d0+v(ii,2)**2d0+v(ii,3)**2d0)
    end do
    kinetic = kinetic/n_particles
    potential = potential/n_particles
    temp_instant=2d0*kinetic/(3d0)
    pressure=(density*temp_instant+pressure/(3d0*L**3d0))
          write(41,*) t,kinetic,potential
          write(42,*) t,kinetic+potential
          write(43,*) t,temp_instant,pressure
          write(44,*) t*time_re,kinetic*energy_re,potential*energy_re
          write(45,*) t*time_re,(kinetic+potential)*energy_re
          write(46,*) t*time_re,temp_instant*temp_re,pressure*press_re
  endif
end if

if (taskid==0) then
  if((mod(nstep,n_meas_gr).eq.0).and.(is_compute_gr.eqv..true.))then
    call RAD_DIST_INTER(r,g_r) !càlcul g(r) a cada pas
    n_gr_meas=n_gr_meas+1
  endif
  IF(is_time_evol.eqv..TRUE.)THEN
    WRITE(54,*)n_particles
    WRITE(54,*)
    DO kk=1,n_particles
      WRITE(54,*)'X',r(kk,:)
    END DO
  END IF
end if
END SUBROUTINE SAMPLES

SUBROUTINE gdr()
! Calculation of the radial distribution function
  if (taskid==0) then
  if((is_compute_gr.eqv..true.))then
  call RAD_DIST_INTER(r,g_r)
  n_gr_meas=n_gr_meas+1
  call RAD_DIST_FINAL(g_r,n_gr_meas) !càlcul g(r) com a cúmul
  do kk=1,n_radial
    write(53,*)dx_radial*kk,g_r(kk)
  enddo
  endif
end if
END SUBROUTINE gdr

END MODULE SAMPLE
