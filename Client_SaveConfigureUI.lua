function Client_SaveConfigureUI(alert)
	Mod.Settings.AllowZero = AllowZeroBox.GetIsChecked()
	Mod.Settings.AllowNegative = AllowNegativeBox.GetIsChecked()
	Mod.Settings.CountNested = CountNestedBox.GetIsChecked()
end