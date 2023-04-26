module Andersen_modul

use READ_DATA
use parallel_routines

IMPLICIT NONE

contains

    subroutine Andersen(v,temp)
    ! Andersen's thermostat subroutine: the sistem is in contact with a heat bath
    IMPLICIT NONE
    INTEGER i, k
    REAL*8 temp,nu,n1,n2,n3,n4, n5
    REAL*8 temp1
    REAL*8, DIMENSION(:,:) :: v
    nu=0.1
    temp1=sqrt(temp)
    DO i=index_matrix(taskid+1,1), index_matrix(taskid+1,2)
      call random_number(n5)
        IF(n5.lt.nu)THEN
            call random_number(n1)
            call random_number(n2)
            call random_number(n3)
            call random_number(n4)
            v(i,1)=temp1*sqrt(-2d0*log(n1))*cos(2d0*3.1415*n2)
            v(i,2)=temp1*sqrt(-2d0*log(n1))*sin(2d0*3.1415*n2)
            v(i,3)=temp1*sqrt(-2d0*log(n3))*cos(2d0*3.1415*n4)
        END IF
    END DO
    end subroutine Andersen

end module Andersen_modul
