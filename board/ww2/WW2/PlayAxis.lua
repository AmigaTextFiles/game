--
-- Axis test script
--

-- Print ----------------------------------------------------------------------
function printUnit(u)
  printDebug(
    "id=" .. u.id ..
    " type=" .. u.type ..
    " owner=" .. u.owner ..
    " size=" .. u.size)
end


function printUnits(v)
  printDebug("Unit List:");
  for i=1,table.getn(v) do printUnit(v[i]) end
end


function printPolicyResults(policy_results)
  for i = 1, #policy_results do
    local results = policy_results[i]

    printDebug("Policy " .. i)
    for j=1, #results do
      local result = results[j]

      printDebug("territory.id=" .. result.id .. " weight=" .. result.weight)
    end
  end
end


-- Game -----------------------------------------------------------------------
function isAlly(owner)
  if owner == "SU" or owner == "UK" or owner == "US" then
    return true
  else
    return false
  end
end


function isAxis(owner)
  if owner == "DE" or owner == "JP" then
    return true
  else
    return false
  end
end


function attackPower(type)
  local factor = {}
  factor["INF"] = 1
  factor["ARM"] = 3
  factor["FTR"] = 3
  factor["BMB"] = 4

  if factor[type] == nil then
    return 0
  else
    return factor[type]
  end
end


function defensePower(unit)
  local factor = {}
  factor["INF"] = 2
  factor["ARM"] = 2
  factor["FTR"] = 4
  factor["BMB"] = 1

  if factor[unit.type] == nil then
    return 0
  else
    return factor[unit.type]
  end
end


-- Borders --------------------------------------------------------------------
borders = {}


function addBorder(id1, id2)
  local duplicate = false

  for i=1,#borders do
    if (borders[i].id1 == id1 and borders[i].id2 == id2) or
       (borders[i].id1 == id2 and borders[i].id2 == id1) then
      duplicate = true
      break
    end
  end

  if duplicate == false then
    borders[#borders + 1] = {id1 = id1, id2 = id2}
  end
end


function adjacentTo(id)
  adjacent = {}

  for i = 1, #borders do
    if borders[i].id1 == id then
      adjacent[#adjacent + 1] = borders[i].id2
    elseif borders[i].id2 == id then
      adjacent[#adjacent + 1] = borders[i].id1
    end
  end

  return adjacent
end


function findTerritory(map, id)
  for i = 1, #map do
    local territory = map[i]

    if territory.id == id then
      return territory
    end
  end

  return nil
end


-- Punch ----------------------------------------------------------------------
function defensePunch(force)
  local punch = 0
  local size = 0

  if force ~= nil then
    for i = 1, #force do
      local unit = force[i]

      punch = punch + defensePower(unit)
      size = size + unit.size
    end
  end

  return punch, size
end


-- Move List ------------------------------------------------------------------
MoveList = {}

function MoveList.new(units, results)
  local moves = {}

  for k, unit in pairs(units) do
    local adj = adjacentTo(unit.where)

    for k, target in pairs(adj) do
      for k, result in pairs(results) do
        if target == result.id then
          moves[#moves + 1] = {target=target, where=unit.where, id=unit.id, type=unit.type, size=unit.size}
        end
      end
    end
  end

  return moves
end


function MoveList.print(list)
  printDebug("Move List:");
  for k, move in pairs(list) do
    printDebug("target=" .. move.target ..
               " where=" .. move.where ..
               " id=" .. move.id ..
               " type=" .. move.type ..
               " size=" .. move.size)
  end
end


function MoveList.countTargets(list, id)
  local count = 0

  for k, move in pairs(list) do
    if move.id == id then
      count = count + 1
    end
  end

  return count
end


function MoveList.remove(list, moves)
  for m, move in pairs(moves) do
    for i, item in pairs(list) do
      if item.id == move.id then
        item.size = item.size - move.size
      end
    end
  end

  local i = 1
  while i <= #list do
    if list[i].size == 0 then
      table.remove(list, i)
    else
      i = i + 1
    end
  end
end


-- Attack Plan ----------------------------------------------------------------
AttackPlan = {}

function AttackPlan.new()
  return {}
end

function AttackPlan.append(plans, target, where, id, type)
  for k, plan in pairs(plans) do
    if plan.target == target and plan.id == id then
      plan.size = plan.size + 1
      return
    end
  end

  local plan = {target=target, where=where, id=id, type=type, size=1}
  plans[#plans + 1] = plan
end

function AttackPlan.punch(plans)
  local punch = 0

  for k, plan in pairs(plans) do
    punch = punch + attackPower(plan.type) * plan.size
  end

  return punch
end

function AttackPlan.size(plans)
  local size = 0

  for k, plan in pairs(plans) do
    size = size + plan.size
  end

  return size 
end

function AttackPlan.print(plans)
  printDebug("AttackPlan:")

  for k, plan in pairs(plans) do
    printDebug("target=" .. plan.target ..
               " where=" .. plan.where ..
               " id=" .. plan.id ..
               " type=" .. plan.type ..
               " size=" .. plan.size)
  end
end


-- doStartup ------------------------------------------------------------------
function doStartup()
  print("doStartup()")
  assert( joinGame("DE", "JP") )
  return true
end


-- doResearch -----------------------------------------------------------------
function doResearch()
  print("doResearch()");
  assert( endAction() )
end


-- doPurchaseUnits ------------------------------------------------------------
function doPurchaseUnits()
  print("doPurchaseUnits()");
  assert( endAction() )
end


-- doCombatMovement -----------------------------------------------------------
function doCombatMovement(nation)
  print("doCombatMovement(" .. nation .. ")");

  local map = getGameMap()

  -- Save territory borders for later routing (land only)
  for i = 1, #map do
    local territory = map[i]

    if territory.type == "LAND" then
      if territory.neighbors ~= nil then
        for i = 1, #territory.neighbors do
          local neighbor = findTerritory(map, territory.neighbors[i].id)

          if neighbor ~= nil and neighbor.type == "LAND" then
            addBorder(territory.id, territory.neighbors[i].id)
          end
        end
      end
    end
  end


  printDebug("Executing policies..")
  local policy_results = {}
  policy_results[1] = minimizeBordersPolicy(map, nation)
  policy_results[2] = bestIncomeValuePolicy(map, nation)
  policy_results[3] = noContestPolicy(map, nation)

  printDebug("Combining policy results..")
  local results = combinePolicyResults(policy_results)


  printDebug("Calculating defense capability..")
  for i = 1, #results do
    local result = results[i]

    local territory = findTerritory(map, result.id)
    local totalPunch, totalSize = defensePunch(territory.units)

    result.punch = totalPunch
    result.size  = totalSize

    printDebug("territory.id=" .. result.id .. " weight=" .. result.weight .. " punch=" .. result.punch .. " size=" .. result.size)
  end


  if #results > 0 then
    printDebug("Evaluating targets..")

    local plans = {}

    local units, cargo = getMoveableUnits()

    local list = MoveList.new(units, results)
    MoveList.print(list)

    for k, result in ipairs(results) do
      local newPlans = developAttackPlan(list, result)

      if newPlans ~= nil then
        for i = 1, #newPlans do
          table.insert(plans, newPlans[i])
        end
      end
    end


    printDebug("Executing plans.. #plans=" .. #plans)
    for i = 1, #plans do
      local plan = plans[i]

      printDebug("target=" .. plan.target .. " unit={" .. plan.where .. " " .. plan.type .. " " .. plan.size .. "}")

      local move_id = beginMove(plan.id)
      if move_id ~= 0 then
        sleep(1)

        if moveTo(move_id, plan.target) == true then
          local dsize = plan.size - 1
          if dsize > 0 then
            changeMoveSize(move_id, dsize)
          end

          if endMove(move_id) == true then
            printDebug(" move completed")
          end
        end
      end
    end
  end

  assert( endAction() )
end


function attackerMovesPolicy(moves, target)
  local target_moves = {}

  -- Filter out the moves not associated with the target.
  -- Those for the target will have a new move list created.
  for k, move in pairs(moves) do
    if move.target == target then
      local count = MoveList.countTargets(moves, move.id)

      for i = 1, move.size do
        local target_move = {target=move.target, where=move.where, id=move.id, type=move.type, count=count}
        target_moves[#target_moves + 1] = target_move
      end
    end
  end

  -- Sort by number of shared targets and then type.
  function compare(lhs, rhs)
    if lhs.count < rhs.count then
      return true
    end

    if lhs.count == rhs.count then
      if lhs.type == "INF" and rhs.type == "ARM" then
        return true
      end

      if lhs.type == "INF" and rhs.type == "FTR" then
        return true
      end

      if lhs.type == "INF" and rhs.type == "BMB" then
        return true
      end

      if lhs.type == "ARM" and rhs.type == "FTR" then
        return true
      end

      if lhs.type == "ARM" and rhs.type == "BMB" then
        return true
      end

      if lhs.type == "FTR" and rhs.type == "BMB" then
        return true
      end
    end

    return false
  end

  table.sort(target_moves, compare)

  return target_moves
end


function developAttackPlan(moves, result)
  printDebug("Developing attack plan for " .. result.id);

  local attackPunch = 0
  local attackSize  = 0
  local defendPunch = result.punch
  local defendSize  = result.size
  local target      = result.id

  local attacker_moves = attackerMovesPolicy(moves, target)

  local plans = AttackPlan.new()

  for k, move in ipairs(attacker_moves) do
    printDebug("target=" .. move.target .. " where=" .. move.where .. " id=" .. move.id .. " type=" .. move.type .. " count=" .. move.count)

    local punch = attackPower(move.type)
    if punch > 0 then
      AttackPlan.append(plans, target, move.where, move.id, move.type)

      local attackPunch = AttackPlan.punch(plans)
      local attackSize  = AttackPlan.size(plans)

      if attackPunch > defendPunch and attackSize > defendSize then
        printDebug("attack: size=" .. attackSize ..
                   " punch=" .. attackPunch ..
                   " defend: size=" .. defendSize ..
                   " punch=" .. defendPunch)

        MoveList.remove(moves, plans)
        return plans
      end
    end
  end

  printDebug("Aborting attack on " .. result.id)
  return nil
end


-- doChooseBattle -------------------------------------------------------------
function doChooseBattle(nation, battle_sites)
  print("doChooseBattle(" .. nation .. ")");
  return battle_sites[1]
end


-- doNonCombatMovement --------------------------------------------------------
function doNonCombatMovement()
  print("doNonCombatMovement()");
  sleep(1);
  assert( endAction() )
end


-- doPlaceNewUnits ------------------------------------------------------------
function doPlaceNewUnits()
  print("doPlaceNewUnits()");
  sleep(1);
  assert( endAction() )
end


-- doCollectIncome ------------------------------------------------------------
function doCollectIncome()
  print("doCollectIncome()");
  sleep(1);
  assert( endAction() )
end


-- doShutdown -----------------------------------------------------------------
function doShutdown()
  print("doShutdown()")
end


-- doChooseAAGunCasualties ----------------------------------------------------
function doChooseAAGunCasualties(where, hits, alive)
  print("doChooseAAGunCasualties()")
  printDebug("doChooseAAGunCasualties(" .. where ..")")
  printDebug("hits=" .. hits)
  printUnits(alive)

  if hits > 0 then
    killAircraft(where, alive, hits)
  end

  sleep(1)
end


function killAircraft(where, alive, casualties)
  for i = 1, #alive do
    local unit = alive[i]

    if unit.type == "FTR" or unit.type == "BMB" then
      if unit.size >= casualties then
        killAttacker(where, unit.id, casualties)
        casualties = 0
      else
        killAttacker(where, unit.id, unit.size)
        casualties = casualties - unit.size
      end

      if casualties == 0 then
        printDebug("finished choosing aagun casualties")
        return
      end
    end
  end
end


-- doChooseLandBattleAttackerCasualties ---------------------------------------
function doChooseLandBattleAttackerCasualties(where, hits, alive)
  print("doChooseLandBattleAttackerCasualties()")
  printDebug("doChooseLandBattleAttackerCasualties(" .. where ..")")
  printDebug("hits=" .. hits)

  sortLandBattleAttackers(alive)
  printUnits(alive)

  if hits > 0 then
    killAttackers(where, alive, hits)
  end

  sleep(1)
end


function sortLandBattleAttackers(units)
  function compare(lhs, rhs)
    if lhs.type == "INF" and rhs.type == "ARM" then
      return true
    end

    if lhs.type == "INF" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "INF" and rhs.type == "BMB" then
      return true
    end

    if lhs.type == "ARM" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "ARM" and rhs.type == "BMB" then
      return true
    end

    if lhs.type == "FTR" and rhs.type == "BMB" then
      return true
    end

    return false
  end

  table.sort(units, compare)
end


function killAttackers(where, alive, casualties)
  for i = 1, #alive do
    local unit = alive[i]

    if unit.size >= casualties then
      killAttacker(where, unit.id, casualties)
      casualties = 0
    else
      killAttacker(where, unit.id, unit.size)
      casualties = casualties - unit.size
    end

    if casualties == 0 then
      printDebug("attacker finished choosing casualties")
      return
    end
  end
end


-- doChooseLandBattleDefenderCasualties ---------------------------------------
function doChooseLandBattleDefenderCasualties(where, hits, alive)
  print("doChooseLandBattleDefenderCasualties()")
  printDebug("doChooseLandBattleDefenderCasualties(" .. where ..")")
  printDebug("hits=" .. hits)

  sortLandBattleDefenders(alive)
  printUnits(alive)

  if hits > 0 then
    killDefenders(where, alive, hits)
  end

  sleep(1)
end


function sortLandBattleDefenders(units)
  function compare(lhs, rhs)
    if lhs.type == "INF" and rhs.type == "ARM" then
      return true
    end

    if lhs.type == "INF" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "INF" and rhs.type == "BMB" then
      return true
    end

    if lhs.type == "ARM" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "ARM" and rhs.type == "BMB" then
      return true
    end

    if lhs.type == "FTR" and rhs.type == "BMB" then
      return true
    end

    return false
  end

  table.sort(units, compare)
end


-- doChooseSeaBattleDefenderCasualties ----------------------------------------
function doChooseSeaBattleDefenderCasualties(where, hits, alive)
  print("doChooseSeaBattleDefenderCasualties()")
  printDebug("doChooseSeaBattleDefenderCasualties(" .. where .. ")")
  printDebug("hits=" .. hits)

  sortSeaBattleDefenders(alive)
  printUnits(alive)

  if hits > 0 then
    killDefenders(where, alive, hits)
  end

  sleep(1)
end


function sortSeaBattleDefenders(units)
  function compare(lhs, rhs)
    if lhs.type == "TRN" and rhs.type == "SUB" then
      return true
    end

    if lhs.type == "TRN" and rhs.type == "BB" then
      return true
    end

    if lhs.type == "TRN" and rhs.type == "AC" then
      return true
    end

    if lhs.type == "TRN" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "SUB" and rhs.type == "BB" then
      return true
    end

    if lhs.type == "SUB" and rhs.type == "AC" then
      return true
    end

    if lhs.type == "SUB" and rhs.type == "FTR" then
      return true
    end

    if lhs.type == "FTR" and rhs.type == "BB" then
      return true
    end

    if lhs.type == "FTR" and rhs.type == "AC" then
      return true
    end

    if lhs.type == "BB" and rhs.type == "AC" then
      return true
    end

    return false
  end

  table.sort(units, compare)
end


function killDefenders(where, alive, casualties)
  for i = 1, #alive do
    local unit = alive[i]

    if unit.size >= casualties then
      killDefender(where, unit.id, casualties)
      casualties = 0
    else
      killDefender(where, unit.id, unit.size)
      casualties = casualties - unit.size
    end

    if casualties == 0 then
      printDebug("defender finished choosing casualties")
      return
    end
  end
end


-- doChooseSeaBattleDefenderNavalCasualties -----------------------------------
function doChooseSeaBattleDefenderNavalCasualties(where, hits, alive)
  print("doChooseSeaBattleDefenderNavalCasualties()")
  printDebug("doChooseSeaBattleDefenderNavalCasualties(" .. where .. ")")
  printDebug("hits=" .. hits)
  printUnits(alive)

  if hits > 0 then
    killNavalDefenders(where, alive, hits)
  end

  sleep(1)
end


function killNavalDefenders(where, alive, casualties)
  for i = 1, #alive do
    unit = alive[i]

    if unit.type == "BB" or
       unit.type == "AC" or
       unit.type == "TRN" or
       unit.type == "SUB" then
      if unit.size >= casualties then
        killDefender(where, unit.id, casualties)
        casualties = 0
      else
        killDefender(where, unit.id, unit.size)
        casualties = casualties - unit.size
      end
    end

    if casualties == 0 then
      printDebug("defender finished choosing casualties")
      return
    end
  end
end


-- doChooseSeaBattleDefenderWithdrawals ---------------------------------------
function doChooseSeaBattleDefenderWithdrawals(where, alive)
  print("doChooseSeaBattleDefenderWithdrawals()")
  printDebug("doChooseSeaBattleDefenderWithdrawals(" .. where .. ")")
  printUnits(alive)

  return nil

--[[ This only works for NAO at this time so disable it.
  local withdrawn = false

  for i = 1, #alive do
    local unit = alive[i]

    if unit.type == "SUB" then
      if withdrawUnit(where, unit.id) then
        withdrawn = true
      end
    end
  end

  sleep(1)

  if withdrawn then
    return "NAO"
  else
    return nil
  end
]]--
end


-- Policies -------------------------------------------------------------------
function minimizeBordersPolicy(map, nation)
  -- Create a table of target territory IDs with a count of how many
  -- of the nation's territories are adjacent to it.
  local targets = {}

  for i = 1, #map do
    local territory = map[i]

    if territory.owner == nation then
      local adj = adjacentTo(territory.id)

      for j = 1, #adj do
        local neighbor = findTerritory(map, adj[j])

        if isAlly(neighbor.owner) then
          local target = neighbor

          if targets[target.id] == nil then
            targets[target.id] = 1
          else
            targets[target.id] = targets[target.id] + 1
          end
        end
      end
    end
  end

  -- Find the maximum adjacency count.
  max = 1 -- Avoid division by zero.
  for k, v in pairs(targets) do
    if v > max then
      max = v
    end
  end

  -- The results are a table of territory IDs and a weighting percentage.
  results = {}

  i = 1
  for k, v in pairs(targets) do
    results[i] = {id = k, weight = 100 * v / max}
    i = i + 1
  end

  return results
end


function bestIncomeValuePolicy(map, nation)
  -- Create a table of target territory IDs with income values that are
  -- adjacent to the nation's territories.
  local targets = {}

  for i = 1, #map do
    local territory = map[i]

    if territory.owner == nation then
      local adj = adjacentTo(territory.id)

      for j = 1, #adj do
        local neighbor = findTerritory(map, adj[j])

        if isAlly(neighbor.owner) and neighbor.income > 0 then
          local target = neighbor

          if targets[target.id] == nil then
            targets[target.id] = target.income
          end
        end
      end
    end
  end

  -- Find the maximum income value.
  max = 1 -- Avoid division by zero.
  for k, v in pairs(targets) do
    if v > max then
      max = v
    end
  end

  -- The results are a table of territory IDs and a weighting percentage.
  results = {}

  i = 1
  for k, v in pairs(targets) do
    results[i] = {id = k, weight = 100 * v / max}
    i = i + 1
  end

  return results
end


function noContestPolicy(map, nation)
  -- Create a table of target territory IDs that contain no enemy units.
  local targets = {}

  for i = 1, #map do
    local territory = map[i]

    if territory.owner == nation then
      local adj = adjacentTo(territory.id)

      for j = 1, #adj do
        local neighbor = findTerritory(map, adj[j])

        if isAlly(neighbor.owner) and neighbor.units == nil then
          local target = neighbor

          if targets[target.id] == nil then
            targets[target.id] = true
          end
        end
      end
    end
  end

  -- The results are a table of territory IDs and a weighting percentage.
  results = {}

  i = 1
  for k, v in pairs(targets) do
    results[i] = {id = k, weight = 100}
    i = i + 1
  end

  return results
end


-- Policy combiner ------------------------------------------------------------
function combinePolicyResults(policy_results)
  -- Create a table of target territory IDs with the weighted average
  -- from all the policies that were applied. Table is sorted from the
  -- highest average to the lowest.
  local targets = {}

  for i = 1, #policy_results do
    local results = policy_results[i]

    for j = 1, #results do
      local result = results[j]

      local target = nil

      for k = 1, #targets do
        if targets[k].id == result.id then
          target = targets[k]
          break
        end
      end

      if target == nil then
        target = {id = result.id, total = result.weight}
        targets[#targets + 1] = target
      else
        target.total = target.total + result.weight
      end
    end
  end

  local results = {}

  for i = 1, #targets do
    local target = targets[i]
    results[i] = {id = target.id, weight = target.total / #policy_results}
  end

  function compare(lhs, rhs)
    return rhs.weight < lhs.weight
  end

  table.sort(results, compare)

  return results
end
