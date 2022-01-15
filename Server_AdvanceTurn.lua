function Server_AdvanceTurn_End(game, addNewOrder)

	if Mod.PublicGameData.TooManyBonus then
		return
	end
	local IncomeMods = {}
	
	for ID, Player in pairs(game.Game.PlayingPlayers) do
		IncomeMods[ID] = {}
	end
	
	
	local Borders = Mod.PublicGameData.Borders
	local BonusesToUse = Mod.PublicGameData.BonusesToUse
	local Owners = {}
	local Complete = {}
	for _, Bonus in pairs(BonusesToUse) do

		local BonusOwners = {}
		
		-- Check whether the bonus still conatins neutral elements
		local ContainsNeutral = false

		for _, TerrID in pairs(game.Map.Bonuses[Bonus].Territories) do
			local PlayerOwnerId = game.ServerGame.LatestTurnStanding.Territories[TerrID].OwnerPlayerID
			BonusOwners[TerrID] = PlayerOwnerId
			if PlayerOwnerId == WL.PlayerID.Neutral then
				ContainsNeutral = true
			end
		end
		
		Owners[Bonus] = BonusOwners
		
		local IsComplete = not ContainsNeutral
		
		-- Only try when there are no neutrals
		if IsComplete then
			local OwnersOrdered = {}
			for _, TerrOwner in pairs(BonusOwners) do
				OwnersOrdered[#OwnersOrdered + 1] = TerrOwner
			end
			for _, TerrOwner in pairs(OwnersOrdered) do
				if TerrOwner ~= OwnersOrdered[1] then
					IsComplete = false
				end
			end
		end
		Complete[Bonus] = IsComplete
		
	end
	for Bonus1ID, Bonus1Borders in pairs(Borders) do
		for Bonus2ID, Bonus2Borders in pairs(Bonus1Borders) do
			-- If both bonuses are taken, then either different players have the bonuses (no Landria changes), or a player holds both bonuses (Landria compensation).
			if not (Complete[Bonus1ID] and Complete[Bonus2ID]) then
				for _, TerrTuple in pairs(Bonus2Borders) do
					local Terr1ID, Terr2ID = TerrTuple[1], TerrTuple[2]
					local Owner1 = game.ServerGame.LatestTurnStanding.Territories[Terr1ID].OwnerPlayerID
					local Owner2 = game.ServerGame.LatestTurnStanding.Territories[Terr2ID].OwnerPlayerID
					if Owner1 == Owner2 and Owner1 ~= WL.PlayerID.Neutral then
						local IncomeMod = WL.IncomeMod.Create(Owner1, -1, 'Border between ' .. game.Map.Territories[Terr1ID].Name .. ' and ' .. game.Map.Territories[Terr2ID].Name)
						IncomeMods[Owner1][#IncomeMods[Owner1] + 1] = IncomeMod
					end
				end
			end
		end
	end
	
	for ID, Player in pairs(game.Game.PlayingPlayers) do
		if #IncomeMods[ID] > 0 then
			addNewOrder(WL.GameOrderEvent.Create(ID, "Landria rules cost you income. Avoid borders!", {}, {}, nil, IncomeMods[ID]));
		end
	end
end

