module Distribucio_Radial

use READ_DATA
use PBC


IMPLICIT NONE
contains

    subroutine RAD_DIST_INTER(r,vec)
    ! We calculate the radial distribution value from distance differentials
    IMPLICIT NONE
    INTEGER i,coef,j
    REAL*8 dist,vec(:), r(:,:),dx,dy,dz
    DO i=1,n_particles
        DO j=1,n_particles
            IF (i.ne.j) THEN
                dx=PBC1(r(j,1)-r(i,1),L)
                dy=PBC1(r(j,2)-r(i,2),L)
                dz=PBC1(r(j,3)-r(i,3),L)
                dist=(dx**2d0+dy**2d0+dz**2d0)**0.5
                coef=int(0.5+dist/dx_radial)
                IF ((coef.gt.0).and.(coef.le.n_radial)) THEN
                    vec(coef)=vec(coef)+1.0
                END IF
            END IF
        END DO
    END DO
    end subroutine RAD_DIST_INTER

    subroutine RAD_DIST_FINAL(vec,n_gr_meas)
    ! We must perform an accumulation of g(r) to carry out a correct calculation
    ! We calculate the averages of the previous values
    IMPLICIT NONE
    INTEGER i,n_gr_meas
    REAL*8 vec(:),result(0:n_radial+1),aux
    vec=vec/(1d0*n_gr_meas*n_particles)
    result=0d0
    DO i=2,n_radial
        aux=(density*4d0*3.1415*((((i)*dx_radial)**3d0)-(((i-1)*dx_radial)**3d0)))/3d0
        result(i)=vec(i)/aux
    END DO
    vec=0d0
    vec=result
    end subroutine RAD_DIST_FINAL
end module Distribucio_Radial
