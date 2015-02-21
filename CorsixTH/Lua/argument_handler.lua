
--[[ Copyright (c) 2015 jWilliam "sadger" Gatens

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. --]]

class "ArgumentHandler"
local argparse = require "argparse"

---@type ArgumentHandler
local ArgumentHandler = _G["ArgumentHandler"]

function ArgumentHandler:ArgumentHandler(...)
  self.parser = argparse()
  self:createParserOptions()
end

function ArgumentHandler:createParserOptions()
  local parser = self.parser

  -- Arguments - always passed in even if not specified by the user
  local config = dofile("config_finder")
  parser:argument "--config-file"
  :args(1)
  :argname "<config_file.txt>"
  :defmode "arg"
  :default(config)
  :description "Specify config file to use"

  parser:argument "--bitmap-dir"
  :args(1)
  :description "Dump language strings to the specified file"

  -- Options - only passed in if specified by the user
  parser:option "-d" "--connect-debugger"
  :args(1)
  :argname "mobdebug/dbpg"
  :default "dbpg"
  :defmode "arg"
  :description "Connect debugger"

  parser:option "--load-save"
  :args(1)
  :argname "<file.sav>"
  :description "Start the game with the specified save"

  parser:option "--dump-strings"
  :args(1)
  :argname "<dump-file.txt>"
  :description "Dump language strings to the specified file"

end

-- What it returns is not exactly identical - replaced with underscores etc.
--
function ArgumentHandler:getParsedCommandLine(...)
  local named_arguments = {...}
  --Remove the CorsixTH binary name from the arguments
  table.remove(named_arguments,1)
  return self.parser:parse(named_arguments)
end
