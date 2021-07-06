# Package

version       = "0.1.0"
author        = "cvanelteren"
description   = "Complexity toolbox"
license       = "GPL-3.0-or-later"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["complexity"]
backend       = "cpp"


# Dependencies

requires "nim >= 1.5.1"
requires "nimpy"

task test, "Run the tests":
  exec "nim cpp -r tests/test.nim"
