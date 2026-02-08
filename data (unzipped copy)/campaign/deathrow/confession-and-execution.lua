
function CutsceneConfession()

    DeathRow_ChurchConfession()
    
    Game.BeginSkippable     ()
    Game.SetMap             ( "deathrow-beforeexecution" )
    Game.Hide               ( "Flashback" )
    
    DeathRow_Execution      ()
    Game.EndSkippable       ()
    
    Game.GameOver()
    
end


function DeathRow_SetupConfessionAndExecution()

    Game.SaveMap            ( "deathrow-beforeexecution" )

    DeathRow_ChurchConfession()

    Game.StopSkipping       ()
    Game.SetMap             ( "deathrow-beforeexecution" )
    Game.Hide               ( "Flashback" )

    DeathRow_Execution()
    
end



-------------------------------------------------------------------------------
-- DeathRow_ChurchConfession
-- Edward walks into a church and sees the priest
-- They talk for a while.  The priest convinces Edward to give himself up
-------------------------------------------------------------------------------


function DeathRow_ChurchConfession()

    Game.UnlockCollectable("DeathRowConfession")

	Game.FadeToBlack		( 0, false )
	Game.SetMap				( "church" )
	Game.Show				( "Flashback" )
	
	--Game.HideArea			( "Hide", 38, 25, 23, 53 )		
	--Game.HideArea			( "Hide", 32, 24, 19, 8 )		
	--Game.HideArea			( "Hide", 38, 16, 33, 2 )
	--Game.HideArea			( "Hide", 39, 45, 42, 59 )
	--Game.HideArea			( "Hide", 38, 25, 23, 53 )		
		
	Game.CamMove			( 42, 10, 51, 17, 0, true )
	Game.FadeUp				( 1, false )
	Game.Polaroid			( "Priest", "campaign/deathrow/priest.png", 51, 15, 6, 6 )
	Game.Sound				( "__DeathRowConfession", "ChurchAmbience" )	
	Game.Sound				( "__DeathRowConfession", "Start" )	
	Game.CamZoom			( 1.5, 10, true )

	Game.SendEntityToPos	( "Edward", 46, 43, 0, -1, 0.5 )
	Game.Polaroid			( "ChurchEntrance", "campaign/deathrow/churchentrance.png", 51, 43, 6, 6 );
	Game.CamMoveAndZoom		( 37, 36, 55, 48, 2.0, 5, true )
	
	Game.Pause				(4)
	Game.SendEntityToPos	( "Edward", 46, 15, 0, -1, 0.4 )
	Game.CamMove			( 36, 9, 55, 22, 18, true )
	
	Game.SendEntityToPos	( "Priest", 46, 14, 0, 1, 1.0)
	Game.CamMove			( 40, 11, 55, 19, 30, false )
	
	Game.Sound				( "__DeathRowConfession", "CanIHelpYou" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church1" )	
	Game.AdviserSay			( "EdwardSinner", "adviser_deathrow_church15" )
	
	Game.Polaroid			( "forgiveness", "campaign/deathrow/forgiveness.png", 51, 15, 6, 6 );
	Game.Pause				( 3 )
	
	Game.Sound				( "__DeathRowConfession", "AreYouLooking" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church2" )
	
	Game.Sound				( "__DeathRowConfession", "IDontKnow" )	
	Game.AdviserSay			( "EdwardSinner", "adviser_deathrow_church3" )
	
	Game.Sound				( "__DeathRowConfession", "YouHaveTo" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church4" )
	
	Game.Sound				( "__DeathRowConfession", "YouWillNever" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church5" )
	
	Game.Sound				( "__DeathRowConfession", "IWantToGoBack" )	
	Game.AdviserSay			( "EdwardSinner", "adviser_deathrow_church6" )
	
	Game.Sound				( "__DeathRowConfession", "GodWillForgive" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church7" )
	
	Game.Sound				( "__DeathRowConfession", "ButYouMust" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_church8" )
	
	Game.FadeToBlack		( 1, true )
	
	Game.StopSound			( "__DeathRowConfession", "CanIHelpYou" )
	Game.StopSound			( "__DeathRowConfession", "ChurchAmbience" )
    
end



-------------------------------------------------------------------------------
-- DeathRow_Execution
-- We return to Edward in his cell, with the priest
-- He is led into the execution room and the sentence is passed
-------------------------------------------------------------------------------

function DeathRow_Execution()

	Game.CamMove			( 6, 40, 18, 48, 0, true )
	Game.CamZoom			( 1.2, 20, false )
    Game.Sound				( "__DeathRowConfession", "FadeToPrison" )	
	Game.Sound				( "__DeathRowMurder", "Tension1" )
	Game.FadeUp				( 1, true )
	Game.Polaroid			( "Time", "campaign/deathrow/time.png", 10, 44, 4, 4 )
	Game.Pause 				( 3 )
	
	--Game.Sound				( "__DeathRowConfession", "AreYouLooking" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_setupexecution1" )

	--Game.Sound				( "__DeathRowConfession", "GodWillForgive" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_setupexecution2" )

	--Game.Sound				( "__DeathRowConfession", "ButYouMust" )	
	Game.AdviserSay			( "Priest", "adviser_deathrow_setupexecution3" )
	
	-- Guards come into cell, surround edward
	
	Game.SendEntityToPos	( "Priest", 13, 45, 1, 0, 0.2 )
	Game.SendEntityToPos	( "Edward", 14, 44, 1, 0, 0.2 )
	Game.Pause				( 2 )
	Game.SendEntityToPos	( "Guard2", 14, 45, 0, -1, 0.4 )
	Game.SendEntityToPos	( "Guard1", 15, 44, -1, 0, 0.4 )

	Game.CamMove			( 7, 40, 23, 50, 10, true )
	Game.SetFlag			( "Edward", "Shackled", true )

	-- Everyone steps into execution room
	
	Game.SendEntityToPos	( "Guard1", 20, 40, 0, -1, 0.2 )
	Game.SendEntityToPos	( "Edward", 19, 40, 0, -1, 0.2 )
	Game.SendEntityToPos	( "Guard2", 20, 41, 0, -1, 0.2 )
	Game.SendEntityToPos	( "Priest", 19, 41, 0, -1, 0.2 )

	Game.CamMove			( 9, 40, 26, 50, 10, true )

	Game.Polaroid			( "Chair", "campaign/deathrow/chair.png", 14, 37, 5, 5 )
	Game.Sound				( "__DeathRowMurder", "Tension2" )
	Game.Pause				( 3 )
	Game.CamMove			( 9, 34, 26, 44, 2, true )
	Game.Pause				( 6 )
	
	-- Everyone takes their place
	
	Game.SendEntityToPos	( "Guard1", 19, 38, -1, 0, 0.2 )
	Game.SendEntityToPos	( "Edward", 17.4, 37.15, 0, 0.1, 0.1 )
	Game.SendEntityToPos	( "Guard2", 16, 38, 1, 0, 0.2 )
	Game.SendEntityToPos	( "Priest", 15, 40, 1, -1, 0.2 )
	
	Game.Pause 				( 15 )	
	Game.SendEntityToPos	( "Guard1", 22, 35, -1, 1, 0.2 )
	Game.SendEntityToPos	( "Guard2", 16, 40, 1, -1, 0.2 )
	
	Game.Pause				( 10 )
	Game.CamZoom			( 0.8, 30, false )
	Game.Pause				( 2 )
	Game.Polaroid			( "Executor", "campaign/deathrow/executor.png", 23, 39, 4, 4 )
	Game.Sound				( "__DeathRowMurder", "ShowGun" )
	Game.Pause				( 3 )
	Game.Polaroid			( "regret", "campaign/deathrow/regret.png", 14, 37, 5, 5 )
	Game.Pause				( 5 )
	
	Game.AdviserSay			( "Chief", "adviser_deathrow_setupexecution4" )
	Game.AdviserSay			( "Chief", "adviser_deathrow_setupexecution5" )
	Game.AdviserSay			( "Chief", "adviser_deathrow_setupexecution6" )
	Game.Sound				( "__DeathRowMurder", "Tension3" )
	
	Game.Pause				( 3 )
	Game.AdviserSay			( "EdwardInmate", "adviser_deathrow_setupexecution7" )
	Game.AdviserSay			( "EdwardInmate", "adviser_deathrow_setupexecution8" )
	
	Game.Pause				( 5 )
	
    Game.Polaroid			( "Executor", "campaign/deathrow/end.png", 23, 39, 4, 4 )
	Game.Sound				( "__DeathRowConfession", "EdwardsDeath" )
	Game.FadeToColour		(1,1,1,1, 0.3, true)
	Game.CamMove            ( 0, 0, 110, 80, 1.0, false )
	
	Game.StopSound			( "__DeathRowMurder", "Tension1" )	
	Game.StopSound			( "__DeathRowMurder", "Tension2" )	
	Game.StopSound			( "__DeathRowMurder", "Tension3" )	
	Game.StopSound			( "__DeathRowMurder", "ShowGun" )	
	
	Game.Sound				( "__DeathRowConfession", "CanIHelpYou" )	
	Game.Pause				( 8 )
	
	Game.Sound				( "__DeathRowConfession", "GodWillForgive" )
	Game.FadeToColour		(0,0,0,1, 10, true )
		
	Game.Sound				( "__DeathRowConfession", "ButYouMust" )
		
	Game.Pause 				( 10 )
	Game.StopSound			( "__DeathRowConfession", "CanIHelpYou" )	
    Game.Damage				( "Edward", 100, "Edward" )
    Game.Pause              (4)

end

