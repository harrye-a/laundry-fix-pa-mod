
function CutsceneFamilyFeud()
    
	-- We use a special empty version of the map
	-- So the fight isnt interrupted by guards or prisoners
	
	Game.SetMap( "food" )
	Game.FadeToBlack 	(0,true)

    Food_FamilyFeud()
	
    Game.GameOver()
    
end


-------------------------------------------------------------------------------
-- Family Feud
-------------------------------------------------------------------------------

function Food_FamilyFeud()
    
    Game.UnlockCollectable("FoodFeud")
    
	-- Block out everything we really don't care about all around us
	Game.ExclusionZone  ( "Feud", 28, 11, 85, 35 )

    Game.Show               ( "Flashback" )
	Game.Hide 				( "WorldSounds" )
	
    -- Spawn Sonny + henchman
    
    Game.SendEntityToPos( "Sonny", 54, 23, -1, 0, -1 )
    Game.SendEntityToPos( "Sonny", 47, 23, -1, 0, 0.1 )    
    Game.GiveEquipment  ( "Sonny", "Knife" )
    
    
    -- Nico is already in the shower
    
    Game.SendEntityToPos( "Nico", 38, 23, -1, 0, -1 )
	Game.SetSprite		( "Nico", "NicoNaked" )
    Game.CamTrack       ( "Nico", 0.01 )
	Game.FadeUp             (1,false)
	Game.Sound			( "__FoodFeud", "Feud_1a" )	
    Game.CamZoom        ( 1.3, 10 )
    Game.Pause          ( 5 )
    

    -- Sonny approaches
    
	Game.Sound			( "__FoodFeud", "Feud_1b" )	
    Game.CamTrack       ( "Sonny", 0.01 )
    Game.Pause          ( 5 )
	
	Game.Sound			( "__FoodFeud", "Feud_1c" )	
    Game.CamTrack       ( "Nico", 0.01 )
    Game.CamZoom        ( 0.8, 5 )
    Game.Pause          ( 2 )
	
    Game.CamTrack       ( "Sonny", 0.02 )
    Game.Pause          ( 4 )
    
    
    -- Sonny enters the shower, they see each other
        
	Game.Sound			( "__FoodFeud", "Feud_1d" )	
    Game.AdviserSay     ( "Sonny", "cutscene_food_feud1b" )
	Game.Sound			( "__FoodFeud", "Feud_1e" )	
    Game.SendEntityToPos( "Sonny", 43, 21, -1, 0, 0.5 )
    Game.CamMove        ( 34, 20, 48, 28, 4, true )
    
    local polaroidX = 45.5
    local polaroidY = 25
    local polaroidSize = 4.5
    
    -- Some dialog occurs, Sonny moves closer gradually, we zoom in on them
    
    Game.Sound			( "__FoodFeud", "Feud_1f" )	
	Game.Polaroid       ( "Amends", "campaign/food/ill_mafia_8.png", polaroidX, polaroidY+1, polaroidSize, polaroidSize )
    Game.Pause          (3)

    Game.SendEntityToPos( "Nico", 38, 23, 1, 0, 1 )
    Game.Sound			( "__FoodFeud", "Feud_1g" )	
	Game.AdviserSay     ( "NicoShower", "cutscene_food_feud1" )
	Game.Sound			( "__FoodFeud", "Feud_1h" )		
    Game.AdviserSay     ( "Sonny", "cutscene_food_feud2" )
	Game.AdviserSay     ( "Sonny", "cutscene_food_feud2b" )
	Game.Sound			( "__FoodFeud", "Feud_1i" )		
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud3" )
	Game.AdviserSay     ( "NicoShower", "cutscene_food_feud3b" )
	Game.Sound			( "__FoodFeud", "Feud_1j" )		
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud4" )
    
    --Game.CamMove        ( 34, 20, 48, 28, 3, false )
    Game.SendEntityToPos( "Sonny", 40, 22, -1, 0, 0.2 )
    Game.SendEntityToPos( "Nico", 39, 22, 1, 0, 0.2 )
	Game.Sound			( "__FoodFeud", "Feud_1k" )		
    
    Game.Pause          (1)
    Game.AdviserSay     ( "Sonny", "cutscene_food_feud5" )
        
    
    -- Henchman wire approaches
    	
    Game.Spawn          ( "Actor", "HenchmanWire", 45, 18 )
    Game.SetSprite      ( "HenchmanWire", "Henchman" )
    Game.GiveEquipment  ( "HenchmanWire", "PianoWire" )
    Game.SendEntityToPos( "HenchmanWire", 44, 20, -1, 0, 0.1 )
	Game.Sound			( "__FoodFeud", "Feud_1l" )		
	
    Game.Pause          (5)
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud6" )
	Game.Sound			( "__FoodFeud", "Feud_1l" )		
    Game.SendEntityToPos( "HenchmanWire", 42, 21, -1, 0, 0.1 )
    Game.CamZoom        ( 0.8, 10, false )
    Game.Pause          (2)
   
    Game.AdviserSay     ( "Sonny", "cutscene_food_feud7" )

    Game.Polaroid       ( "Henchman", "campaign/food/ill_mafia_9.png", polaroidX-0.3, polaroidY-0.3, polaroidSize, polaroidSize )
	Game.Pause 			(2)
	
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud8" )

    -- The piano wire henchman strikes, strangling Sonny
        
    Game.SendEntityToPos( "HenchmanWire", 41, 22, -1, 0, 1 )
	Game.Sound			( "__FoodFeud", "Feud_1n" )		
    Game.Pause          ( 1 )

    Game.Polaroid       ( "PianoWire", "campaign/food/ill_mafia_10.png", polaroidX-0.3, polaroidY-0.3, polaroidSize*5, polaroidSize )
	Game.StopSound		( "__FoodFeud", "Feud_1l" )		
	Game.Sound			( "__FoodFeud", "Feud_1o" )		

    Game.Pickup         ( "HenchmanWire", "Sonny" )
    Game.CamZoom        ( 0.9, 30 )
	Game.Damage 		( "Sonny", 0.4, "HenchmanWire" )
    
    -- First half of strangle
    
    for i = 1, 40 do
        Game.SendEntityToPos( "HenchmanWire", 41, 22 + math.random(-1,1), math.random(-1,1), 0, 0.5 )
        Game.Damage         ( "Sonny", 0.005, "HenchmanWire" )
        Game.Pause          (0.12)
    end
	
    Game.SendEntityToPos( "HenchmanWire", 41, 22, -1, 0, 1 )
    Game.Pause          (1)
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud8d" )
	Game.Sound			( "__FoodFeud", "FeudSFX_1b" )		
    Game.AdviserSay     ( "SonnyStrangled", "cutscene_food_feud8b" )

    -- Second half of strangle
    
	Game.StopSound		( "__FoodFeud", "Feud_1o" )	
	Game.Sound			( "__FoodFeud", "Feud_1p" )	
		
    for i = 1, 40 do
        Game.SendEntityToPos( "HenchmanWire", 41, 22 + math.random(-1,1), math.random(-1,1), 0, 0.5 )
        Game.Damage         ( "Sonny", 0.00025, "HenchmanWire" )
        Game.Pause          (0.12)
    end

    Game.SendEntityToPos( "HenchmanWire", 41, 22, -1, 0, 1 )
    Game.Pause          (1)
    
    Game.AdviserSay     ( "NicoShower", "cutscene_food_feud8e" )    
	Game.Sound			( "__FoodFeud", "Feud_1q" )		    
    Game.AdviserSay     ( "SonnyStrangled", "cutscene_food_feud8c" )            
    
	-- Sonny and the assassin crash into Nico out of control. 
	-- Nico takes a knife wound
	
    Game.SendEntityToPos( "HenchmanWire", 39, 22, -1, 0, 2 )
    Game.CamMoveToObject( "Nico", 0.4, 1.0, false )
	Game.Pause 	(0.15)
	Game.Sound 			( "__FoodFeud", "NicoSlash" )
   	Game.Sound			( "__FoodFeud", "Feud_1o" )		
	Game.SendEntityToPos( "Nico", 38.5, 22, 0, 1, 2 )
	Game.Damage         ( "Nico", 0.5, "Sonny" )
    Game.Polaroid       ( "SlashNico", "campaign/food/ill_mafia_11.png", 36.8, 23, polaroidSize*4, polaroidSize-1 )
	Game.Pause 	(0.85)
	Game.CamZoom 		( 0.9, 2, false )
	Game.Pause 			(1)
    Game.Polaroid       ( "SlashNico", "campaign/food/ill_mafia_Nicochestwound.png", 36.8, 23, polaroidSize*4, polaroidSize-1 )
	Game.Damage         ( "Nico", 0.25, "Sonny" )
	
    -- Henchman drags Sonny around some more

	Game.SendEntityToPos( "HenchmanWire", 41, 22, -1, 0, 2 )
	Game.Sound			( "__FoodFeud", "Feud_1r" )	
    --Game.CamMove        ( 38, 20, 47, 27, 0.3, true )

    for i = 1, 20 do
        Game.SendEntityToPos( "HenchmanWire", 41, 22 + math.random(-1,1), math.random(-1,1), 0, 0.5 )
        Game.Pause          (0.12)
    end
    Game.SendEntityToPos( "HenchmanWire", 41, 22, -1, 0, 1 )
    Game.Pause          (0.5)
    
    -- Sonny strikes with his knife, killing piano wire henchmen

	Game.CamMove        ( 34, 20, 48, 28, 2, true )    
    Game.Sound			( "__FoodFeud", "Feud_1s" )		
	Game.Polaroid       ( "Stab1", "campaign/food/ill_mafia_12.png", polaroidX-0.5, polaroidY-0.5, polaroidSize*5, polaroidSize )
    Game.Damage         ( "HenchmanWire", 0.2, "Sonny" )
    Game.Drop           ( "HenchmanWire" )
    Game.LoseEquipment  ( "HenchmanWire" )	
 	Game.LoseEquipment	( "Sonny" )
	Game.SendEntityToPos( "HenchmanWire", 41.3, 22.5, 0, 1, -1 )
	Game.Sound			( "__FoodFeud", "FeudSFX_1g" )		
                
    -- The attacker stumbles away and dies
    -- Sonny stumbles a short distance then falls unconcious 
 
    Game.SendEntityToPos ( "Sonny", 42, 22, 1, 0, 0.01 )
    Game.SetSprite      ( "HenchmanWire", "HenchmanKnifed" )
    Game.SendEntityToPos( "HenchmanWire", 41, 25, 0, 1, 0.1 )
    Game.CamMove        ( 33, 19, 49, 29, 10, false )
    
    for i = 1, 25 do
        Game.Damage         ( "HenchmanWire", 0.03, "Sonny" )
        Game.Damage     	( "Sonny", 0.02, "HenchmanWire" )
        Game.Pause          (0.4)
    end
    

    -- Just to be sure :

    Game.Sound			( "__FoodFeud", "Feud_1t" )		
	Game.Polaroid       ( "Stab2", "campaign/food/ill_mafia_13.png", polaroidX-0.3, polaroidY-0.3, polaroidSize*5, polaroidSize )
    Game.Damage         ( "HenchmanWire", 100, "HenchmanKnife" )    
    Game.Damage         ( "Sonny", 100, "Nico" )
    Game.Pause			(3)
       
    -- Closing zoom out
    
    Game.Pause          ( 5 )
    
    Game.Sound			( "__FoodFeud", "Feud_1u" )		
    Game.Sound			( "__FoodFeud", "Feud_1v" )		
	
    Game.CamZoom        ( 5, 15, false )

    Game.Pause              (2)
    Game.FadeToBlack        (3, true)

    Game.HidePolaroid       ( "Amends" )
    Game.HidePolaroid       ( "Henchman" )
    Game.HidePolaroid       ( "PianoWire" )
    Game.HidePolaroid       ( "Stab1" )
    Game.HidePolaroid       ( "Stab2" )
	Game.HidePolaroid 		( "SlashNico" )

    Game.Hide               ( "Flashback" )

	Game.RemoveExclusionZone ( "Feud" )
	Game.Show   			( "WorldSounds" )
end


