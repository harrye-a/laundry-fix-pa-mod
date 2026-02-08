
function ConvictionCutsceneMorgan()

	Game.SetMap( "conviction" )
	Game.FadeToBlack(0,true)
	CutsceneMorgan()

    Game.GameOver()

end 


function CutsceneMorgan()
	
	-- Spawn Hurst and Mccallister
	-- They are walking down the corridoor
    
    Game.UnlockCollectable("ConvictionMorgan")
    Game.Hide				( "WorldSounds" )
	
    Game.Sound              ( "__ConvictionMorgan", "MorganMusic1" )
	
	Game.Spawn          	( "Actor", "Hurst", 0, 0 )
    Game.SetSprite      	( "Hurst", "hurst" )
	Game.SendEntityToObject	( "Hurst", "hurst1", 0, 1, -1 )	
	
	Game.Spawn          	( "Actor", "Mccallister", 0, 0 )
    Game.SetSprite      	( "Mccallister", "Guard" )
	Game.SendEntityToObject	( "Mccallister", "mccallister1", 0, 1, -1 )	


	-- Fade up on Morgan. We see him in a bad way.
	
	Game.CamMoveToObject	( "cammorgan2", 0, 1.0, true )
    Game.FadeUp             ( 3, true )
	
	-- He drinks
	
	Game.CamMoveToObject	( "cammorgan1", 15, 1.05, false )
	Game.GiveEquipment 		( "Morgan", "Booze" )
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap5_morgandrinking.png", 1 )
	Game.Pause(3)
	Game.LoseEquipment 		( "Morgan" )
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap5_morgannervous.png", 1 )
	Game.Pause(2)	
	
	
	-- They have some conversation

	Game.SendEntityToObject ( "Hurst", "hurst2", 1, 0, 0.15 )
	Game.SendEntityToObject ( "Mccallister", "mccallister2", -1, 0, 0.15 )
	
	Game.AdviserSay 		( "Hurst", "conviction_hurst1" )
	Game.AdviserSay 		( "Hurst", "conviction_hurst2" )
	Game.AdviserSay 		( "Chief", "conviction_hurst3" )
	
	-- Chief disagrees
	
	Game.CamMoveToObject	( "cameramorgan3", 1.5, 1.0, true )
	Game.PolaroidAtMarker   ( "polaroidmorgan2", "campaign/conviction/alpha.png", 1 )
	
	Game.AdviserSay 		( "Hurst", "conviction_hurst4" )
	Game.AdviserSay 		( "Hurst", "conviction_hurst4b" )
	Game.AdviserSay 		( "Hurst", "conviction_hurst4c" )
    
    Game.Sound              ( "__ConvictionMorgan", "MorganMusic2" )
    
	Game.AdviserSay 		( "Chief", "conviction_hurst6" )
	
	-- They approach Morgan's cell

	Game.HidePolaroid 		( "polaroidmorgan2" )
	Game.HidePolaroid 		( "polaroidmorgan" )
	Game.SendEntityToObject ( "Mccallister", "mccallister3", 0, 1, 0.4 )
	Game.Pause 				(1)
	Game.SendEntityToObject ( "Hurst", "hurst3", 1, 0, 0.35 )
	Game.CamMoveToObject	( "cammorganinterview", 5, 1.0, false )	
	Game.Pause 				(4)
	
	-- Mccallister goes into Morgan's cell, wakes him up
		
	Game.SetFlag 			( "morgandoor", "LockedOpen", true )
    Game.Sound              ( "__ConvictionMorgan", "MorganSFX2" )    
    Game.Sound              ( "__ConvictionMorgan", "MorganMusic3" )
    
	Game.GiveEquipment 		( "Mccallister", "Baton" )
	Game.AdviserSay 		( "Chief", "conviction_hurst6b" )
	Game.SendEntityToObject ( "Mccallister", "mccallister4", 0, 1, 0.7 )
    Game.Sound              ( "__ConvictionMorgan", "MorganSFX1" )
    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_jail1.png", 1 )
	Game.Pause 				(3)
    Game.Sound              ( "__ConvictionMorgan", "MorganMusic4" )
	Game.AdviserSay 		( "Chief", "conviction_hurst7" )
	Game.SendEntityToObject ( "Morgan", "markermorgan", 1, 0, 0.1 )

	-- Mccallister leaves the cell, invites Hurst into
	
	Game.SendEntityToObject ( "Mccallister", "mccallister5", -1, 0, 0.3 )
	Game.LoseEquipment 		( "Mccallister" )
	Game.Pause 				(2)
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_jail3.png", 1 )
	Game.Pause 				(1)
    Game.Sound              ( "__ConvictionMorgan", "MorganMusic5" )
	Game.AdviserSay 		( "Chief", "conviction_hurst8" )
	Game.Pause 				(2)
	
	-- Hurst goes into the cell, morgan turns to face him
	
	Game.SendEntityToObject	( "Hurst", "hurst4", -1, 0, 0.4 )
	Game.Pause 				(2)
			
	-- Bulk of conversation 
	Game.Sound              ( "__ConvictionMorgan", "MorganMusic6" )
    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_jail4-1.png", 1 )
	Game.Pause 				(3)
	Game.CamZoom            ( 0.8, 30, false )

	Game.AdviserSay 		( "Hurst", "conviction_hurst10" )
    Game.Pause              (3)
    Game.AdviserSay         ( "Chief", "conviction_hurst10b" )
    Game.Pause              (1)

	Game.AdviserSay 		( "Morgan", "conviction_hurst11" )

    -- Hurst hands shirt

	Game.SendEntityToObject	( "Hurst", "hurst4", 1, 0, -1 )
	Game.Pause 				(0.5)
    Game.Remove 			( "morganshirt" )
	Game.GiveEquipment 		( "Hurst", "PrisonerUniform" )
	Game.Pause 				(0.5)
	Game.SendEntityToObject	( "Hurst", "hurst4", -1, 0, -1 )
	Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_jail4.png", 1 )
    Game.Pause              (2)

    Game.AdviserSay 		( "Hurst", "conviction_hurst12" )
	Game.AdviserSay 		( "Morgan", "conviction_hurst13" )

    -- Rat appears, conversation pauses

    Game.Sound              ( "__ConvictionMorgan", "MorganSFX3" )
    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_rat.png", 1 )
	Game.LoseEquipment 		( "Hurst" )
    Game.SendEntityToObject	( "Hurst", "hurst4", 1, 0, -1 )
    Game.Pause 				(1)
    Game.HidePolaroid 		( "polaroidmorgan" )
    Game.Pause 				(3)
    Game.SendEntityToObject	( "Hurst", "hurst4", -1, 0, -1 )

	Game.AdviserSay 		( "Hurst", "conviction_hurst15" )
	Game.AdviserSay 		( "Morgan", "conviction_hurst16" )
    Game.AdviserSay 		( "Hurst", "conviction_hurst16b" )
    Game.AdviserSay 		( "Morgan", "conviction_hurst16c" )
	Game.AdviserSay 		( "Hurst", "conviction_hurst17" )
	Game.AdviserSay 		( "Morgan", "conviction_hurst18" )

    -- They stand, shake hands

    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap3_HurstandMorganShake.png", 1 )
    Game.Pause              (2)
	Game.AdviserSay 		( "Hurst", "conviction_hurst19" )
	Game.Pause 				(2)

	
	Game.AdviserSay 		( "Hurst", "conviction_hurst19b" )
	Game.AdviserSay 		( "Morgan", "conviction_hurst20" )
	
	-- Senator leaves cell
	-- Asks Mccallister to deal with the rats 
	
	Game.HidePolaroid 			( "polaroidmorgan" )
	Game.SendEntityToObject 	( "Hurst", "mccallister4", 0, 1, 0.4 )
	Game.Pause 					(2)
	Game.AdviserSay 			( "Hurst", "conviction_hurst14" )	
	Game.CamMoveToObject		( "cammorgan5", 3, 1.0, false )	
	Game.SendEntityToObject 	( "Hurst", "hurst3", 1, 0, 0.4 )
	Game.Pause 					(3)
	Game.AdviserSay 			( "Hurst", "conviction_hurst21" )
	Game.AdviserSay 			( "Chief", "conviction_hurst22" )
	
	-- They walk away 
	
	Game.SendEntityToObject ( "Hurst", "hurst2", 1, 0, 0.2 )
	Game.SendEntityToObject ( "Mccallister", "mccallister2", -1, 0, 0.2 )
	Game.SetFlag 			( "morgandoor", "LockedOpen", false )

    -- Fade+zoom out, Remove the actors

    Game.CamZoom 			( 1.5, 6, false )
	Game.Pause 				(3)
    Game.FadeToBlack        ( 3, true )
    Game.Remove             ( "Hurst" )
    Game.Remove             ( "Mccallister" )
	Game.Show 				( "WorldSounds" )

end


-----------------------------------------------------------------------------------------------------
-- Hurst second visit
-- Hurst visits Morgan again, dives a bit deeper.
-- Morgan tells us how he got here - the armoured car raid
-- Requests visitation, something to do.
-----------------------------------------------------------------------------------------------------

function CutsceneHurstSecondVisit()

    Game.UnlockCollectable("ConvictionHeist")
	
	-- Spawn our characters 
    
	Game.Hide				( "WorldSounds" )
    Game.Sound              ( "__ConvictionHeist", "HeistMusic0" )
	
	Game.Spawn          	( "Actor", "Hurst", 0, 0 )
    Game.SetSprite      	( "Hurst", "hurst" )
	Game.SendEntityToObject	( "Hurst", "hurst4", -1, 0, -1 )
		
	Game.Spawn          	( "Actor", "Mccallister", 0, 0 )
    Game.SetSprite      	( "Mccallister", "Guard" )
	Game.SendEntityToObject ( "Mccallister", "mccallister5", -1, 0, -1 )

	Game.SendEntityToObject ( "Morgan", "markermorgan", 1, 0, -1 )

	-- Fade up on Morgan. 

	
	--Game.Sound              ( "__ConvictionMorgan", "MorganMusic6" )
	 
	Game.CamMoveToObject	( "cammorganinterview", 0, 1.0, true )
	Game.CamZoom 			( 0.8, 25, false )
    Game.FadeUp             ( 3, true )
	
	
	-- Chat
	
	Game.AdviserSay 		( "Hurst", "conviction_secondvisit_1" )
	Game.AdviserSay 		( "Morgan", "conviction_secondvisit_2" )
	Game.AdviserSay 		( "Hurst", "conviction_secondvisit_3" )
	Game.AdviserSay 		( "Morgan", "conviction_secondvisit_4" )
	Game.AdviserSay 		( "Hurst", "conviction_secondvisit_5" )
	Game.AdviserSay 		( "Morgan", "conviction_secondvisit_6" )
    Game.AdviserSay 		( "Hurst", "conviction_secondvisit_7" )

	
	-- Fade down
	-- Armoured car heist scene
	-- Fade back up on this map on Morgan again
	
    Game.BeginSkippable     ()
    Game.FadeToBlack        ( 1, true )
	Game.SaveMap			( "conviction-secondvisit" )
	Game.StopSound 			( "__ConvictionMorgan", "MorganMusic6" )
	
	Conviction_HeistCutscene()
    
	Game.SetMap				( "conviction-secondvisit" )
    Game.EndSkippable       ()
	Game.SetZoneBlocked		( 2, true )


    -- Show the mugshots of the two robbers
    -- Morgan protests that he hasnt seen his family

 	Game.Sound              ( "__ConvictionMorgan", "MorganMusic5" )
    Game.CamMoveToObject 	( "mugshotcam", 0, 1.0, true )
    Game.Pause              (1)
    Game.FadeToColour       ( 1,1,1,0, 0.1, false )

    Game.FadeToColour       ( 1,1,1,1, 0.0, true )
    Game.PolaroidAtMarker   ( "mugshot1", "campaign/conviction/ill_chap3_BenedictMugshot.png", 4 )
    Game.Sound 				( "_Campaign", "PhotoFlash" )
    Game.FadeToColour       ( 1,1,1,0, 0.1, false )
    Game.Pause 				(2)
    Game.CamZoom 			( 1.2, 10, false )

    Game.FadeToColour       ( 1,1,1,1, 0.0, true )
    Game.PolaroidAtMarker   ( "mugshot2", "campaign/conviction/ill_chap3_MorganMugshot.png", 4 )
    Game.Sound 				( "_Campaign", "PhotoFlash" )
    Game.FadeToColour       ( 1,1,1,0, 0.1, false )

    Game.Pause 				(2)

    Game.AdviserSay         ( "Morgan", "conviction_secondvisit_11b" )
    Game.Sound              ( "__ConvictionHeist", "HeistMusic11" )


    -- Back to Morgan
    -- He's still feeling suicidal

	Game.CamMoveToObject	( "cammorganinterview", 0, 0.8, true )
	Game.CamZoom 			( 0.8, 25, false )
    Game.PolaroidAtMarker   ( "polaroidmorgan", "campaign/conviction/ill_chap5_morgannervous.png", 1 )
    Game.Pause				(2)

    Game.HidePolaroid		( "mugshot2" )
    Game.HidePolaroid 		( "mugshot1" )

    Game.AdviserSay         ( "Morgan", "conviction_secondvisit_12" )
	Game.AdviserSay 		( "Hurst", "conviction_secondvisit_13" )
    Game.AdviserSay         ( "Morgan", "conviction_secondvisit_14" )
    Game.Sound              ( "__ConvictionHeist", "HeistMusic12" )
    Game.AdviserSay 		( "Hurst", "conviction_secondvisit_15" )


    -- Fade+zoom out, Remove the actors

    Game.FadeToBlack        ( 3, true )
    Game.Remove             ( "Hurst" )
    Game.Remove             ( "Mccallister" )
	Game.HidePolaroid 		( "polaroidmorgan" )
	Game.StopSound          ( "__ConvictionMorgan", "MorganMusic6" )
	Game.Show 				( "WorldSounds" )

end



