# fbtesting

[![builds.sr.ht status](https://builds.sr.ht/~jlaasonen/fbtesting/commits/main/.build.yml.svg)](https://builds.sr.ht/~jlaasonen/fbtesting/commits/main/.build.yml?)

Minimal unit testing library for [FreeBASIC](https://www.freebasic.net/)

## Usage

```freebasic
' Include fbtesting.bas or fbtesting.bi.
#include "fbtesting.bas"
using fbtesting

' Create a test runner.
dim tester as Testing = Testing("Test Example")

' Create a test case.
sub mytest(byref t as Testing)
   dim result as integer = 1 + 1
   if result <> 2 then
      ' Use t.Error to report failure.
      t.Error("Test failed.")
   end if
end sub

' Register the test case.
tester.Test(@mytest, "Test Case")

' Test case can be skipped with t.Skip.
sub skipped(byref t as Testing)
   t.Skip()
   ' t.Error after t.Skip will be ignored.
   t.Error("Test failed.")
end sub

tester.Test(@skipped, "Skipped Test Case")

' Run tests
tester.Run()

' Use non-zero return value if tests fail.
if tester.Failed() then end 1
```

```sh
> fbc example.bas
> ./example
=== RUN       Test Case
--- PASS      Test Case
=== RUN       Skipped Test Case
--- SKIP      Skipped Test Case
PASS          Test Example
```

## Testing

fbtesting is used to test itself.

```sh
> fbc test.bas fbtesting.bas
> ./test
```

## Acknowledgements

The interface is inspired by [Go's testing package](https://pkg.go.dev/testing).
