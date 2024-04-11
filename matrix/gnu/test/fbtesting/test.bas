#include "fbtesting.bi"

using fbtesting

sub CallFail(byref t as Testing)
    t.Fail()
end sub

sub CallError(byref t as Testing)
    t.Error("Error called.")
end sub

sub Pass(byref t as Testing)
end sub

sub CallSkipError(byref t as Testing)
   t.Skip()
   t.Error("skipped error")
end sub

sub CallErrorSkip(byref t as Testing)
   t.Error("not skipped error")
   t.Skip()
end sub

dim tester as Testing = Testing("fbtesting")

sub TestEmpty(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Run()
   if myTester.Failed() then t.Error("Expected test to pass but it failed.")
end sub

sub TestPass(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Test(@pass)
   myTester.Run()
   if myTester.Failed() then t.Error("Expected test to pass but it failed.")
end sub

sub TestFail(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Test(@CallFail)
   myTester.Run()
   if not myTester.Failed() then t.Error("Expected test to fail but it passed.")
end sub

sub TestError(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Test(@CallError)
   myTester.Run()
   if not myTester.Failed() then t.Error("Expected test to fail but it passed.")
end sub

sub TestSkip(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Test(@CallSkipError)
   myTester.Run()
   if myTester.Failed() then t.Error("Expected test to pass but it failed.")
end sub

sub TestSkipError(byref t as Testing)
   dim myTester as Testing = Testing()
   myTester.Test(@CallErrorSkip)
   myTester.Run()
   if not myTester.Failed() then t.Error("Expected test to fail but it passed.")
end sub

tester.Test(@TestEmpty, "Test empty")
tester.Test(@TestPass, "Test passing")
tester.Test(@TestFail, "Test Fail")
tester.Test(@TestError, "Test Error")
tester.Test(@TestSkip, "Test Skip")
tester.Test(@TestSkipError, "Test fail Skip")

tester.Run()

if tester.Failed() then end 1
