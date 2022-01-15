function Client_PresentConfigureUI(rootParent)
    if Mod.Settings.AllowZero == nil then initial0 = false; else initial0 = Mod.Settings.AllowZero end
	if Mod.Settings.AllowNegative == nil then initial1 = false; else initial1 = Mod.Settings.AllowNegative end
	if Mod.Settings.CountNested == nil then initial2 = false; else initial1 = Mod.Settings.CountNested end
    local vert = UI.CreateVerticalLayoutGroup(rootParent);
    local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(vert).SetText('On which bonuses should the Landria rules apply?');
	local horz0 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz0).SetText('Bonuses worth 0 armies?');
    AllowZeroBox = UI.CreateCheckBox(horz0)
		.SetIsChecked(Mod.Settings.AllowZero)
	local horz1 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz1).SetText('Negative bonuses?');
    AllowNegativeBox = UI.CreateCheckBox(horz1)
		.SetIsChecked(Mod.Settings.AllowNegative)
	local horz2 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz2).SetText('Nested bonuses?');
	CountNestedBox = UI.CreateCheckBox(horz2)
		.SetIsChecked(Mod.Settings.CountNested)
end