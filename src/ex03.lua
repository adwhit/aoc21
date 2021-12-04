function read_lines()
  local lines = {}
  for line in io.lines("data/03") do
    lines[#lines + 1] = line
  end
  return lines
end

function get_counts(lines)
  local counts = {}
  for _k, line in pairs(lines) do
    for ix = 1, #line  do
      local n = tonumber(line:sub(ix, ix))
      counts[ix] = (counts[ix] or 0) + n
    end
  end
  return counts
end

function first()
  lines = read_lines()
  counts = get_counts(lines)
  gamma_str = ""
  epsilon_str = ""

  for ix = 1, #counts  do
    if counts[ix] > #lines / 2 then
      gamma_str = gamma_str .. "1"
      epsilon_str = epsilon_str .. "0"
    else
      gamma_str = gamma_str .. "0"
      epsilon_str = epsilon_str .. "1"
    end
  end

  res = tonumber(gamma_str, 2)
  res2 = tonumber(epsilon_str, 2)
  print("ex03 pt1", res * res2)

end

function get_most_popular_bit(lines, index)
  local count = 0
  for _k, line in pairs(lines) do
    local bit = tonumber(line:sub(index, index))
    count = count + bit
  end
  if count >= #lines / 2 then
      return 1
  else
    return 0
  end
end

function second()
  lines = read_lines()
  local iters = string.len(lines[1])
  local oxygen = lines
  local co2 = lines
  for ix = 1, iters do
    local oxygen_next = {}
    local co2_next = {}
    o2_target = get_most_popular_bit(oxygen, ix)

    not_co2_target = get_most_popular_bit(co2, ix)
    co2_target = 1 - not_co2_target

    for _, line in pairs(oxygen) do
      local bit = tonumber(line:sub(ix, ix))
      if o2_target == bit then
        oxygen_next[#oxygen_next + 1] = line
      end
    end

    for _, line in pairs(co2) do
      local bit = tonumber(line:sub(ix, ix))
      if co2_target == bit then
        co2_next[#co2_next + 1] = line
      end
    end

    if #oxygen ~= 1 then
      oxygen = oxygen_next
    end
    if #co2 ~= 1 then
      co2 = co2_next
    end

  end
  local res = tonumber(oxygen[1], 2) * tonumber(co2[1], 2)
  print("ex03 pt2", res)
end

first()
second()
