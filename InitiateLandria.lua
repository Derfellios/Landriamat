function InitiateLandria(game, standing)

	local AllowZero = Mod.Settings.AllowZero
	local AllowNegative = Mod.Settings.AllowNegative
	local CountNested = Mod.Settings.CountNested
	local BonusesToUse = {}
	
	for ID, bonus in pairs(game.Map.Bonuses) do
		if (AllowZero or bonus.Amount ~= 0) and (AllowNegative or bonus.Amount >= 0) then
			BonusesToUse[#BonusesToUse + 1] = ID
		end 
	end
	-- Check whether there are not too many bonuses to check
	local TooManyBonuses = #BonusesToUse > 100 or #game.Map.Territories > 500
	local Borders = {}
	
	if not TooManyBonuses then
		for Terr1ID, Terr1 in pairs(game.Map.Territories) do
			for Terr2ID, _ in pairs(Terr1.ConnectedTo) do
				for _, Bonus1 in pairs(game.Map.Territories[Terr1ID].PartOfBonuses) do
					for _, Bonus2 in pairs(game.Map.Territories[Terr2ID].PartOfBonuses) do
						if Bonus1 < Bonus2 and (CountNested or not (IsInList(Terr1.PartOfBonuses, Bonus2) or IsInList(game.Map.Territories[Terr2ID].PartOfBonuses, Bonus1))) then
							if Borders[Bonus1] == nil then
								Borders[Bonus1] = {}
							end
							if Borders[Bonus1][Bonus2] == nil then
								Borders[Bonus1][Bonus2] = {{Terr1ID, Terr2ID}}
							else
								Borders[Bonus1][Bonus2][#Borders[Bonus1][Bonus2]+1] = {Terr1ID, Terr2ID}
							end
						end
					end
				end
			end
		end
	end
	
	local PublicGameData = Mod.PublicGameData;
	PublicGameData.Borders = Borders
	PublicGameData.BonusesToUse = BonusesToUse
	PublicGameData.TooManyBonuses = TooManyBonuses

	Mod.PublicGameData = PublicGameData
end

function IsInList(List, Item)
    for _,item in pairs(List) do
         if item == Item then
              return true
         end
    end
    return false
end