
function CutsceneSuccession()

	Game.SetMap( "food" )
    
    Game.Remove             ( "BedBlocker1" )

	Game.Spawn          	( "Actor", "TheDon", 33.5, 102 )
    Game.SetSprite      	( "TheDon", "TheDonHurt" )
    Game.Damage         	( "TheDon", 0.8, "TheDon" )   
	Game.SendEntityToPos	( "TheDon", 33.5, 102, 0, 1, -1 )
	Game.LoadObjectInto		( "TheDon", "Bed1", 0 )

	Game.Spawn          	( "Actor", "NicoInjured", 33.5, 102 )
    Game.SetSprite      	( "NicoInjured", "NicoHospital" )
    Game.Damage             ( "NicoInjured", 0.5, "Nico" )
	Game.SendEntityToObject ( "NicoInjured", "NicoPos", -1, 0, -1 )

	Food_SuccessionEnding()
	
    Game.FadeUp             (1,false)
    Game.GameOver           ()

end



-- Succession Ending
-- Vitalia visits the family in the infirmary, and tells it like it is

function Food_SuccessionEnding()

    Game.UnlockCollectable("FoodSuccession")
    
	Game.ExclusionZone	( "InfirmaryZone", 27, 98, 40, 111 )

    Game.AttachScript       ( "DonEKG", "ekgbeep.lua" )
    Game.SetProperty        ( "DonEKG", "BeepSpeed", 1.9 )
    Game.Sound              ( "__FoodFeud", "FamilySuccession1" ) 
	Game.Hide 				( "WorldSounds" )
 
		-- Cam pan up onto infirmary
		
	Game.CamMoveToObject    ( "InfirmaryCam1", 0, 1, true )
    Game.FadeUp             ( 3, false ) 
	Game.Pause              (1)
    Game.CamMoveToObject    ( "InfirmaryWideShot", 6, 0.9, true )

		-- Spawn Vitalia, send her in
		
	Game.Spawn          	( "Actor", "Vitalia", 0, 0 )
    Game.SetSprite      	( "Vitalia", "PalermoDaughter1" )
	Game.SendEntityToObject	( "Vitalia", "Vitalia1", 0, 1, -1 )	
	Game.SendEntityToObject	( "Vitalia", "Vitalia2", 0, 1, 0.15 )
	Game.CamTrack 			( "Vitalia", 0.013 )
    Game.PolaroidAtMarker   ( "VitaliaPose", "campaign/food/ill_mafia_14.png", 1 ) 
 	Game.Pause 				(10)

		-- Nico close up, in danger
		
	Game.CamTrack       	( "NicoInjured", 0.01 )
	Game.SendEntityToObject	( "Vitalia", "Vitalia3", 0, 1, 0.5 )
    Game.CamZoom        	( 0.8, 5 )
    --Game.Sound				( "__FoodFeud", "Feud_1c" )	
    Game.Pause          	( 4 )

    	-- Vitalia arrives in the room, pauses.  Nico says hello

    Game.CamMoveToObject    ( "InfirmaryWideShot", 0, 1.0, false )
    Game.CamZoom            ( 1.1, 10, false )
    Game.SendEntityToObject ( "Vitalia", "Vitalia3", 1, 1, 0.7 )
    --Game.Sound              ( "__FoodFeud", "Feud_1k" )         
    Game.Pause 				(6)
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession1" )
    Game.Pause 				(2)

    	-- Vitalia goes to the Don, pauses, kisses him

    Game.CamMoveToObject    ( "InfirmarySuccession1", 5, 1.0, false )
    Game.SendEntityToObject	( "Vitalia", "DonBed1", -1, 0, 0.2 )
    Game.Pause 				(5)
    Game.Sound              ( "__FoodFeud", "FamilySuccession2" ) 
    Game.PolaroidAtMarker   ( "DonBedLeft", "campaign/food/ill_mafia_donunconcious.png", 1 ) 
    Game.Pause 				(3)
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession1" )
    Game.HidePolaroid       ( "DonBedLeft" )
    Game.Pause              (3)
    Game.AdviserSay         ( "NicoInfirmary", "cutscene_food_succession1b" )
    Game.Sound              ( "__FoodFeud", "FamilySuccession3" ) 
    Game.Pause              (2)

    	-- Vitalia finally goes to Nico

    Game.CamMoveToObject    ( "InfirmarySuccession2", 8, 1.1, false )
    Game.SendEntityToObject	( "Vitalia", "Vitalia4", 1, 0, 0.2 )
    Game.Pause 				(5)
    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_15.png", 1 ) 

    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession2" )
    Game.CamZoom            ( 0.95, 15, false )
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession3" )
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession4" )
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession5" )
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession6" )
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession7" )
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession8" )

    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_20.png", 1 ) 
    Game.Sound              ( "__FoodFeud", "FamilySuccession4" ) 
    Game.Pause 				(3)

    Game.Sound              ( "__FoodFeud", "FamilySuccession5" ) 
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession9" )
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession10" )
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession11" )

    	-- Vitalia reaches into hand bag

    --Game.Sound              ( "__DeathRowMurder", "Tension3" ) 
    --Game.Sound              ( "__DeathRowMurder", "ShowGun" ) 
    Game.Sound              ( "__FoodFeud", "FamilySuccession6" ) 
    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_16.png", 1 ) 
    Game.CamZoom            ( 0.95, 5, true )
	
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession12" )
    Game.Pause              (3)
    Game.Sound              ( "__FoodFeud", "FamilySuccession7" ) 
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession13" )

    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_purseDivorce.png", 1 ) 
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession14" )

    Game.CamMoveToObject    ( "InfirmarySuccession2", 0, 1.1, true )
    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_18.png", 1 ) 
    --Game.StopSound          ( "__DeathRowMurder", "Tension3" )
    --Game.StopSound          ( "__DeathRowMurder", "ShowGun" )
    Game.Pause              (2)
    Game.AdviserSay 		( "NicoInfirmary", "cutscene_food_succession15" )
    
    Game.PolaroidAtMarker   ( "NicoBed", "campaign/food/ill_mafia_17.png", 1 ) 
    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession16" )


    	-- Vitalia goes back to the Don

    Game.CamMoveToObject    ( "InfirmarySuccession1", 5, 1.0, false )
    Game.SendEntityToObject	( "Vitalia", "DonBed1", -1, 0, 0.3 )
    Game.Pause 				(5)
    Game.PolaroidAtMarker   ( "DonBedLeft", "campaign/food/ill_mafia_19.png", 1 ) 
    Game.CamZoom            ( 0.9, 5, false )
    Game.Pause              (3)

    Game.AdviserSay 		( "Vitalia", "cutscene_food_succession17" )
    
    	-- Vitalia goes to the doorway

    Game.HidePolaroid 		( "DonBedLeft" )
    Game.HidePolaroid       ( "NicoBed" )

    Game.CamMoveToObject    ( "InfirmaryWideShot", 5, 1.0, false )
    Game.SendEntityToObject ( "Vitalia", "Vitalia3", 1, 0, 0.4 )
    Game.Pause              (7)

    Game.AdviserSay         ( "Vitalia", "cutscene_food_succession18" )
    Game.SendEntityToObject ( "Vitalia", "Vitalia2", 0, 1, 0.22 )
    Game.CamZoom            ( 1.2, 10, false )
    Game.Pause              (4)
    Game.FadeToBlack        ( 4, true )
	Game.Pause 				(2)
    Game.RemoveScript       ( "DonEKG" )
    	
end

	
	