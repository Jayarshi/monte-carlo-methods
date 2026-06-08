subroutine random_walk_store(dim,nsteps,ens,xstore,ystore,times)
    implicit none

    integer :: dim,nsteps,ens
    integer :: i,j
    real :: u,dx,dy
    real :: xstore(ens,nsteps+1), ystore(ens,nsteps+1)
    real :: times(nsteps+1)

!f2py intent(in) dim,nsteps,ens
!f2py intent(in,out) xstore,ystore,times
!f2py depend(ens,nsteps) xstore,ystore
!f2py depend(nsteps) times

    if (dim /= 1 .and. dim /= 2) then
        return
    endif

    do i = 1, nsteps+1
        times(i) = real(i-1)
    enddo

    do j = 1, ens
        xstore(j,1) = 0.0
        ystore(j,1) = 0.0

        do i = 2, nsteps+1
            if (dim == 1) then
                call random_number(u)
                if (u < 0.5) then
                    dx = -1.0
                else
                    dx = 1.0
                endif
                dy = 0.0
            else
                call random_number(u)
                if (u < 0.25) then
                    dx = 1.0;  dy = 0.0
                else if (u < 0.50) then
                    dx = -1.0; dy = 0.0
                else if (u < 0.75) then
                    dx = 0.0;  dy = 1.0
                else
                    dx = 0.0;  dy = -1.0
                endif
            endif

            xstore(j,i) = xstore(j,i-1) + dx
            ystore(j,i) = ystore(j,i-1) + dy
        enddo
    enddo

end subroutine random_walk_store
