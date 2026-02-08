
function CutsceneVisitation()

	Game.SetMap( "conviction" )    

	ConvictionVisitation()
	
    Game.FadeUp             (1,false)
    Game.GameOver           ()	
end 


function ConvictionVisitation()
	
	-- Spawn guard at front of queue 
    
    Game.UnlockCollectable("ConvictionVisitation")
	Game.Hide ( "WorldSounds" )
	
	Game.Spawn          	( "Actor", "VisitationGuard", 0, 0 )
    Game.SetSprite      	( "VisitationGuard", "Guard" )
	Game.SendEntityToObject	( "VisitationGuard", "guard1", 1, 0, -1 )	

	Game.Spawn          	( "Actor", "VisitationGuard2", 0, 0 )
    Game.SetSprite      	( "VisitationGuard2", "Keane" )
	Game.SendEntityToObject	( "VisitationGuard2", "guard2", 1, 0, -1 )	

	Game.Spawn          	( "Actor", "VisitationGuard3", 0, 0 )
    Game.SetSprite      	( "VisitationGuard3", "Guard2" )
	Game.SendEntityToObject	( "VisitationGuard3", "restrainer1", 0, -1, -1 )	

	
	-- Move Morgan	
	
	Game.SendEntityToObject	( "Morgan", "morgan1", 1, 0, -1 )	
    Game.SetSprite      	( "Morgan", "Morgan" )

	Game.Spawn          	( "Actor", "VisitedPrisoner", 0, 0 )
    Game.SetSprite      	( "VisitedPrisoner", "BenedictHenchman2" )
	Game.SendEntityToObject	( "VisitedPrisoner", "visitor", 1, 0, -1 )	
	
	numVisitors = 9
	
	-- Spawn queue of visitors
	
	for i = 0, numVisitors do	
		visitorName = "Visitor" .. i
		markerName = "queue" .. i

        if i == 1 then
            Game.Spawn         ( "Actor", visitorName, 0, 0 )
            Game.SetSprite      ( visitorName, "Kerry" )
        else
            Game.Spawn          	( "Visitor", visitorName, 0, 0 )
        end

		Game.SendEntityToObject	( visitorName, markerName, -1, 0, -1 )	
	end 
			
	-- Cam position
    
    Game.Sound                  ( "__ConvictionVisitation", "ConvictionSFXLoop" )
    Game.Sound                  ( "__ConvictionVisitation", "ConvictionMusic1" )
	
	Game.CamMoveToObject	( "cam1", 0, 1.0, true )
	Game.Pause 				(2)
	
	-- Front visitor is waved through. 
	
	Game.SendEntityToObject 	( "Visitor0", "queue_inside", 0, 1, 0.3 )
	Game.CamMoveToObject		( "cam2", 8, 1.0, false )	
	Game.Pause 					(1)
	
	-- The rest of the queue advances
	
	for i = 1, numVisitors do
		visitorName = "Visitor" .. i
		markerName = "queue" .. (i-1)
	
		Game.SendEntityToObject 	( visitorName, markerName, -1, 0, 0.2 - i * 0.01 )
		Game.Pause 					(0.4 )
		if i == 1 then Game.Pause(1) end 
	end 
	
	-- Kerry's first attempt

	Game.AdviserSay	 		( "Kerry", "conviction_visitation_0" )
	Game.AdviserSay 		( "Chief", "conviction_visitation_1" )
	Game.Pause 				(2)
	Game.AdviserSay	 		( "Kerry", "conviction_visitation_2" )
	Game.AdviserSay 		( "Chief", "conviction_visitation_3" )
	Game.Pause 				(2)
	Game.AdviserSay	 		( "Kerry", "conviction_visitation_4" )

	-- Everyone goes back one place
	
	Game.CamMoveToObject	( "cam3", 4, 1.0, false )
    
    Game.Sound                  ( "__ConvictionVisitation", "ConvictionSFX1" )

	for i = 1, numVisitors do
		visitorName = "Visitor" .. i
		markerName = "queue" .. i
	
		Game.SendEntityToObject 	( visitorName, markerName, -1, 0, 0.2 )
		
		if i == 1 then  Game.Pause (2)
		else 			Game.Pause (0.5)
		end 
		
	end 
	
	-- Kerry's second attempt 
	
	Game.Pause 				(2)
	Game.AdviserSay 		( "Chief", "conviction_visitation_5" )
	
	-- The rest of the queue advances
	
	Game.CamMoveToObject	( "cam2", 4, 1.0, false )

	for i = 1, numVisitors do
		visitorName = "Visitor" .. i
		markerName = "queue" .. (i-1)
	
		Game.SendEntityToObject 	( visitorName, markerName, -1, 0, 0.2 - i * 0.01 )
		Game.Pause 					(0.4 )
		if i == 1 then Game.Pause(1) end 
	end 
	
	Game.AdviserSay 		( "Chief", "conviction_visitation_6" )	
	Game.AdviserSay	 		( "Kerry", "conviction_visitation_7" )
	Game.AdviserSay 		( "Chief", "conviction_visitation_8" )

	
	-- Kerry goes into the room
    
    Game.Sound                  ( "__ConvictionVisitation", "ConvictionMusic2" )
	 
	Game.SendEntityToObject 	( "Visitor1", "kerry1", 0, 1, 0.5 )
	Game.CamMoveToObject		( "cam4", 5, 1.0, false )
	
	-- The rest of the queue advances
	
	for i = 2, numVisitors do
		visitorName = "Visitor" .. i
		markerName = "queue" .. (i-2)	
		Game.SendEntityToObject ( visitorName, markerName, -1, 0, 0.2 - i * 0.01 )
		Game.Pause 				(0.3)
	end 
	
	Game.Pause 					(3)
	
	Game.AdviserSay 			( "MorganHappy", "conviction_visitation_8a" )
	
	
	-- She advances, but the guard comes over to stop here
	
	Game.SendEntityToObject 	( "Visitor1", "kerry2", 0, 1, 0.3 )
	Game.SendEntityToObject 	( "VisitationGuard2", "guard3", 0, -1, 0.6 )	
	Game.CamMoveToObject		( "cam4", 6, 0.8, false )
	Game.Pause 			(3)
    	
	Game.AdviserSay 		( "Keane", "conviction_visitation_9" )

	Game.PolaroidAtMarker   ( "visitpolaroid", "campaign/conviction/ill_chap3_kerrycryingbaby.png", 1 )
    Game.Sound              ( "__ConvictionVisitation", "ConvictionSFX2" )
	Game.Pause 				(2)
	Game.CamZoom 			( 0.8, 30, false )
	
	Game.AdviserSay 		( "Kerry", "conviction_visitation_9b" )
	Game.PolaroidAtMarker  	( "visitpolaroid", "campaign/conviction/ill_chap5_keanesmelling.png", 1 )	
	Game.AdviserSay 		( "Keane", "conviction_visitation_9c" )
	Game.Pause 				(2)
	
	Game.AdviserSay 		( "Kerry", "conviction_visitation_10" )
	Game.AdviserSay 		( "Keane", "conviction_visitation_11" )
	Game.Pause 				(1)

	-- She gives the guard a photo
	
    Game.Sound                  ( "__ConvictionVisitation", "ConvictionMusic3" )
	Game.AdviserSay 	( "Kerry", "conviction_visitation_12" )
	Game.Pause 			(1)
	Game.GiveEquipment	( "Kerry", "Photo" )

	Game.PolaroidAtMarker   ( "visitpolaroid", "campaign/conviction/ill_chap3_kerrybabypicture.png", 1 )

	Game.Pause 			(1)
	Game.LoseEquipment	( "Kerry" )
	Game.GiveEquipment 	( "VisitationGuard2", "Photo" )
	Game.Pause 			(1)
	Game.LoseEquipment 	( "VisitationGuard2" )
	Game.Pause 			(2)
	
	
	-- Kerry leaves, guard goes back to desk
	
    Game.AdviserSay             ( "Keane", "conviction_visitation_13" )
    Game.Pause                  (3)
    Game.AdviserSay             ( "Kerry", "conviction_visitation_14" )
    Game.Pause                  (3)

	Game.LoseEquipment 		( "VisitationGuard2" )
	
	Game.HidePolaroid 			( "visitpolaroid" )
	Game.SendEntityToObject 	( "Visitor1", "kerry3", 0, 1, 0.3 )
	Game.SendEntityToObject 	( "VisitationGuard2", "guard3", 1, 0, 0.0 )		
	Game.Pause 					(3)
	Game.SendEntityToObject 	( "VisitationGuard2", "guard2", 1, 0, 0.5 )	

	-- Morgan freaks out, gets restrained
	
	Game.Show 				( "WorldSounds" )
    Game.Sound                 ( "__ConvictionVisitation", "ConvictionMusic4" )
	Game.CamMoveToObject	( "cam5", 5, 1.0, false )
	
	for i = 0, 3 do
		captionId = "conviction_visitation_angrymorgan" .. i
		Game.AdviserSay 	( "MorganHappy", captionId )
		Game.UseWeapon		( "Morgan", "booth" )
		Game.Damage 		( "booth", 0.2, "Morgan" )
		Game.Pause 			(0.5)
		
		if i == 2 then 
			Game.SendEntityToObject		( "VisitationGuard3", "Morgan", 0, -1, 0.5 )
		end
	end
	
	Game.Pickup 				( "VisitationGuard3", "Morgan" )
	Game.Pause(1)	
	Game.SendEntityToObject 	( "VisitationGuard3", "restrainer2", 0, 1, 0.2 )
	Game.CamMoveToObject		( "cam5", 20, 5.0, false )	
	Game.AdviserSay 			( "MorganHappy", "conviction_visitation_angrymorgan4" )
    
    Game.StopSound              ( "__ConvictionVisitation", "ConvictionSFXLoop" )
	
	Game.Pause (3)
	Game.FadeToBlack            ( 5, true )
	
	
	-- Tidy up
	
	Game.Remove					( "Visitor1" )
	Game.Drop 					( "VisitationGuard3" )
	Game.Remove 				( "VisitationGuard3" )
	Game.SendEntityToObject 	( "Morgan", "markermorgan", 1, 0, -1 )
	
end 
	
