program test

  implicit none
  integer :: exit_code
  
  exit_code = monadic_sfp32()
  stop exit_code

contains

integer function monadic_sfp32() result(r)
  use FEQParse
  use iso_fortran_env
  implicit none
  integer,parameter :: N = 10
  type(EquationParser) :: f
  character(LEN=1),dimension(1:3) :: independentVars
  character(LEN=2048) :: eqChar
  real(real32) :: x(1:3)
  real(real32) :: feval
  real(real32) :: fexact
  integer :: i

  ! Specify the independent variables
  independentVars = (/'x','y','z'/)

  ! Specify an equation string that we want to evaluate
  eqChar = 'f = -(x + 1)'

  ! Create the EquationParser object
  f = EquationParser(eqChar,independentVars)

  x = 0.0_real32
  fexact = -(x(1)+1.0_real32)

  ! Evaluate the equation
  feval = f % evaluate(x)
  if ((abs(feval - fexact)) <= epsilon(1.0_real32)) then
    r = 0
  else
    r = 1
  end if

end function monadic_sfp32
end program test
