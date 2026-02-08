
function CutsceneEpilogueOutro()

	Epilogue_Parole()
	EpilogueHome()
    Game.Pause(4)
    CutsceneEpilogueCredits()

	Game.GameOver()
	
end 


-- Epilogue Parole
-- Start with Hurst on the phone to the news anchor.
-- Morgan is paroled and released.

function Epilogue_Parole()
    
	Game.UnlockCollectable("EpilogueOutro")
    Game.UnlockCollectable("EpilogueCredits")

    Game.FadeToBlack(1,true)
    Game.SetMap("parole")
    Game.Hide ( "WorldSounds" )
	
	-- Everyone get in position.
	-- Hurst on the phone to the news station.
	-- Morgan trying to phone home.
		
	Game.Spawn          	( "Actor", "Hurst", 0, 0 )
    Game.SetSprite      	( "Hurst", "hurst" )
	Game.SendEntityToObject	( "Hurst", "Hurst1", 0, 1, -1 )	
	
    Game.SetSprite			( "Morgan", "Morgan" )
    Game.SendEntityToObject ( "Morgan", "MorganParoleStart", 0, 1, -1 )

    Game.SetSprite          ( "Keane", "Keane" )
    Game.SendEntityToObject ( "Keane", "KeaneParoleStart", 1, 0, -1 )
    
	--Game.CamMoveToObject	("ParoleStart", 0, 1.0, true )

	-- Morgan failing to get through
	-- Keane trying to help 

    Game.Sound              ( "__EpilogueOutro", "Sounds1" )

    Game.CamMoveToObject	( "ParoleMorgan", 0, 0.85, true )
    Game.Pause				(3)
    Game.Sound              ( "__EpilogueOutro", "Music1" )
    Game.Pause              (2)
    Game.CamMoveToObject	( "ParoleMorgan", 15, 1.0, false )
    Game.FadeUp				(3, true)
    Game.Sound              ( "__EpilogueOutro", "Sounds2" )
    Game.Pause 				(1)

	--Game.CamMoveToObject	( "ParoleMorgan", 3, 1.0, true )
	Game.PolaroidAtMarker 	( "MorganPhonePolaroid", "campaign/epilogue/ill_chap5_morganphone.png", 1 )	
	Game.Pause 				(5)
	Game.AdviserSay 		( "Keane", "epilogue_parole1" )
	Game.AdviserSay 		( "MorganHappy", "epilogue_parole2" )
	--Game.PolaroidAtMarker 	( "MorganPhonePolaroid", "campaign/epilogue/ill_chap5_morganphone2.png", 1 )	
	Game.AdviserSay 		( "Keane", "epilogue_parole3" )

    Game.StopSound          ( "__EpilogueOutro", "Sounds2" )
    Game.Sound              ( "__EpilogueOutro", "Sounds3" )
    Game.HidePolaroid       ( "MorganPhonePolaroid" )

    Game.SendEntityToObject ( "Morgan", "MorganParoleDoor", 0, 1, 0.3 )
    Game.SendEntityToObject ( "Keane", "KeaneParoleDoor", 1, 1, 0.3 )
	Game.CamMoveToObject 	( "ParoleEntranceCam", 3, 1.0, true )


	-- Hurst says some words to Morgan
	
	Game.SendEntityToObject	( "Hurst", "Hurst1", 0, -1, -1 )	
    Game.Sound              ( "__EpilogueOutro", "Music2" )
	Game.AdviserSay 		( "Hurst", "epilogue_parole4" )
    Game.AdviserSay 		( "Hurst", "epilogue_parole5" )
	Game.AdviserSay 		( "Hurst", "epilogue_parole6" )
	Game.SendEntityToObject	( "Hurst", "Hurst1", 0, 1, -1 )	
		
	-- Morgan goes into the parole room
	
    Game.SendEntityToObject ( "Morgan", "MorganParole1", 0, -1, 0.4 )
	Game.SendEntityToObject ( "Keane", "KeaneParoleDoor", 0, 1, 0.0 )
	
    Game.CamMoveToObject		( "ParoleCam1", 5.0, 1.0, true )
    Game.Pause(2)    
    Game.PolaroidAtMarker       ( "ParolePolaroid1", "campaign/epilogue/ill_chap5_morganparole.png", 1 )
    Game.Pause(3)
	
	-- News broadcast bit
	
    Game.Sound              ( "__EpilogueOutro", "Music3" )
	Game.PolaroidAtMarker   ( "NewsBackdrop", "campaign/epilogue/breaking-news.png", 1 )
	Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/riot/ill_chap4_8.png", 1 ) 
    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/epilogue/ill_chap3_jail5.png", 0 ) 		
	--Game.FadeUp(1,false)
    Game.AdviserSay			( "NewsReader", "epilogue_outro_1" )
	
	Game.CamMoveToObject    ( "NewsCamera", 0, 1.0, true )	
    Game.AdviserSay			( "NewsReader", "epilogue_outro_2" )
    Game.AdviserSay			( "NewsReader", "epilogue_outro_2b" )	
	
	Game.CamMoveToObject( "ParoleHurstCam", 0, 0.9, true )	
	Game.HidePolaroid   ( "ParolePolaroid1" )
	Game.CamZoom		( 0.9, 15, false )
	
    Game.Sound     ( "__EpilogueOutro", "Music4" )
    Game.AdviserSay( "Hurst", "epilogue_outro_4" )
    Game.AdviserSay( "Hurst", "epilogue_outro_4b" )
	Game.Pause(1)
    Game.AdviserSay( "Mayor", "epilogue_outro_5" )
    Game.AdviserSay( "Hurst", "epilogue_outro_6" )
	     
    Game.Pause(1)

	-- Morgan comes out
    -- Heller disagrees

    Game.SendEntityToObject ( "Morgan", "MorganParoleDoor", 0, 1, 0.3 )
	Game.Pause(4)
	Game.CamZoom 			( 0.9, 10, false )
    Game.SendEntityToObject	( "Hurst", "Hurst1", 0, -1, -1 )
    --Game.SendEntityToObject ( "Keane", "KeaneParoleDoor", 1, 1, -1 )
	Game.Pause(2)

    Game.Sound              ( "__EpilogueOutro", "Music5" )
    Game.AdviserSay 		( "Keane", "epilogue_parole11" )
    Game.Sound              ( "__EpilogueOutro", "Music6" )
    Game.PolaroidAtMarker   ( "ParolePolaroid2", "campaign/epilogue/ill_chap5_morgansurprise.png", 1 )
	Game.Pause(3)
    Game.Pause(2)
 	
	Game.StopSkipping()
    Game.FadeToBlack(2, true)
    	
end 




-- Epilogue Home
-- A prison bus drives through a small town, with lots of civilians visible
-- Morgan gets out, goes to his house, meets his family

function EpilogueHome()

    Game.SetMap("outro")
    Game.FadeToBlack(0,true)
	Game.Hide( "WorldSounds" )
	Game.Sound( "__EpilogueOutro", "Sounds4" )

    MoveCivs(1,12)
    MoveCivs(17,20)

	Game.SendEntityToObject( "PrisonerBus", "BusPos1", 0, 1, -1 )
    Game.SendEntityToObject( "PrisonerBus", "BusPos2", 0, 1, 0.8 )
	
	Game.CamMoveToObject("Cam1", 0, 0.7, true )
	Game.CamMoveAndZoom( 72, 110, 106, 131, 2.3, 20, false )	
      
    MoveChildren()
    
	Game.Pause(2)
    Game.FadeUp(3, false)	
    MoveCivs(13,13)
    Game.Pause(5)
    
    MoveCivs(14,16)
    
    Game.Pause(10)
    
    MoveChildren()
    
    Game.Pause(4)
    
    MoveChildren()

    Game.Sound              ( "__EpilogueOutro", "Sounds5" )
    Game.Pause(1)

	-- Morgan gets out the bus
	
	--Game.SendEntityToObject	( "PrisonerBus", "BusPos2", 0, 1, -1 )

    Game.Sound              ( "__EpilogueOutro", "Music7" )
	Game.AdviserSay			( "Hurst", "epilogue_outro_7" )
	Game.SetSprite			( "Morgan", "MorganCivilian" )
    Game.SendEntityToObject	( "Morgan", "MorganPos2", 1, 0, -1 )
    
    MoveChildren()
   
    Game.Pause(3)
    
    MoveChildren()
    
	Game.SendEntityToObject 	( "PrisonerBus", "BusPos3", 0, 1, 0.5 )
	Game.CamZoom 				( 0.8, 10, false )	
    Game.AdviserSay			( "Hurst", "epilogue_outro_7b" )
    
    MoveChildren()
	        
	-- Starts walking 

    Game.StopSound  ( "__EpilogueOutro", "Sounds4" )
    Game.Sound      ( "__EpilogueOutro", "Sounds6" )
    Game.Sound      ( "__EpilogueOutro", "Music8" )

    Game.SendEntityToObject		( "Morgan", "MorganPos3", 0, -1, 0.55 )
    Game.CamMoveToObject		( "Cam3", 15.0, 1.2, false )	
	Game.Pause(12)

	-- Morgan approaches the door
	
    Game.AdviserSay				( "Mayor", "epilogue_outro_8" )
    Game.AdviserSay				( "Mayor", "epilogue_outro_8b" )
    Game.SendEntityToObject		( "Morgan", "MorganPos4", 0, -1, 0.1 )
	Game.CamMoveToObject 		( "Cam3b", 9, 1.1, false )
	Game.Pause 					(2)
    Game.AdviserSay				( "Mayor", "epilogue_outro_8c" )
	
	-- Rings the doorbell
	-- Kerry answers
	 	
    Game.Sound                  ( "__EpilogueOutro", "Sounds7" )
    Game.PolaroidAtMarker       ( "PolaroidDoor", "campaign/epilogue/ill_chap5_morganbuzzer.png", 1 )
	Game.Pause(2.0)
	Game.HidePolaroid 			( "PolaroidDoor" )
	Game.Pause(3)
    Game.SetSprite 				( "Kerry", "KerryAlone" )
    Game.SendEntityToObject     ( "Kerry", "KerryPos1", 0, 1, 0.3)
    	
    Game.Pause(7)
	Game.SetFlag 			    ( "FrontDoor", "LockedOpen", true )    
    Game.Sound                  ( "__EpilogueOutro", "Sounds8" )
    Game.PolaroidAtMarker       ( "PolaroidDoor", "campaign/epilogue/ill_chap5_Kerryatdoor.png", 1 )
	Game.Pause 					(4)

    Game.StopSound              ( "__EpilogueOutro", "Sounds6" )
    Game.SendEntityToObject 	( "Morgan", "MorganPos5", 0, -1, 0.1 )
	Game.CamMoveToObject		( "Cam4", 6.0, 0.9, false )
	Game.Pause(7)	
	
	-- Morgan and Kerry hug. Close up.
	
	Game.HidePolaroid			( "PolaroidDoor" )
	Game.PolaroidAtMarker       ( "PolaroidHug", "campaign/epilogue/ill_chap5_MorganKerryhugging.png", 1 )   	
	Game.CamZoom 				( 0.9, 10, false )
	Game.Pause(4)
    Game.AdviserSay             ( "Hurst", "epilogue_outro_9" );	
		
	-- Daughter approaches

    Game.SendEntityToObject     ( "Daughter", "DaughterPos", 0, 1, 0.3)
	Game.Pause(6)
	Game.SendEntityToObject     ( "Kerry", "KerryPos1", 0, -1, -1)
	Game.PolaroidAtMarker       ( "PolaroidHug", "campaign/epilogue/ill_chap5_toddler.png", 1 )   	
	Game.Pause 					(4)
	Game.AdviserSay 			( "Mayor", "epilogue_outro_11" )		
	Game.Pause(3)
	Game.AdviserSay 			( "Mayor", "epilogue_outro_12" )
	
	-- Daughter runs to hug 
	
	Game.SendEntityToObject     ( "Daughter", "DaughterPos2", 0, 1, 1)
	Game.Pause(0.8)		
	Game.SendEntityToObject     ( "Kerry", "KerryPos1", 0, 1, -1)
    Game.PolaroidAtMarker       ( "PolaroidHug", "campaign/epilogue/ill_chap5_familyhugging.png", 1 )    
    Game.CamZoom 				( 0.9, 10, false )

	Game.Pause(8)
    Game.StopSound          ( "__EpilogueOutro", "Music8" )
    Game.Sound              ( "__EpilogueOutro", "Music9" )

    Game.FadeToBlack( 3.0, true )
	Game.CamZoom	(5,3,false)				-- zoom out to avoid buzzing/fly sounds
	Game.Pause  (3)

end

function MoveChildren()

    for i = 1, 9 do
		visitorName = "Kid" .. i
		markerName = "Kid" .. math.random(9) .. "Pos"
	
		Game.SendEntityToObject 	( visitorName, markerName, -1, 0, 0.9 )
	end 

end

function MoveCivs( first, last )

    for i = first, last do
		visitorName = "Civ" .. i
		markerName = "Civ" .. i .. "Pos"
	
		Game.SendEntityToObject 	( visitorName, markerName, -1, 0, 0.4 )
	end 
    
end
