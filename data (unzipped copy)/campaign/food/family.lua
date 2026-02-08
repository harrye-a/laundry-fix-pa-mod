

function CutsceneInfirmary()

    Game.SetMap         ( "food" )
	
    Game.Remove         ( "BedBlocker1" )
    
    Game.Spawn          ( "Actor", "TheDon", 33.5, 102 )
    Game.SetSprite      ( "TheDon", "TheDonHurt" )
    Game.Damage         ( "TheDon", 0.7, "TheDon" )
    Game.LoadObjectInto	( "TheDon", "Bed1", 0 )

    Food_FamilyVisitDonInWard2()
    
    Game.FadeToBlack        ( 3, true )
    Game.GameOver           ()
end


function CutsceneFamily()

    Game.FadeToColour       (0,0,0,1,1,true)
    Food_MafiaHouseScene    ()
    
    Game.FadeToBlack        ( 3, true )	
    Game.GameOver           ()
    
end


-------------------------------------------------------------------------------
-- PolaroidCutsceneFamily
-- Triggered by the player clicking on the polaroid next to the Don in bed
-------------------------------------------------------------------------------

function PolaroidCutsceneFamily()

	Game.CamTrack   ( "TheDon", 0.004 )
	Game.CamZoom    ( 0.9, 10, false )	
	Game.Pause 		(3)	
	
	Game.SaveMap( "food-family" )
	
	Food_MafiaHouseScene()
	
	Game.FadeToBlack( 1, true )
	Game.SetMap( "food-family" )
	Game.CamTrack   ( "TheDon", 0.004 )
	Game.FadeUp( 1, false )
	
end 


-------------------------------------------------------------------------------
-- Family visit Don in ward scene
-------------------------------------------------------------------------------

function EkgFailure( length )

    Game.CamMoveToObject    ( "InfirmaryClose", 0, 1.1, true )
    --Game.Sound              ( "__FoodFamily", "EegSurge" )
    --Game.Sound              ( "__FoodFamily", "Coughing" )
    Game.CamZoom            ( 0.9, 10, false )
    Game.Pause              (length)
    --Game.StopSound          ( "__FoodFamily", "EegSurge" )
 
end


function Food_FamilyVisitDonInWard2()

    Game.UnlockCollectable("FoodInfirmary")
    
	Game.ExclusionZone	( "InfirmaryZone", 27, 98, 40, 111 )

	Game.Hide ( "WorldSounds" )
	
    local ekgBeepSpeed = 1.2
    Game.AttachScript       ( "DonEKG", "ekgbeep.lua" )
    Game.SetSprite          ( "TheDon", "TheDonHurt" )                  -- Swap burnt clothes for medical clothes + bandages

    Game.CamMoveToObject    ( "InfirmaryCam1", 0, 1, true )
    Game.FadeUp             ( 3, false ) 
    
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic1" )
    Game.Sound              ( "__FoodFamily", "InfirmarySFX1" )
    
    Game.Pause              (1)

    Game.CamMoveToObject    ( "InfirmaryCam2", 6, 0.9, true )

    Game.PolaroidAtMarker   ( "Eeg", "campaign/deathrow/eeg.png", 1 )   -- Highlight EEg
 
     
        -- Sonny and Nico enter

    Game.CamMoveToObject    ( "InfirmaryCam2", 0, 0.9, true )

    Game.SendEntityToPos    ( "Nico", 37, 95, -1, 0, -1 )
    Game.SendEntityToPos    ( "Sonny", 37, 97, -1, 0, -1 )
    Game.SendEntityToPos    ( "Nico", 32.63, 103.34, 1, 0, 0.4 )
    Game.SendEntityToPos    ( "Sonny", 34.2, 103.31, -1, 0, 0.5 )
 
    Game.CamZoom            ( 0.9, 12, true )                           -- Wait for everyone to get in place

    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.9 )

        -- Everyone is in position
    Game.Pause              (2)


     -- heart rate goes nuts, fits of coughing 
    Game.Sound              ( "__FoodFamily", "InfirmarySFX2" )
    Game.Sound              ( "__FoodFamily", "InfirmaryDefibAlarm1" )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.5 )
    EkgFailure              (6)
    Game.SetProperty        ( "DonEKG", "BeepSpeed", ekgBeepSpeed )
  --  Game.StopSound          ( "__FoodFamily", "EegNormal" )

   
        -- The don tries, and fails, to speak
        

    Game.CamMoveToObject    ( "InfirmaryCam2", 0, 0.9, true )
    Game.CamZoom            ( 0.9, 10, false )                           -- Wait for everyone to get in place

    Game.AdviserSay         ( "TheDon", "adviser_food_doncantspeak1" )
    --Game.StopSound          ( "__FoodFamily", "InfirmaryMusic1" )
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic2" )
    Game.Sound              ( "__FoodFamily", "InfirmarySFX3" )
    Game.Sound              ( "__FoodFamily", "InfirmaryDefibAlarm2" )
    
    Game.Pause              (1)
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.9 )
    Game.AdviserSay         ( "TheDon", "adviser_food_doncantspeak2" )
    Game.Pause              (1)
    Game.AdviserSay         ( "Sonny", "adviser_food_doninfirmary0" )
    
    Game.SetProperty        ( "DonEKG", "BeepSpeed", ekgBeepSpeed )


        -- Zoom in on the Don while we wait for him to spit it out

    Game.Pause              (1)
    Game.CamZoom            ( 0.6, 1, true )
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic3" )
    Game.AdviserSay         ( "TheDon", "adviser_food_doninfirmary1" )
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic4" )
    Game.Pause              (2)

    Game.CamMoveToObject    ( "InfirmaryCam2", 0, 0.7, true )
    Game.PolaroidAtMarker   ( "Lecture", "campaign/food/ill_mafia_5.png", 1 ) 
    Game.HidePolaroid       ( "Eeg" )
    Game.Pause              (2)  
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic5" )
    Game.AdviserSay         ( "Nico", "adviser_food_doninfirmary2" )


        -- Another coughing fit

    Game.Sound              ( "__FoodFamily", "InfirmaryMusic6" )
    Game.Sound              ( "__FoodFamily", "InfirmarySFX4" )
    Game.Sound              ( "__FoodFamily", "InfirmaryDefibAlarm3" )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.45 )
    EkgFailure              (6)
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.95 )
 

        -- more conversation

    Game.CamMoveToObject    ( "InfirmaryCam2", 0, 0.8, true )
    Game.CamMoveToObject    ( "InfirmaryCam2", 20, 0.9, false )
    Game.PolaroidAtMarker   ( "Lecture", "campaign/food/ill_mafia_4.png", 1 )
    Game.Pause              (1)
    Game.AdviserSay         ( "TheDonAngry", "adviser_food_doninfirmary3" )
    
    Game.SetProperty        ( "DonEKG", "BeepSpeed", ekgBeepSpeed )
    
    Game.AdviserSay         ( "TheDonAngry", "adviser_food_doninfirmary4" )
    Game.AdviserSay         ( "TheDon", "adviser_food_doninfirmary5" )
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic7" )
    Game.AdviserSay         ( "TheDon", "adviser_food_doninfirmary6" )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 0.8 )
    Game.Sound              ( "__FoodFamily", "InfirmaryMusic8" )
    Game.PolaroidAtMarker   ( "Lecture", "campaign/food/ill_mafia_5.png", 1 ) 
    Game.Pause              (3)
    Game.AdviserSay         ( "Sonny", "adviser_food_doninfirmary7" )
    

        -- Final coughing fit, but dont cut away
         -- Sonny & Nico leave

    Game.Pause              (1)
    Game.SetProperty        ( "DonEKG", "BeepSpeed", ekgBeepSpeed )
    Game.Pause              (1)
    Game.SendEntityToPos    ( "Nico", 34, 99, -1, 0, 0.3 )
    Game.Pause              (1)
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 1.6 )
    Game.SendEntityToPos    ( "Sonny", 33, 99, 1, 0, 0.3 )
    Game.CamMoveToObject    ( "InfirmaryCam3", 8, 0.9, true )


        -- Confrontation

    Game.CamMoveToObject    ( "InfirmaryCam3", 1, 0.55, true )
    Game.HidePolaroid       ( "Lecture" )
    Game.PolaroidAtMarker   ( "Confrontation", "campaign/food/ill_mafia_6.png", 4 )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 2.0 )
    Game.Pause              (2)
    Game.CamZoom            ( 0.9, 20, false )

    Game.AdviserSay         ( "Nico", "adviser_food_donchat14" )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 2.3 )
    Game.AdviserSay         ( "Sonny", "adviser_food_donchat13" )
    Game.RemoveScript       ( "DonEKG" )
    Game.StopSound          ( "__FoodFamily", "InfirmaryDefibNormal" )
    Game.Sound              ( "__FoodFamily", "InfirmaryDefibDissolve" )
    
    Game.SendEntityToPos    ( "Nico", 32, 56, 1, 0, 0.5 )
    Game.SendEntityToPos    ( "Sonny", 41, 55, 0, 1, 0.3 )
     
    Game.HidePolaroid      ( "Confrontation" )

    Game.CamZoom            ( 5, 2, true )

	Game.Show ( "WorldSounds" )
	
	Game.RemoveExclusionZone ( "InfirmaryZone" )
	
end

-------------------------------------------------------------------------------
-- Mafia house scene
-------------------------------------------------------------------------------

function Food_MafiaHouseScene()

    Game.UnlockCollectable("FoodFamily")
    
    local narrator = "Ceo"
    
    Game.SetMap     ( "mafia_house" )
    Game.FadeToBlack( 0, false )
    Game.Show       ( "Flashback" )
	Game.Sound		( "__FoodFamily", "Start" )	
	Game.Hide 		( "WorldSounds" )
	
	Game.SetSprite 	( "Vitalia", "PalermoDaughter2" )
	
    -- intro to the Don
    
    Game.CamTrack   ( "TheDon", 0.004 )
    Game.CamZoom    ( 1.4, 10, false )
    Game.FadeUp     ( 3, false )    
    Game.Pause      ( 2 )
    Game.AdviserSay ( narrator, "cutscene_foodfamily_palermo01" ) 
 
	
    Game.CamMove        	( 37, 35, 48, 42, 2, true )
	--Game.PolaroidAtMarker 	( "Photo", "campaign/food/ill_mafia_7.png", 1 )
    Game.CamZoom        	( 0.85, 30, false )
	--Game.Pause 				(3)
    Game.AdviserSay     	( narrator, "cutscene_foodfamily_palermo1" ) 
 
    Game.CamMoveToObject    ( "Anthony", 4, 0.9, false )
    Game.AdviserSay         ( "AnthonySuited", "cutscene_foodfamily_palermo02" )
    Game.CamMoveToObject    ( "Nico", 4, 1.0, false )
    Game.AdviserSay         ( "NicoSuited", "cutscene_foodfamily_palermo03" )
    Game.CamMoveToObject    ( "Sonny", 4, 1.0, false )
    Game.AdviserSay         ( "SonnySuited", "cutscene_foodfamily_palermo04" )
 
    Game.CamMove            ( 37, 35, 48, 42, 0, true )
    Game.CamZoom            ( 1.1, 10, false )
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo2" )
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo3" )
   

    -- Anthony killed, drugs found

    Game.CamMove            ( 34, 36, 45, 42, 1, true )
    Game.Polaroid           ( "Aftermath", "campaign/deathrow/aftermath.png", 38, 39, 3, 3 )
    Game.FadeToColour       ( 1,1,1,1, 0.0, true )
    Game.FadeToColour       ( 1,1,1,0, 0.1, false ) 
    Game.Damage             ( "Anthony", 200, "None" )
    Game.Sound              ( "__DeathRowMurder", "Gunshot2" )  
    
    Game.Pause              (2)
    Game.FadeToColour       ( 1,1,1,1, 0.0, true )
    Game.Polaroid           ( "CrimeScene", "campaign/food/crimescene.png", 38, 39, 3, 3 )
    Game.FadeToColour       ( 1,1,1,0, 0.1, false ) 
    Game.Sound              ( "__DeathRowMurder", "Gunshot2" )  
    
    Game.Pause              ( 3 )
    Game.CamMove            ( 35, 36, 42, 43, 3, false )
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo3b" )
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo4" )
    Game.FadeToColour       ( 1,1,1,1, 0.0, true )
    Game.Polaroid           ( "Evidence", "campaign/food/ill_mafia_1.png", 38, 39, 3, 3 )
    Game.FadeToColour       ( 1,1,1,0, 0.1, false ) 
    Game.Sound              ( "__DeathRowMurder", "EnterBedroom" )
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo5" )


    -- Wide of family again
    -- Police file into room
    
    Game.CamMove            ( 29, 36, 46, 43, 0, true )
    Game.SendEntityToPos    ( "Anthony", 0, 0, 0, 0, -1 )
    Game.HidePolaroid       ( "CrimeScene" )
    Game.HidePolaroid       ( "Evidence" )
    Game.HidePolaroid       ( "Aftermath" )
	Game.GiveEquipment 		( "PoliceGun1", "Shotgun" )
	Game.GiveEquipment 		( "PoliceGun2", "Shotgun" )
	Game.GiveEquipment 		( "PoliceGun3", "Shotgun" )
    Game.SendEntityToPos    ( "PoliceGun1", 44, 37, 0, 1, 0.7 )
    Game.SendEntityToPos    ( "PoliceGun2", 42, 37, 0, -1, 0.6 )
    Game.SendEntityToPos    ( "PoliceGun3", 40, 37, 0, -1, 0.5 )
    --Game.SendEntityToPos    ( "PoliceMedic", 41, 40, 0, -1, 0.7 )    
    Game.SendEntityToPos    ( "PoliceHandcuffer", 45, 40, 0, -1, 0.6 )
    Game.SendEntityToPos    ( "PoliceEscort", 42, 41, 1, 0, 0.4 )
    Game.CamMove            ( 33, 36, 50, 43, 10, true )
    
    Game.AdviserSay         ( narrator, "cutscene_foodfamily_palermo6" )

    -- Police, anthony's body, don and daughters all leave
    
    Game.Pickup             ( "PoliceHandcuffer", "TheDon" )
    Game.SendEntityToPos    ( "PoliceHandcuffer", 30, 38, 0, 1, 0.4 )
    Game.SendEntityToPos    ( "PoliceEscort", 30, 38, 0, 1, 0.3 )
	
	Game.Pickup 			( "PoliceGun3", "Nico" )
	Game.SendEntityToPos    ( "PoliceGun3", 30, 38, 0, 1, 0.4 )
    
	Game.Pickup 			( "PoliceGun2", "Sonny" )
    Game.SendEntityToPos    ( "PoliceGun2", 30, 38, 0, 1, 0.4 )
    Game.SendEntityToPos    ( "PoliceGun1", 30, 38, 0, 1, 0.4 )

    Game.Pause              (3)

    Game.CamMove            ( 33, 32, 47, 41, 10, false )
	
    Game.AdviserSay ( narrator, "cutscene_foodfamily_palermo7" )
	Game.AdviserSay ( narrator, "cutscene_foodfamily_palermo8" )
	Game.AdviserSay ( narrator, "cutscene_foodfamily_palermo9" )


	Game.StopSound			( "__FoodFamily", "Start" )	
  
	Game.Show 				( "WorldSounds" )
  
end

