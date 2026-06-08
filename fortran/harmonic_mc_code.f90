program harmonic_monte_carlo
implicit none

integer :: idx, nout
integer :: totstep, eqstep
real(8) :: k, maxdx, x0, acc_rate
real(8), allocatable :: x_arr(:), e_arr(:)

print *, "Input: totstep eqstep k maxdx x0"
read *, totstep, eqstep, k, maxdx, x0

nout = totstep - eqstep
allocate(x_arr(nout), e_arr(nout))

call mc_harmonic(totstep, eqstep, nout, k, maxdx, x0, x_arr, e_arr, acc_rate)

open(unit=10, file="harmonic_mc_data.dat")
do idx = 1, nout
    write(10,*) idx, x_arr(idx), e_arr(idx)
enddo
close(10)

print *, "Acceptance rate = ", acc_rate
print *, "Mean x = ", sum(x_arr)/real(nout,8)
print *, "Mean E = ", sum(e_arr)/real(nout,8)

contains

subroutine mc_harmonic(totstep, eqstep, nout, k, maxdx, x0, x_arr, e_arr, acc_rate)
implicit none

integer, intent(in) :: totstep, eqstep, nout
real(8), intent(in) :: k, maxdx, x0
real(8), intent(out) :: x_arr(nout), e_arr(nout), acc_rate

integer :: step, idx, accepted
real(8) :: x, nrg, dx, xtry, nrgtry, prob, boltz

x = x0
nrg = 0.5d0 * k * x**2
idx = 0
accepted = 0

do step = 1, totstep
    call random_number(dx)
    dx = (2.0d0*dx - 1.0d0) * maxdx

    xtry = x + dx
    nrgtry = 0.5d0 * k * xtry**2

    if (nrgtry <= nrg) then
        x = xtry
        nrg = nrgtry
        accepted = accepted + 1
    else
        boltz = exp(-(nrgtry - nrg))
        call random_number(prob)
        if (prob <= boltz) then
            x = xtry
            nrg = nrgtry
            accepted = accepted + 1
        endif
    endif

    if (step > eqstep) then
        idx = idx + 1
        x_arr(idx) = x
        e_arr(idx) = nrg
    endif
enddo

acc_rate = real(accepted,8) / real(totstep,8)

end subroutine mc_harmonic

end program harmonic_monte_carlo
