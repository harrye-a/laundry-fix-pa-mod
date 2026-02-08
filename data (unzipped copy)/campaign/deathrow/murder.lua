
function CutsceneMurder()

	Game.SetMap( "deathrow-beforemurder" )	

	DeathRow_PreMurder()
	DeathRow_HouseMurder()
	DeathRow_PostMurder()
    
	Game.FadeToBlack    ( 3, true )	
    Game.GameOver       ()
	   
end


function DeathRow_SetupMurder()

	Objective.Delete 	        ( "DeathRow_TransferInmate" )
	
	DeathRow_PreMurder()
	DeathRow_HouseMurder()
	DeathRow_PostMurder()
	
	Game.Pause( 5 )
    Game.StopSkipping()
	DeathRow_AddElectricity()
	
end


-------------------------------------------------------------------------------
-- DeathRow_SetupMurder
-- The Chief tells you not to shed a tear for Edward
-------------------------------------------------------------------------------

function DeathRow_PreMurder()
	
    Game.UnlockCollectable  ( "DeathRowMurder" )
    
	Game.AdviserIncoming		( "Chief" )

	Game.SaveMap				( "deathrow-beforemurder" )

	Game.CamTrack				( "Edward", 0.01 )	
	Game.SendEntityToPos		( "Edward", 60, 63, 0, 1, 0.3 )
	Game.SendEntityToPos		( "Priest", 61, 64, -1, 0, 0.1 )
	Game.SendEntityToPos		( "Guard1", 59, 63, 1, 0, 0.3 )
	Game.SendEntityToPos		( "Guard2", 61, 63, -1, 0, 0.3 )
	
	Game.Pause 					( 4.5 )
	Game.Polaroid				( "Transfer", "campaign/deathrow/transfer.png", 64, 64, 4, 4 )
	Game.CamZoom				( 0.5, 20, false )	
	Game.Pause 					( 4 )
	
	Game.SendEntityToPos		( "Priest", 60, 64, 0, -1, 0.1 )
	Game.AdviserSay				( "Chief", "adviser_deathrow_setupmurder1" )
	Game.Sound					( "__DeathRowMurder", "Tension1" )		
	Game.AdviserSay				( "Chief", "adviser_deathrow_setupmurder2" )
	Game.AdviserSay				( "Chief", "adviser_deathrow_setupmurder3" )
	
    -- This cutscene is skippable
    Game.BeginSkippable()
    
	Game.SaveMap				( "deathrow-return" )
	
end


-------------------------------------------------------------------------------
-- DeathRow_HouseMurder
-- Edward walks in on his wife + her lover, and does them both
-------------------------------------------------------------------------------
		
function DeathRow_HouseMurder()

	local polaroidX = 14
	local polaroidY = 20
	local polaroidSize = 7
	local polaroidLarge = 80

    Game.SetMap				( "house" )
	Game.FadeToBlack		( 0, false )	
	Game.Show				( "Flashback" )
	Game.Sound				( "__DeathRowMurder", "HouseAmbience" )	
	Game.SpawnDecal			( 19.5, 19.1, 1.4, 0, 7, 4, 4, true )
	
	--Game.CamMove			( 17, 36, 35, 47, 0, false )
	Game.CamTrack			( "Edward", 0.005 )
	Game.FadeUp 			( 1, false )
	Game.CamZoom			( 2.0, 5, true )
	Game.SendEntityToPos	( "Edward", 23, 22, -1, 0, 0.33 )
	Game.Sound				( "__DeathRowMurder", "EdwardWalksIn" )
	
	Game.CamMove			( 17, 14, 35, 28, 15, false )

	Game.Pause				( 7 )
	Game.Pause				( 4 )
	Game.Sound				( "__DeathRowMurder", "Lovers" )
	Game.Pause				( 6 );
	
	Game.Sound				( "__DeathRowMurder", "Tension2" )
	Game.Sound				( "__DeathRowMurder", "DrawGun" )
	Game.GiveEquipment		( "Edward", "Gun" )
	Game.Polaroid			( "Adultery", "campaign/deathrow/adultery.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.CamMove 			( 6, 14, 28, 27, 2, true )
	Game.Pause				( 3 )
	
	Game.StopSound			( "__DeathRowMurder", "Lovers" )
	Game.Sound				( "__DeathRowMurder", "EnterBedroom" )
	Game.Polaroid			( "Shock", "campaign/deathrow/shock.png", polaroidX, polaroidY, polaroidLarge, polaroidSize )
	Game.SendEntityToPos	( "Edward", 22, 21, -1, 0, 1.3 )
	Game.SendEntityToPos	( "Lover", 20, 18, 1, 0, 1.3 )
	Game.SendEntityToPos	( "Wife", 19, 19, 1, 0, 1.3 )
	Game.Pause				( 4 )
	
	Game.StopSound			( "__DeathRowMurder", "HouseAmbience" )
	Game.Sound				( "__DeathRowMurder", "Tension3" )
	Game.AdviserSay			( "EdwardShooter", "adviser_deathrow_murder1" )	
	Game.AdviserSay			( "EdwardsWife",   "adviser_deathrow_murder2" )
	Game.CamZoom			( 0.9, 10, false )
	Game.AdviserSay			( "EdwardShooter", "adviser_deathrow_murder25" )	
	Game.AdviserSay			( "EdwardsWife",   "adviser_deathrow_murder3" )
	
	Game.Sound				( "__DeathRowMurder", "ShowGun" )
	Game.Polaroid			( "Gun", "campaign/deathrow/guncloseup.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.CamMove			( 9, 15, 25, 25, 2, true )
	Game.Pause 				( 1 )
	
	Game.Polaroid			( "Shock", "campaign/deathrow/shock.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.Pause				( 1 )

	Game.StopSound			( "__DeathRowMurder", "Tension1" )	
	Game.StopSound			( "__DeathRowMurder", "Tension2" )	
	Game.StopSound			( "__DeathRowMurder", "Tension3" )	
	Game.StopSound			( "__DeathRowMurder", "ShowGun" )	
	
	Game.Sound				( "__DeathRowMurder", "Gunshot1" )	
	Game.FadeToColour		( 1,1,1,1, 0.0, true )
	Game.FadeToColour		( 1,1,1,0, 0.05, false )
	Game.Polaroid			( "Murder", "campaign/deathrow/murder.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.Damage				( "Lover", 100, "Edward" )
	Game.Pause				( 3 )

	Game.Sound				( "__DeathRowMurder", "Gunshot2" )	
	Game.StopSound			( "__DeathRowMurder", "Gunshot1" )	
	Game.FadeToColour		( 1,1,1,1, 0.0, true )
	Game.FadeToColour		( 1,1,1,0, 0.05, false )	
	Game.Polaroid			( "DoubleMurder", "campaign/deathrow/doublemurder.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.Damage				( "Wife", 100, "Edward" )
	Game.Pause 				( 7 )
	
	Game.Sound				( "__DeathRowMurder", "Aftermath" )	
	Game.Sound				( "__DeathRowMurder", "HouseAmbience" )
	Game.SendEntityToPos	( "Edward", 21, 19, -1, 0, 0.2 )	
	Game.Pause 				( 4 )
	Game.Sound				( "__DeathRowMurder", "DropGun" )
	Game.DropEquipment		( "Edward" )
	Game.Polaroid			( "Aftermath", "campaign/deathrow/aftermath.png", polaroidX, polaroidY, polaroidSize, polaroidSize )
	Game.Pause 				( 2 )
	Game.CamMove            ( 0, 9, 53, 42, 40, false )
	Game.Pause 				( 8 )
	Game.SendEntityToPos	( "Edward", 25, 45, 0, 0, 0.8 )
	Game.Sound				( "__DeathRowMurder", "EdwardRunsOut" )
	Game.Pause				( 7 )
	
	Game.FadeToBlack		( 2, true )
		
	Game.StopSound			( "__DeathRowMurder", "HouseAmbience" )
	--Game.Polaroid			( "CrimeScene", "campaign/deathrow/crimescene.png", polaroidX, polaroidY, polaroidLarge, polaroidSize )
	
end


-------------------------------------------------------------------------------
-- DeathRow_PostMurder
-- We return to the jail.  Edward is escorted to his new jail cell
-- The Priest and the Chief debate the use of execution in this case
-------------------------------------------------------------------------------

function DeathRow_PostMurder()
	
	Game.SetMap					( "deathrow-return" )	
    
    -- We can skip up to this point
    Game.EndSkippable()
    
	Game.Hide					( "Flashback" )
	Game.CamTrack				( "Edward", 0.005 )	
	Game.SetFlag				( "Edward", "Shackled", true )
	Game.FadeUp					( 1, false )
	Game.CamZoom				( 1.3, 3, true )
		
	Game.SendEntityToPos		( "Guard1", 57, 64, 1, 0, 0.1 )
	Game.SendEntityToPos		( "Edward", 58, 64, -1, 0, 0.1 )
	Game.SendEntityToPos		( "Priest", 59, 64, -1, 0, 0.1 )
	Game.SendEntityToPos		( "Guard2", 60, 64, -1, 0, 0.1 )		

	--Game.Polaroid				( "CrimeScene", "campaign/deathrow/crimescene.png", 64, 64, 50, 5 )
	Game.CamTrack				( "Edward", 0.01 )	
	Game.StopSound				( "__DeathRowMurder", "Aftermath" )	
	Game.AdviserSay				( "Chief",   "adviser_deathrow_postmurder2" )

	Game.CamTrack				( "Edward", 0.015 )	
	Game.SendEntityToPos		( "Edward", 13, 44, 1, 0, 0.13 )
	Game.SendEntityToPos		( "Priest", 14, 44, -1, 0, 0.15 )
	Game.SendEntityToPos		( "Guard1", 17, 43, 1, 0, 0.15 )
	Game.SendEntityToPos		( "Guard2", 17, 46, 1, 0, 0.15 )		
	
	Game.AdviserSay				( "Priest", "adviser_deathrow_postmurder3" )
	Game.AdviserSay				( "Chief", "adviser_deathrow_postmurder4" )
	Game.AdviserSay				( "Chief", "adviser_deathrow_postmurder5" )
	Game.AdviserSay				( "Priest", "adviser_deathrow_postmurder6" )
	Game.AdviserSay				( "Priest", "adviser_deathrow_postmurder7" )
	Game.AdviserSay				( "Chief", "adviser_deathrow_postmurder8" )
	
end

