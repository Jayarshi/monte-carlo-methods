program random_walks
    implicit none

    integer :: dim, nsteps, ens, i, j
    real :: u, dx, dy, dz, r2
    real, allocatable :: msd(:), meanx(:), meany(:), xtraj(:), ytraj(:)

    print *, "Input dimension (1 or 2), nsteps, ensemble size"
    read *, dim, nsteps, ens

    if (dim /= 1 .and. dim /= 2) then
        print *, "Error: dimension must be 1 or 2."
        stop
    endif

    allocate(msd(0:nsteps))
    allocate(meanx(0:nsteps))
    allocate(meany(0:nsteps))
    allocate(xtraj(0:nsteps))
    allocate(ytraj(0:nsteps))

    msd = 0.0
    meanx = 0.0
    meany = 0.0

    do j = 1, ens
        xtraj = 0.0
        ytraj = 0.0

        do i = 1, nsteps
            if (dim == 1) then
                call random_number(u)
                if (u < 0.5) then
                    dx = -1.0
                else
                    dx = 1.0
                endif
                xtraj(i) = xtraj(i-1) + dx
                ytraj(i) = 0.0
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
                xtraj(i) = xtraj(i-1) + dx
                ytraj(i) = ytraj(i-1) + dy
            endif
        enddo

        do i = 0, nsteps
            r2 = xtraj(i)*xtraj(i) + ytraj(i)*ytraj(i)
            meanx(i) = meanx(i) + xtraj(i)
            meany(i) = meany(i) + ytraj(i)
            msd(i) = msd(i) + r2
        enddo
    enddo

    meanx = meanx / ens
    meany = meany / ens
    msd = msd / ens

    open(unit=10, file="random_walk_data.dat", status="replace")
    write(10,*) "# step mean_x mean_y msd"
    do i = 0, nsteps
        write(10,*) i, meanx(i), meany(i), msd(i)
    enddo
    close(10)

    print *, "Data written to random_walk_data.dat"

end program random_walks
