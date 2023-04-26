MODULE SAMPLE
use READ_DATA
use ALLOCATE_VARS
use Distribucio_Radial
IMPLICIT NONE
INTEGER ii, kk
contains
SUBROUTINE SAMPLES()
! Calculates the final values of these magnitudes and their statistical treatment 
  if((mod(nstep,n_meas).eq.0).and.(is_print_thermo.eqv..true.))then
    DO ii=1,n_particles
       kinetic=kinetic+5d-1*(v(ii,1)**2d0+v(ii,2)**2d0+v(ii,3)**2d0)
    END DO

    temp_instant=2d0*kinetic/(3d0*n_particles)
    pressure=(density*temp_instant+pressure/(3d0*L**3d0))
    kinetic = kinetic/(n_particles*1d0)
    potential = potential/(n_particles*1d0)
    write(41,*) t, kinetic, potential
    write(42,*) t, (kinetic+potential)
    write(43,*) t, temp_instant, pressure
    write(44,*) t*time_re, kinetic*energy_re, potential*energy_re
    write(45,*) t*time_re, (kinetic+potential)*energy_re
    write(46,*) t*time_re, temp_instant*temp_re, pressure*press_re
  endif

  if((mod(nstep,n_meas_gr).eq.0).and.(is_compute_gr.eqv..true.))then
    call RAD_DIST_INTER(r,g_r) ! Calculation of  g(r) at each step
    n_gr_meas=n_gr_meas+1
  endif
  IF(is_time_evol.eqv..TRUE.)THEN
    WRITE(54,*)n_particles
    WRITE(54,*)
    DO kk=1,n_particles
      WRITE(54,*)'X',r(kk,:)
    END DO
  END IF

END SUBROUTINE SAMPLES

SUBROUTINE gdr()
! Calculation of the radial distribution function
  if((is_compute_gr.eqv..true.))then
  call RAD_DIST_INTER(r,g_r)
  n_gr_meas=n_gr_meas+1
  call RAD_DIST_FINAL(g_r,n_gr_meas) ! Calculation of g(r) as an accumulation
  do kk=1,n_radial
    write(53,*)dx_radial*kk,g_r(kk)
  enddo
  endif
END SUBROUTINE gdr

END MODULE SAMPLE
