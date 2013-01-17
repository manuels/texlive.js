-- This is the Gates package, Lua version.
-- Relevant information can be found in gates-doc.pdf
-- (or gates-doc.txt in a text editor).
--
-- Author: Paul Isambert.
-- E-mail: zappathustra AT free DOT fr
-- Comments and suggestions are welcome.
-- Date: May 2012.

if gates then
  return
end

local _insert, _remove = table.insert, table.remove
local _gsub, _match, _format = string.gsub, string.match, string.format
local _write_nl, print_error
if texio then
  _write_nl, print_error = texio.write_nl, tex.error
else
  function _write_nl (s)
    print("\n" .. s)
  end
  print_error = error
end
local unpack, maxn = table.unpack or unpack
if lua.version == "Lua 5.1" then
  maxn = table.maxn
else
  local pairs, type = pairs, type
  function maxn (t)
    local max = 0
    for i in pairs(t) do
      if type(i) == "number" then
        max = i > max and i or max
      end
    end
    return max
  end
end
local function unpackargs (t)
  return unpack(t, 1, maxn(t))
end

local function _copy (tb)
  local t = {}
  for a, b in pairs (tb) do
    if type(b) == "table" then
      b = _copy(b)
    end
    t[a] = b
  end
  return t
end

-- Errors.
local function _error (...)
  print_error("Lua-Gates error: " .. _format(...))
end
local function _error_nogate (g)
  _error("`%s' isn't a gate", g)
end
local function _error_nogatelist (g)
  _error("`%s' isn't a gate list", g)
end
local function _error_nogatein (g, l)
  _error("No gate `%s' in list `%s'", g, l)
end

local function _check_family(fam, name)
  return _match(name, ":") and name or fam .. ":" .. name
end

-- Tracing and showing.
local function _write (...)
  _write_nl(_format(...))
end
local _tab, _white = "", ""
local function _addtab ()
  _tab = ". " .. _tab
  _white = "  " .. _white
end
local function _untab ()
  _tab = _gsub(_tab, ". ", "", 1)
  _white = _gsub(_white, "  ", "", 1)
end
local _trace_values = {}
local function trace (fam, n)
  _trace_values[fam] = n
end
local function _trace_value (name)
  return _trace_values[_match(name, "(.-):") or name] or 0
end
local function _report (fam, s, ...)
  if _trace_value(fam) > 0 then
    if _white == "" then
      _write(" ")
    end
    _write(_white .. s, ...)
  end
end
local function _reporttab (fam, s, ...)
  if _trace_value(fam) > 0 then
    _write(_tab .. s, ...)
  end
end

local _rawgate
local function _getinfo (g)
  local s = g.status == 1 and "open"
         or g.status == 2 and "ajar"
         or g.status == 3 and "skip"
         or g.status == 4 and "close"
  local c = tostring(g.conditional)
  local l = g.loop and tostring(g.loop)
  local u = g.loopuntil and tostring(g.loopuntil)
  local i = g.iterator and tostring(g.iterator)
  local a
  if type(g.autoreturn) == "function" then
    a = " (autoreturn: " .. tostring (g.autoreturn) .. ")"
  elseif g.autoreturn then
    a = " (autoreturn)"
  else
    a = ""
  end
  return s, c, l, u, i, a
end

local shown
local function _show (gate, tab)
  local g = _rawgate(gate.name)
  local s, c, l, u, i, a = _getinfo(gate)
  local info = _format(tab .. "%s (%s-gate) (status: %s) (conditional: %s)%s",
                       gate.name, g.list and "l" or "m", s, c, a)
  if l then
    info = _format(info .. " (loop: %s)", l)
  end
  if u then
    info = _format(info .. " (loopuntil: %s)", u)
  end
  if i then
    info = _format(info .. " (iterator: %s)", i)
  end
  _write(info)
  if g.list then
    if shown[g.name] then
      texio.write(" [subgates already shown]")
    else
      shown[g.name] = true
      for _, G in ipairs(g.list) do
        _show(G, tab .. ". ")
      end
    end
  end
end

local function show (fam, name)
  shown = {}
  name = _check_family(fam, name)
  local g = _rawgate(name)
  if g then
    _show(g, "")
  else
    _error_nogate(name)
  end
end

local _open  = 1
local _ajar  = 2
local _skip  = 3
local _close = 4
local _statuses = {
  open  = _open,
  ajar  = _ajar,
  skip  = _skip,
  close = _close
  }

-- Some functions can take one argument or
-- multiple arguments in a table.
local function _totable (x)
  return type(x) == "table" and x or {x}
end

local _default = function (...) return ... end

local execute = {[0] = {}}

function _rawgate (name) -- Localized above.
  return execute[0][name]
end

local function _getmax (tb)
  local max = 0
  for n in pairs (tb) do
    max = n > max and n or max
  end
  return max
end
local function _restoreargs (arg, orarg, autoreturn)
  -- autoreturn may be a function
  if autoreturn == true then
    local argmax, orargmax = _getmax(arg), _getmax(orarg)
    for i = argmax + 1, orargmax do
      arg[i] = orarg[i]
    end
  end
  return arg
end
local function _processfunction (fct, autoreturn, ...)
  if type(autoreturn) == "function" then
    return {autoreturn(...)}
  elseif autoreturn then
    local newarg = {fct(...)}
    local argmax, newargmax = _getmax(arg), _getmax(newarg)
    for i = newargmax + 1, argmax do
      newarg[i] = arg[i]
    end
    return newarg
  else
    return {fct(...)}
  end
end

local function _execute (f, sub, ...)
  local name, list, fct, status, conditional, loop, loopuntil, iterator, autoreturn =
    f.name, f.list, sub and execute[f.name] or f.fct, f.status, f.conditional, f.loop, f.loopuntil, f.iterator, f.autoreturn
  local action, report, t
  if sub then
    action, report, t = "Calling", _reporttab, "subgate " .. name
  else
    action, report, t = "Executing", _report, (list and "l" or "m") .. "-gate " .. name
  end
  local s = ""
  local orarg, arg = {...}, {...}
  if status == _open or status == _ajar then
    if status == _ajar then
      s = " (ajar -> close)"
      f.status = _close
    end
    if conditional(...) then
      report(name, "%s %s%s", action, t, s)
      if not sub and not list and _trace_value(name) > 1 then
        for i=1, maxn(arg) do
          _write_nl(_white .. "#" .. i .. "<-" .. tostring(arg[i]))
        end
      end
      if loop then
        while loop(unpackargs(arg)) do
          arg = {fct(unpackargs(arg))}
          orarg = _restoreargs(arg, orarg, autoreturn)
        end
      elseif loopuntil then
        repeat
          arg = {fct(unpackargs(arg))}
          orarg = _restoreargs(arg, orarg, autoreturn)
        until loopuntil(unpackargs(arg))
      elseif iterator then
        local iter, state, var = iterator(unpackargs(arg))
        while iter do
          local args = {iter(state, var)}
          if args[1] ~= nil then
            arg   =  {fct(unpackargs(args))}
            orarg = _restoreargs(arg, orarg, autoreturn)
            var = args[1]
          else
            break
          end
        end
      else
        arg = {fct(unpackargs(arg))}
        orarg = _restoreargs(arg, orarg, autoreturn)
      end
      if type(autoreturn) == "function" then
        arg = {autoreturn(...)}
      end
    else
      report(name, "Ignoring %s%s (False conditional)", t, s)
    end
  else
    if status == _skip then
      s = " (skip -> open)"
      f.status = _open
    else
      s = " (close)"
    end
    report(name, "Ignoring %s%s%s", t, s, conditional() and "" or " (False conditional)")
  end
  return unpackargs(arg)
end

execute.__index = function (_, name)
  local f = _rawgate(name)
  if f then
    return function (...)
      return _execute(f, nil, ...)
    end
  else
    _error_nogate(name)
    return _default
  end
end

setmetatable(execute, execute)

local function _evertrue ()
  return true
end

local function add (fam, tb, list, where)
  list = _check_family(fam, list)
  local gatelist = _rawgate(list)
  if gatelist and gatelist.list then
    tb = _totable(tb)
    local position
    if where then
      where = _match(where, "^%s*(.-)%s*$"):gsub("%s+", " ")
      if where == "first" or where == "before first" then
        position = 1
      elseif where == "after first" then
        position = 2
      elseif where == "last" or where == "after last" then
        position = #gatelist.list + 1
      elseif where == "before last" then
        position = #gatelist.list
      else
        local prep, gate = _match(where, "^(.-)%s+(.-)$")
        if prep and gate and (prep == "before" or prep == "after") then
          gate = _check_family(fam, gate)
          for n, g in ipairs(gatelist.list) do
            if g.name == gate then
              position = prep == "before" and n or n+1
              break
            end
          end
          if not position then 
            _error_nogatein(gate, list)
            return
          end
        else
          _error("Unknown position: `%s'", where)
          return
        end
      end
    else
      position = #gatelist.list + 1
    end
    local _tb = {}
    for _, x in ipairs(tb) do
      _insert(_tb, 1, x)
    end
    tb = _tb
    for _, name in ipairs(tb) do
      name = _check_family(fam, name)
      local macro = _rawgate(name)
      if macro then
        _insert(gatelist.list, position, { name = name, status = _open, conditional = _evertrue })
      else
        _error_nogate(name)
      end
    end
  else
    _error_nogatelist(list)
  end
end

local function remove (fam, tb, list)
  list = _check_family(fam, list)
  local gatelist = _rawgate(list)
  if gatelist and gatelist.list then
    tb = _totable(tb)
    for _, fct in ipairs(tb) do
      fct = _check_family(fam, fct)
      local n, found = 1
      while n <= #gatelist.list do
        if gatelist.list[n].name == fct then
          found = true
          _remove(gatelist.list, n)
        else
          n = n + 1
        end
      end
      if not found then
        _error_nogatein(fct, list)
      end
    end
  else
    _error_nogatelist(list)
  end
end

local function subgates (fam, list, fct)
  list = _check_family(fam, list)
  local gatelist = _rawgate(list)
  if gatelist and gatelist.list then
    for _, g in ipairs (gatelist.list) do
      fct(g.name)
    end
  else
    _error_nogatelist(list)
  end
end

local function _status (fam, fct, list, key, value)
  if list then
    list = _check_family(fam, list)
    local gatelist = _rawgate(list)
    if gatelist then
      if type(fct) == "string" and (_match(fct, "^before ") or _match(fct, "^after ")) then
        local prep, gate = _match(fct, "^(.-)%s+(.-)$")
        if prep and gate and (prep == "before" or prep == "after") then
          local list, position = gatelist.list
          if gate == "first" then
            position = 1
          elseif gate == "last" then
            position = #list
          else
            gate = _check_family(fam, gate)
            for n, g in ipairs(list) do
              if g.name == gate then
                position = n
                break
              end
            end
          end
          if position then
            if prep == "before" then
              for n, g in ipairs(list) do
                if n == position then
                  break
                else
                  g[key] = value
                end
              end
            else
              for n, g in ipairs(list) do
                if n > position then
                  g[key] = value
                end
              end
            end
          else
            _error_nogatein(gate, list)
          end
        else
          _error("Unknown position `%s'", fct)
        end
      else
        fct = _totable(fct)
        for _, func in ipairs(fct) do
          func = _check_family(fam, func)
          local found
          for n, tb in ipairs(gatelist.list) do
            if tb.name == func then
              found = true
              gatelist.list[n][key] = value
            end
          end
          if not found then
            _error_nogatein(func, list)
          end
        end
      end
    else
      _error_nogatelist(list)
    end
  else
    fct = _totable(fct)
    for _, func in ipairs(fct) do
      func = _check_family(fam, func)
      local macro = _rawgate(func)
      if macro then
        macro[key] = value
      else
        _error_nogate(func)
      end
    end
  end
end

local function open (fam, fct, list)
  _status(fam, fct, list, "status", _open)
end

local function ajar (fam, fct, list)
  _status(fam, fct, list, "status", _ajar)
end

local function skip (fam, fct, list)
  _status(fam, fct, list, "status", _skip)
end

local function close (fam, fct, list)
  _status(fam, fct, list, "status", _close)
end

local function conditional (fam, fct, list, cond)
  if type(list) == "string" then
    _status(fam, fct, list, "conditional", cond)
  else
    _status(fam, fct, nil, "conditional", list)
  end
end

local function loop (fam, fct, list, cond)
  if type(list) == "string" then
    _status(fam, fct, list, "loop", cond)
  else
    _status(fam, fct, nil, "loop", list)
  end
end

local function loopuntil (fam, fct, list, cond)
  if type(list) == "string" then
    _status(fam, fct, list, "loopuntil", cond)
  else
    _status(fam, fct, nil, "loopuntil", list)
  end
end

local function iterator (fam, fct, list, cond)
  if type(list) == "string" then
    _status(fam, fct, list, "iterator", cond)
  else
    _status(fam, fct, nil, "iterator", list)
  end
end

local function autoreturn (fam, fct, list, cond)
  if type(list) == "string" then
    _status(fam, fct, list, "autoreturn", cond)
  else
    _status(fam, fct, nil, "autoreturn", list)
  end
end


local function _store (tab)
  local name = tab[1]
  local fct = tab[2]
  local tb = {
    name        = name,
    status      = _statuses[tab.status or "open"],
    conditional = tab.conditional or _evertrue,
    loop        = tab.loop,
    loopuntil   = tab.loopuntil,
    iterator    = tab.iterator,
    autoreturn  = tab.autoreturn}
  if not fct then
    tb.list = {}
    fct = function (...)
      _addtab()
      local arg = {...}
      for n, func in ipairs(tb.list) do
        arg = {_execute(func, true, unpackargs(arg))}
      end
      _untab()
      return unpackargs(arg)
    end
  end
  tb.fct = fct
  execute[0][name] = tb
end

local function def (fam, tab)
  tab[1] = _check_family(fam, tab[1])
  _store(tab)
end

local function list (fam, tab)
  tab[1] = _check_family(fam, tab[1])
  local subgates = {}
  for i = 2, #tab do
    _insert(subgates, tab[i])
    tab[i] = nil
  end
  _store(tab)
  for _, g in ipairs(subgates) do
    g = type(g) == "string" and {g} or g
    g[1] = _check_family(fam, g[1])
    if type(g[2]) == "function" then
      _store({g[1], g[2]})
    elseif type(g[2]) == "table" or type(g[2]) == "string" then
      local a = {}
      for i = 2, #g do
        _insert(a, g[i])
      end
      list(fam, {g[1], unpack(a)})
    elseif not (_rawgate(g[1])) then
      _store({g[1]})
    end
    add(fam, g[1], tab[1])
    local s = g.status == "open" and _open
           or g.status == "ajar" and _ajar
           or g.status == "skip" and _skip
           or g.status == "close" and _close
           or _open
    _status(fam, g[1], tab[1], "status", s)
    local c = type(g.conditional) == "function" and g.conditional or _evertrue
    _status(fam, g[1], tab[1], "conditional", c)
    local l = type(g.loop) == "function" and g.loop
    _status(fam, g[1], tab[1], "loop", l)
    local L = type(g.loopuntil) == "function" and g.loopuntil
    _status(fam, g[1], tab[1], "loopuntil", L)
    local I = type(g.iterator) == "function" and g.iterator
    _status(fam, g[1], tab[1], "iterator", I)
    _status(fam, g[1], tab[1], "autoreturn", g.autoreturn)
  end
end

local function copy (fam, name1, name2)
  name1, name2 = _check_family(fam, name1), _check_family(fam, name2)
  local base = _rawgate(name2)
  if base then
    if base.list then
      _store(name1)
      _rawgate(name1).list = _copy(base.list)
    else
      _store(name1, base.fct)
    end
    _status(fam, name1, nil, "status", _open) -- Better than to copy the gate's status.
    _status(fam, name1, nil, "conditional", base.conditional)
    _status(fam, name1, nil, "loop", base.loop)
    _status(fam, name1, nil, "loopuntil", base.loopuntil)
    _status(fam, name1, nil, "iterator", base.iterator)
  else
    _error_nogate(name2)
  end
end

local function Type (fam, name)
  name = _check_family(fam, name)
  local macro = _rawgate(name)
  if macro then
    return macro.list and 2 or 1
  else
    return 0
  end
end

local function status (fam, gate, list)
  gate = _check_family(fam, gate)
  list = list and _check_family(fam, list)
  local fct = _rawgate(gate)
  list = list and _rawgate(list) and _rawgate(list).list
  if fct then
    if list then
      for _, g in ipairs(list) do
        if g.name == gate then
          return g.status
        end
      end
    else
      return fct.status
    end
  else
    return 0
  end
end

local _mt = {
  trace       = trace,
  show        = show,
  def         = def,
  list        = list,
  copy        = copy,
  add         = add,
  remove      = remove,
  open        = open,
  ajar        = ajar,
  skip        = skip,
  close       = close,
  type        = Type,
  status      = status,
  conditional = conditional,
  loop        = loop,
  loopuntil   = loopuntil,
  iterator    = iterator,
  autoreturn  = autoreturn,
  subgates    = subgates,
}

local function new (_, fam)
  local t = {family = fam}
  setmetatable(t, _mt)
  return t
end

_mt.new = new

_mt.__index = function (tb, name)
  if name == "execute" then
    return setmetatable({},
      {__call =
        function (_, name, ...)
          name = _check_family(tb.family, name)
          return execute[name](...)
        end,
        __index = function (_, name)
          name = _check_family(tb.family, name)
          return execute[name]
        end})
  elseif _mt[name] then
    return function (...) return _mt[name](tb.family, ...) end
  else
    name = _check_family(tb.family, name)
    local macro = _rawgate(name)
    if macro then
      return execute[name]
--    The following was removed because a gate instance can contain other
--    things than gates; for instance "gates.foo = 5" is valid. But one might
--    want to know whether an entry exists or not (e.g. "if gates.foo then" or
--    "if type(gates.foo) ~= 'nil' then"), in which case the next three lines
--    would produce an error (and return a function).
--    else
--      _error("`%s' isn't an action or a gate", name)
--      return _default
    end
  end
end

_mt.__newindex = function (tb, key, value)
  if _mt[key] then
    _error("You can't assign to key `%s', it is an action", key)
  else
    if type(value) == "function" then
      def(tb.family, {key, value})
    else
      local name = _check_family(tb.family, key)
      if _rawgate(name) then
        _error("You can't assign to key `%s', it is already a gate", key)
      else
        rawset(tb, key, value)
      end
    end
  end
end

gates = new(nil, "gates")
