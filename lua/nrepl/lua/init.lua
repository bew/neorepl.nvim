local api = vim.api
---Reference to global print function
local prev_print = _G.print

---@class nreplLua
---@field repl nreplRepl    parent
---@field env table         repl environment
---@field print fun(...)    print function
local Lua = {}
Lua.__index = Lua

---Create a new lua context
---@param repl nreplRepl
---@param config nreplConfig
---@return nreplLua
function Lua.new(repl, config)
  local this = setmetatable({
    repl = repl,
  }, Lua)

  -- print override
  this.print = function(...)
    local args = {...}
    for i, v in ipairs(args) do
      args[i] = tostring(v)
    end
    local lines = vim.split(table.concat(args, '\t'), '\n', { plain = true })
    repl:put(lines, 'nreplOutput')
  end

  this.env = setmetatable({
    ---access to global environment
    global = _G,
    ---print function override
    print = this.print,
  }, {
    __index = function(t, key)
      return rawget(t, key) or rawget(_G, key)
    end,
  })

  -- add user environment
  local userenv = config.env_lua
  if userenv then
    (function()
      if type(userenv) == 'function' then
        local ok, res = pcall(userenv)
        if not ok then
          local err = vim.split(res, '\n', { plain = true })
          table.insert(err, 1, 'Error from user env:')
          repl:put(err, 'nreplError')
          return this.repl:new_line()
        elseif type(res) == nil then
          return
        elseif type(res) ~= 'table' then
          repl:put({'Result of user env is not a table'}, 'nreplError')
          return this.repl:new_line()
        else
          userenv = res
        end
      end

      for k, v in pairs(userenv) do
        this.env[k] = v
      end
    end)()
  end

  return this
end

---@type function
---@param f function
---@return boolean ok, table results, number result count
local exec do
  ---Gather results from pcall
  local function pcall_res(ok, ...)
    if ok then
      -- return returned values as a table and its size,
      -- because when iterating ipairs will stop at nil
      return ok, {...}, select('#', ...)
    else
      return ok, ...
    end
  end

  function exec(f)
    local coro = coroutine.create(f)
    local ok, res, n = pcall_res(coroutine.resume(coro))
    if not ok then
      if debug.getinfo(coro, 0, 'f').func ~= f then
        res = debug.traceback(coro, res, 0)
      end
    end
    return ok, res, n
  end
end

---Evaluate lua and append output to the buffer
---@param prg string
---@return nil|boolean
function Lua:eval(prg)
  if type(prg) == 'table' then
    prg = table.concat(prg, '\n')
  elseif type(prg) ~= 'string' then
    error('invalid prg type')
  end

  local ok, res, err, n
  res = loadstring('return '..prg, 'nrepl')
  if not res then
    res, err = loadstring(prg, 'nrepl')
  end

  if res then
    setfenv(res, self.env)

    if not self.repl:exec_context(function()
      -- temporarily replace print
      _G.print = self.print
      ok, res, n = exec(res)
      _G.print = prev_print
      if self.repl.redraw then
        vim.cmd('redraw')
      end
    end) then
      return
    end

    if not ok then
      self.repl:put(vim.split(res, '\n', { plain = true }), 'nreplError')
    else
      local stringify = self.repl.inspect and vim.inspect or tostring
      for i = 1, n do
        res[i] = stringify(res[i])
      end
      if #res > 0 then
        self.repl:put(vim.split(table.concat(res, ', '), '\n', { plain = true }), 'nreplValue')
      end
    end
  elseif err:match("'<eof>'$") then
    -- more input expected, add line break
    api.nvim_buf_set_lines(self.repl.bufnr, -1, -1, false, {'\\'})
    vim.cmd('$')
    return false
  else
    self.repl:put({err}, 'nreplError')
  end
end

do
  local complete = nil
  ---Complete line
  ---@param line string
  ---@return string[] results, number position
  function Lua:complete(line)
    if complete == nil then
      complete = require('nrepl.lua.complete').complete
    end

    -- merge environments on the fly, because
    -- I don't know how to do it cleanly otherwise
    local env = {}
    for k, v in pairs(_G) do
      env[k] = v
    end
    for k, v in pairs(self.env) do
      env[k] = v
    end

    -- TODO: concat with previous lines
    local results, pos = complete(line, env)
    if results and #results > 0 then
      return pos + 1, results
    end
  end
end

return Lua
