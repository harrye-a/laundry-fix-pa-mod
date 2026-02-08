
function CutsceneSuicide()

	Game.SetMap( "conviction" )    
    Game.Remove ( "morganshirt" )

	ConvictionSuicide()
	
    Game.FadeUp             (1,false)
    Game.GameOver           ()	
end 


function ConvictionSuicide()

	-- Spawn Hurst
    
    Game.UnlockCollectable("ConvictionSuicide")
		
	Game.Spawn          	( "Actor", "Hurst", 0, 0 )
    Game.SetSprite      	( "Hurst", "hurst" )
	Game.SendEntityToObject	( "Hurst", "hurst1", 0, 1, -1 )	

		
	-- We get a call from Keane - suicide
	
	Game.AdviserIncoming	( "Keane" )
	Game.AdviserSay 		( "Keane", "conviction_suicide_1" )
    Game.Sound              ( "__ConvictionSuicide", "SuicideMusic1" )
	Game.AdviserSay 		( "Keane", "conviction_suicide_2" )
	Game.AdviserSay 		( "Keane", "conviction_suicide_3" )
    Game.Sound              ( "__ConvictionSuicide", "SuicideMusic2" )
		
	-- Spawn the photo
	
	Game.Spawn 				( "Prop", "KerryPhoto", 19, 66 )
	Game.SetSprite 			( "KerryPhoto", "Photo" )
	
	
	-- Move Morgan out the way
	-- Hurst runs to Morgans cell
				
	Game.SendEntityToObject	( "Morgan", "morgan1", 1, 0, -1 )	
    Game.SetSprite      	( "Morgan", "Morgan" )
	
	Game.Hide				( "WorldSounds" )
	Game.SendEntityToObject	( "Hurst", "mccallister4", 0, 1, 1 )
	Game.CamTrack 			( "Hurst", 0.01 )
	
	Game.SetFlag 			( "morgandoor", "LockedOpen", true )
	
	Game.Pause 				(7)
	Game.CamMoveToObject	( "cammorgansuicide", 5, 1.0, false )
	Game.SendEntityToObject	( "Hurst", "mccallister4", 0, 1, -1 )				-- This is for safety, to ensure he made it here (eg if player skips previous pause he wont be in position)
	Game.SendEntityToObject	( "Hurst", "hurst4", 0, 1, 0.1 )
	Game.Pause 				(5)
	
	
	-- He looks sad
	-- Morgan approaches
	
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_endpt1.png", 1 )
	Game.CamZoom 			( 0.95, 8, false )
	Game.Pause 	(4)
	
	
	-- He sees the family picture
	
    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_kerrybabypicture.png", 1 )
	Game.SetSprite 			( "Hurst", "hursteyesshut" )
	Game.Pause (5)
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_endpt1.png", 1 )
	Game.Pause (5)
	

	-- Morgan appears in the doorway, Speaks

	Game.SendEntityToObject	( "Morgan", "mccallister3", 1, 0, -1 )	
	Game.SetSprite      	( "Hurst", "hurst" )
	Game.AdviserSay 		( "MorganHappy", "conviction_suicide_4" )
    Game.Sound              ( "__ConvictionSuicide", "SuicideMusic3" )

	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_endpt3.png", 1 )
	Game.SendEntityToObject ( "Morgan", "mccallister4", 0, 1, 0.2 )
	Game.SendEntityToObject	( "Hurst", "hurst4", 0, -1, 0 )
	Game.CamMoveToObject	( "cammorganinterview", 1, 1.0, false )
	Game.Pause (4)

	Game.AdviserSay 		( "Hurst", "conviction_suicide_5" )
	Game.Remove 			( "KerryPhoto" )
	Game.GiveEquipment 		( "Hurst", "Photo" )
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_kerrybabypicture.png", 1 )
	
	Game.Pause 	(3)	
    Game.Sound              ( "__ConvictionSuicide", "SuicideMusic4" )
	Game.AdviserSay 		( "MorganHappy", "conviction_suicide_6" )
	
	Game.CamZoom 			( 3, 10, false )
	Game.FadeToBlack 		( 5, true )
	
	-- Tidy up
	
	Game.HidePolaroid 		( "polaroidmorgan" )
	Game.Remove 			( "Hurst" )
	Game.SendEntityToObject ( "Morgan", "markermorgan", 1, 0, -1 )
	Game.SetFlag 			( "morgandoor", "LockedOpen", false )
	Game.Show 				( "WorldSounds" )
	
end 

