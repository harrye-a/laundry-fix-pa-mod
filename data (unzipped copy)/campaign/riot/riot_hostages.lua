

function SpawnAllHostages()

	Riot_SpawnHostageActors ( "Ceo", "Hostage1", "Hostage2", 0, 1 )
	Riot_SpawnHostageActors ( "GuardHostage", "Hostage2", "Hostage3", 0, 1 )
	Riot_SpawnHostageActors ( "AnotherHostage1", "Hostage3", "Hostage4", 0, 1 )
	Riot_SpawnHostageActors ( "AnotherHostage2", "Hostage4", "Hostage5", 0, 1 )
	Riot_SpawnHostageActors ( "AnotherHostage3", "Hostage5", "Hostage6", 0, 1 )
	
	Riot_SpawnHostageActors	( "Benedict", "Benedict", "Hostage1", 0, 1 )
	Riot_SpawnHostageActors	( "BenHench1", "BenedictHenchman1", "MarkerHench1", 1, 0 )
	Riot_SpawnHostageActors	( "BenHench2", "BenedictHenchman2", "MarkerHench2", 0, 1 )
	Riot_SpawnHostageActors	( "BenHench3", "BenedictHenchman3", "MarkerHench3", -1, 0 )

	Game.GiveEquipment		( "Benedict", "Gun" )
	Game.GiveEquipment		( "BenHench1", "Shotgun" )
	Game.GiveEquipment		( "BenHench2", "Shank" )
	Game.GiveEquipment		( "BenHench3", "Club" )
	
end

function Riot_SpawnHostageActors( name, sprite, positionMarker, orX, orY )

	Game.Spawn 				( "Actor", name, 0, 0 )
	Game.SetSprite			( name, sprite )
	Game.SendEntityToObject	( name, positionMarker, orX, orY, -1 )
	
end


function Riot_RunHostagesFirstScene()

	Game.Hide ( "RiotMusic" )

	SpawnAllHostages()
	RunHostagesScene()
	
	Game.Show ( "RiotMusic" )
	
	-- The mayor asks you to capture the security room, so we can use the cctv cameras
	
	Game.AdviserIncoming( "Mayor" )
	Game.CamMoveToObject( "CamShowSecurity1", 1, 1.2, true )
	Game.AdviserSay		( "Mayor", "adviser_riot_hostageheller1" )
	
	Game.CamMoveToObject( "CamShowSecurity2", 5, 1, false )
	Game.AdviserSay		( "Mayor", "adviser_riot_hostageheller2" )
	Game.AdviserSay		( "Mayor", "adviser_riot_hostageheller3" )
	
	
	-- Objective : Capture the security room 
	-- Once that's done, we'll watch the second hostage scene (roulette)
				
	Objective.Create 			( "Riot_MaxSecCameras" )
	Objective.RequirePrisonersUnderControl	( 129, 133, 133, 141 )
	
    Trigger.Create 				( "Riot_TriggerNextCutscene" )
	Trigger.RequireObjective 	( "Riot_MaxSecCameras" )
	
end


function CutsceneRiotHostages()

    -- This is the entry point from the Campaign / cutscenes main menu

    Game.SetMap	( "riot" )
    
	SpawnAllHostages()
	
    RunHostagesScene()
    
    Game.FadeToBlack    ( 3, true )
    Game.GameOver       ()

end 

function RunHostagesScene()
	
    -- Benedict phones the player
    
    Game.UnlockCollectable("RiotHostages")

    Game.AdviserIncoming    ( "RiotBenedict" )
    Game.Sound              ( "__RiotHostages", "HostagesMusic1" )
    Game.CamMoveToObject    ( "CanteenWide", 1, 1, true )
    Game.Sound              ( "__RiotHostages", "HostagesMusic2" )
    Game.AdviserSay         ( "RiotBenedict", "adviser_riot_hostages1" )
    Game.Sound              ( "__RiotHostages", "HostagesMusic3" )
 
    -- Zoom into canteen

    Game.PolaroidAtMarker   ( "HostagePolaroid1", "campaign/riot/ill_chap4_4.png", 1 )
    Game.CamMoveToObject    ( "CanteenInside", 2, 1.0, true )

    Game.Pause              (2)

    Game.Sound              ( "__RiotHostages", "HostagesMusic4" )
	Game.AdviserSay         ( "RiotCeo", "adviser_riot_hostages1b" )
    Game.Sound              ( "__RiotHostages", "HostagesMusic5" )
    Game.AdviserSay         ( "RiotBenedict", "adviser_riot_hostages2" )
    Game.AdviserSay         ( "RiotBenedict", "adviser_riot_hostages3" )
    
    Game.AdviserSay         ( "RiotBenedict", "adviser_riot_hostages4" )
    
    Game.Sound              ( "__RiotAssault", "BreachPhoneSlam" )    
    Game.Sound              ( "__RiotHostages", "HostagesMusic6" )
    
    Game.PolaroidAtMarker   ( "HostagePolaroid1", "campaign/riot/ill_chap4_9.png", 3 )
    Game.StopSound          ( "__RiotHostages", "HostagesMusic2" );
    Game.Pause              (2)
    Game.HidePolaroid       ( "HostagePolaroid1" )

    Game.CamMoveToObject    ( "CanteenWide", 5, 1, true )

end 

