function contains(table, item)
  return find_key(table, item) ~= nil
end
function find_key(table, item)
  for k, v in _G.pairs(table) do
    if item == v then
      return k
    end
  end
  return nil
end
function deepCopy(item)
  local ret
  if _G.type(item) == "table" then
    ret = {}
    for k, v in _G.pairs(item) do
      ret[k] = deepCopy(v)
    end
  else
    ret = item
  end
  return ret
end
function accumulate(table)
  local sum = 0
  for _, v in _G.pairs(table) do
    sum = sum + v
  end
  return sum
end
Set = {}
function Set.intersection(t1, t2)
  local result = {}
  for _, v1 in _G.pairs(t1) do
    for _, v2 in _G.pairs(t2) do
      if v1 == v2 then
        _G.table.insert(result, v1)
      end
    end
  end
  return result
end
function Set.difference(t1, t2)
  local result = {}
  for _, v1 in _G.pairs(t1) do
    local found = false
    for _, v2 in _G.pairs(t2) do
      if v1 == v2 then
        found = true
        break
      end
    end
    if not found then
      _G.table.insert(result, v1)
    end
  end
  return result
end
function formatCurrency(amount, currency)
  if currency == "USD" then
    return "$" .. _G.string.format("%.2f", amount)
  end
end
function countdownTimeParts(time)
  return _G.math.floor(time / 60), _G.string.format("%02u", _G.math.floor(time % 60)), _G.string.format("%02u", _G.math.floor(time % 1 * 100))
end
filename = "utils.lua"
