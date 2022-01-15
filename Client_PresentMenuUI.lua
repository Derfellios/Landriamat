function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)	
    if game.Us ~= nil then
	
		local AllowZero = false;
		local AllowNegative = false;
		local CountNested = false;
		
		if Mod.Settings.AllowZero ~= nil then
			AllowZero = Mod.Settings.AllowZero;
		end
		if Mod.Settings.AllowNegative ~= nil then
			AllowNegative = Mod.Settings.AllowNegative;
		end
		if Mod.Settings.CountNested ~= nil then
			CountNested = Mod.Settings.CountNested;
		end
		
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		
		if AllowZero then
			message0 = "Bonuses worth zero count for the Landria rules"
		else
			message0 = "Bonuses worth zero do not count for the Landria rules"
		end
		
		if AllowNegative then
			message1 = "Bonuses worth negative income count for the Landria rules"
		else
			message1 = "Bonuses worth negative income do not count for the Landria rules"
		end
		
		if CountNested then
			message2 = "A border between neigbouring territories T1 and T2 and bonuses B1 and B2 counts if territory T1 is in bonus B1 and territory T2 is in bonus B2. Multiple borders between two terriories can exist"
		else
			message2 = "A border between neigbouring territories T1 and T2 and bonuses B1 and B2 only count if territory T1 is in bonus B1 and territory T2 is in bonus B2, territory T2 is not in bonus B1 and territory T1 is not in bonus B2. Multiple borders between two terriories can exist"
		end
		print(message2)
		UI.CreateLabel(vert).SetText(message0);
		UI.CreateLabel(vert).SetText(message1);
		UI.CreateLabel(vert).SetText(message2);
	end
end


