/'
Static Variables
Static variables are used within subroutines and functions and retain their values
between calls to the subroutine or functions. The following program demonstrates using a
static variable as a counter within a subroutine.
'/ 

Sub Routines() 
' static variables are used within subroutines and functions and retain their values

Static values As Integer

' create a static variable as a counter in a subroutine
values += 1

' print the value of the counter
print *, values

End

