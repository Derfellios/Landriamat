function Client_GameRefresh(game)
	if game.Us ~= nil and (not Mod.PlayerGameData.InitialPopupDisplayed and not (game.Game.TurnNumber > 1 or (game.Game.TurnNumber == 1 and not game.Settings.AutomaticTerritoryDistribution))) then
		UI.Alert("This game includes the Landria Maker mod. Landria rules apply! So don't have too many borders!")
		local payload = {};
		payload.Message = "InitialPopupDisplayed";
		game.SendGameCustomMessage("Please wait... ", payload, function(reply)end);
	end
end
