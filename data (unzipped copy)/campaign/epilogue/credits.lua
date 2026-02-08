function CutsceneEpilogueCredits()

	Game.StopSkipping()
	
    Game.SetMap		 ( "credits" )
    Game.Hide       ( "WorldSounds" )
    Game.Sound     ( "__FoodFamily", "Start" )

	Game.Hide 				( "GameUI" )
	Game.Show 				( "Interface" )
	Game.FadeUp				(1, true)
    Game.ShowCredits()
	Game.Show 				( "GameUI" )
	Game.Hide 				( "Interface" )
    Game.GameOver()
end
