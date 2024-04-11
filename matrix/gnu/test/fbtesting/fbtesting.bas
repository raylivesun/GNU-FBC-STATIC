#include "fbtesting.bi"

namespace fbtesting

function StateString(byval result as const TestResult) as string
   select case as const result
   case TestResult.Passed
      return "PASS"
   case TestResult.Failed
      return "FAIL"
   case TestResult.Skipped
      return "SKIP"
   end select
end function

constructor Testing (byref name_ as const string = "")
   this.name = name_
end constructor

sub Testing.Test(byref c as const sub(byref t as Testing ), byref testName as const string = "")
   redim preserve this.testCases(ubound(this.testCases) + 1)
   redim preserve this.testNames(ubound(this.testNames) + 1)
   this.testCases(ubound(this.testCases)) = c
   this.testNames(ubound(this.testNames)) = testName
end sub

sub Testing.Run()
   for testIndex as integer = 0 to ubound(this.testCases)
      dim testName as string = this.testNames(testIndex)
      if(testName = "") then testName = "Test " & testIndex+1
      print "=== RUN", testName
      erase this.results
      this.currentState = TestResult.Passed
      this.testCases(testIndex)(this)
      this.isFailed = this.isFailed or this.currentState = TestResult.Failed
      if this.currentState = TestResult.Failed then
         for messageIndex as integer = lbound(this.results) to ubound(this.results)
            print this.results(messageIndex)
         next
      end if
      print "--- "; StateString(this.currentState), testName
   next

   dim numTests as uinteger = ubound(this.testCases) - lbound(this.testCases) + 1
   if numTests < 1 then
      print "?", this.name
   elseif this.isFailed then
      print "FAIL", this.name
   else
      print "PASS", this.name
   end if
end sub

function Testing.Failed() as boolean
   return this.isFailed
end function

sub Testing.Fail()
   if this.currentState <> TestResult.Skipped then 
      this.currentState = TestResult.Failed
   end if
end sub

sub Testing.Skip()
   if this.currentState <> TestResult.Failed then 
      this.currentState = TestResult.Skipped
   end if
end sub

sub Testing.Log(byref message as const string)
   redim preserve this.results(ubound(this.results) + 1)
   this.results(ubound(this.results)) = message
end sub

sub Testing.Error(byref message as const string)
   this.log(message)
   this.Fail() 
end sub

end namespace
