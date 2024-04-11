#pragma once

namespace fbtesting

   enum TestResult
      Passed 
      Failed
      Skipped
   end enum

   type Testing
      public:
         declare constructor(byref name_ as const string = "")
         declare sub Test(byref c as const sub(byref t as Testing), byref name_ as const string = "")
         declare sub Run()
         declare function Failed() as boolean
          
         declare sub Fail()
         declare sub Log(byref message as const string)
         declare sub Error(byref message as const string)
         declare sub Skip()
      private:
         name as string
         isFailed as boolean
         currentState as TestResult
         testCases(any) as sub(byref t as Testing )
         testNames(any) as string
         results(any) as string
   end type

end namespace
