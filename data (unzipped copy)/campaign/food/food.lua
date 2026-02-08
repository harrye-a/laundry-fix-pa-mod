
local suppressDialog = false
local inspectionSpeed = 0.6

local testMode = false

-------------------------------------------------------------------------------
-- Begin Chapter
-------------------------------------------------------------------------------

function BeginChapter()

    Game.UnlockCollectable( "Food" );
    Game.Show( "ObjectiveToolbarHighlights" )

	if testMode then
		TestChapter()
	else
	
		Game.FadeToColour		(0,0,0,1,0,true)
		Game.SetMap				( "food" )
		
		Game.Unlock( "EmergencyCallouts" )
		
		Food_StartFire()
		Food_Introduction()
		
	end
end


function TestChapter()

    Game.SetMap			( "food" )
	
    Game.Remove         ( "BedBlocker1" )
    
    Game.Spawn          ( "Actor", "TheDon", 33.5, 102 )
    Game.SetSprite      ( "TheDon", "TheDonHurt" )
    Game.Damage         ( "TheDon", 0.8, "TheDon" )
    Game.LoadObjectInto	( "TheDon", "Bed1", 0 )

	Food_AllObjectivesComplete()


end

-------------------------------------------------------------------------------
-- Start Fire
-------------------------------------------------------------------------------

function Food_StartFire()

	for i = 1, 30 do
		Game.Spawn( "Fire", "Fire", 60 + math.random( -4, 4 ), 64 + math.random( -4, 4 ) )
        Game.Spawn( "Fire", "Fire", 61 + math.random( -4, 4 ), 54 + math.random( -4, 4 ) )
        Game.Spawn( "Fire", "Fire", 72 + math.random( -4, 4 ), 63 + math.random( -4, 4 ) )
	end
	
end


-------------------------------------------------------------------------------
-- Food Introduction
-------------------------------------------------------------------------------

function Food_Introduction()

    Game.SetZoneBlocked( 1, true )   -- Shower
    Game.SetZoneBlocked( 2, true )   -- Infirmary
    Game.SetZoneBlocked( 3, true )   -- Outer Wall
    Game.SetZoneBlocked( 4, true )   -- Sonny/Nico Cells

	Game.CamMove			( 54, 62, 69, 72, 0, true )
	Game.Pause				(3)

    Game.FadeUp				(3,true)
    Game.AdviserSay         ( "CEO", "adviser_food_fire_1" )
	Game.CamZoom			( 3.0, 15, false )

 	Game.AdviserSay			( "CEO", "adviser_food_fire_2" )
	Game.AdviserSay			( "CEO", "adviser_food_fire_3" )
	Game.AdviserSay			( "CEO", "adviser_food_fire_4" )		
    

        -- Player objectives

    Objective.Create            ( "Food_CallFireBrigade" )
    Objective.RequireObjects 	( "Fireman", 1 )
    
    Objective.Create            ( "Food_ExtinguishFlames" )
    Objective.RequireObjects    ( "Fire", 1 )
    Objective.Invert            ()

    Trigger.Create              ( "Food_PalermoLives" )
    Trigger.RequireObjective    ( "Food_CallFireBrigade" )
    Trigger.RequireObjective    ( "Food_ExtinguishFlames" )
		

end



-------------------------------------------------------------------------------
-- Palermo Lives
-- Spawn the Don inside the burnt out wreckage
-- Ask the player to construct the medical ward
-------------------------------------------------------------------------------

function Food_PalermoLives()

        -- Show Devastation
        -- Pan across the burnt out ruins, in order to hide the spawning of Palermo

    Game.CamMove    ( 71, 53, 96, 69, 0, true )
    Game.CamZoom    ( 1.3, 10, false )

        -- Setup Don Palermo + rescuers

	Game.Spawn			( "Actor", "TheDon", 60, 72 )
	Game.SetSprite		( "TheDon", "TheDon" )
    Game.Damage 		( "TheDon", 0.7, "TheDon" )
    
    Game.Spawn          ( "Actor", "Wiggins", 56, 80 )
    Game.SetSprite      ( "Wiggins", "Guard2" )
    Game.Spawn          ( "Actor", "DonRescuer2", 64, 79 )
    Game.SetSprite      ( "DonRescuer2", "Guard" )
 
        -- Don steps out of wreckage
        -- AUDIO : Don coughing, escaping from ruins

    Game.SendEntityToPos    ( "TheDon", 60, 75, 0, 1, 0.2 )
    Game.SendEntityToPos    ( "Wiggins", 59, 75, 0, -1, 1 )
    Game.SendEntityToPos    ( "DonRescuer2", 61, 75, 0, -1, 1 )
   
    Game.Sound				( "__FoodFamily", "InfirmarySFX3" )	
	
    Game.CamMove            ( 49, 66, 69, 80, 1, true )
    Game.CamMove            ( 49, 68, 69, 82, 4, false )
    Game.AdviserSay         ( "CEO", "adviser_food_savedon1" )
    Game.Pause              (2)

        -- Guards help him out further

    Game.Polaroid           ( "Rescue", "campaign/food/ill_mafia_3.png", 65, 78, 4, 4 )

	Game.Pickup 			( "Wiggins", "TheDon" )
    Game.SendEntityToPos    ( "Wiggins", 59, 77, 1, 0, 0.5 )
    Game.SendEntityToPos    ( "DonRescuer2", 61, 77, -1, 0, 0.5 )
    --Game.SendEntityToPos    ( "TheDon", 60, 77, 0, 1, 0.2 )

    Game.CamMove            ( 55, 74, 68, 82, 4, true )
 
	Game.Drop 			 ( "Wiggins" )
	Game.SendEntityToPos ( "TheDon", 60, 77, 0, 1, 0.2 )
    Game.AdviserSay      ( "CEO", "adviser_food_savedon2" )
    Game.Damage 		 ( "TheDon", 0.1, "TheDon" )
	
		-- Intro to Don
		
	Game.Pause			(2)
	
    Game.AdviserSay         ( "CEO",    "adviser_food_donintro2" )
    Game.AdviserSay         ( "CEO",    "adviser_food_donintro3" )

    
		-- Request objectives
    	
	Game.CamMove			( 41, 44, 111, 88, 3, true )

	Food_FinishMedicalWard      ()
    Food_ClearArea              ()
	Food_DismissFiremen			()
    Food_PalermoToMedical       ()
    
	Game.HidePolaroid           ( "Rescue" )

    Trigger.Create              ( "Food_LaunchPartTwo" )
	Trigger.RequireObjective	( "Food_DismissAllFiremen" )
	Trigger.RequireObjective	( "Food_BuildMedicalWard_Doctors" )
    Trigger.RequireObjective    ( "Food_ClearArea" )
    
	
	-- Little bit of extra help
	
	Game.AdviserSay 		( "CEO", "adviser_food_todolist1" )
	Game.AdviserSay 		( "CEO", "adviser_food_todolist2" )
    
end


-------------------------------------------------------------------------------
-- Food Objectives after fire is out
-------------------------------------------------------------------------------

function Food_DismissFiremen()

	Game.AdviserSay				( "CEO", "adviser_food_dismissfiremen1" )
		
	Objective.Create 			( "Food_DismissAllFiremen" )
	Objective.RequireObjects	( "Fireman", 1 )
	Objective.Invert			()
	
end


function Food_FinishMedicalWard()
    
    Objective.Create            ( "Food_BuildMedicalWard_Doctors" )
    Objective.RequireObjects 	( "Doctor", 2 )
    
end


function Food_PalermoToMedical()

    Game.Pickup             ( "Wiggins", "TheDon" )
    Game.SendEntityToPos    ( "Wiggins", 32, 102, 1, 0, 0.4 )
    Game.SendEntityToPos    ( "DonRescuer2", 117, 69, 1, 0, 0.5 )
    
    -- Hidden trigger to tell us when he arrives

    Objective.Create                ( "Food_PalermoInMedical" )
    Objective.TargetZone            ( 31, 102, 35, 104 )
    Objective.RequireNamedObject    ( "TheDon" )
    Objective.SetFlags              ( true, true )
    
    Trigger.Create                  ( "Food_PalermoReachesMedical" )
    Trigger.RequireObjective        ( "Food_PalermoInMedical" )

end


function Food_PalermoReachesMedical()

    Game.Drop               ( "Wiggins" )	
    Game.SendEntityToPos    ( "Wiggins", 28, 100, 1, 0, 0.3 ) 
	
    Game.Remove             ( "BedBlocker1" )
	Game.LoadObjectInto		( "TheDon", "Bed1", 0 )
		
end



-------------------------------------------------------------------------------
-- Clear Area
-- Build a garbage zone
-------------------------------------------------------------------------------

function Food_ClearArea()
	
	-- Clear burnt wreckage
	
	Objective.Create		( "Food_ClearArea" )
	
    Objective.Create            ( "Food_ClearKitchen" )
	Objective.SetParent			( "Food_ClearArea" )
    Objective.TargetZone        ( 49, 60, 66, 74 )
    Objective.RequireFlag  		( "Indoor", false, 100 )

	Objective.Create        	( "Food_ClearCanteen" )
	Objective.SetParent			( "Food_ClearArea" )
    Objective.TargetZone        ( 68, 50, 96, 71 )
    Objective.RequireFlag 		( "Indoor", false, 100 )

	Game.CamMove			( 41, 44, 111, 88, 0, false )
	Game.CamMove			( 22, 44, 91, 88, 15, false )
	
    Game.StopSkipping       ()
	Game.AdviserSay			( "CEO", "adviser_food_afterfire3" )
	Game.AdviserSay			( "CEO", "adviser_food_afterfire4" )
		
	
	-- Garbage zone

    Objective.Create		( "Food_BuildGarbageArea" )
	Objective.SetParent		( "Food_ClearArea" )
	Objective.TargetZone    ( 127, 75, 136, 85 )
    Objective.RequireRoom   ( "Garbage", true )

	Game.CamMoveAndZoom		( 102, 60, 158, 95, 3, 3, true )	
	Game.AdviserSay			( "CEO", "adviser_food_afterfire6" )

	
	-- Hire more workmen
	
	Objective.Create 		( "Food_HireMoreWorkmen" )
	Objective.SetParent 	( "Food_ClearArea" )
	Objective.SetFlags 		( true, false )
	Objective.RequireObjects ( "Workman", 30 )
    
    Food_GameSpeedTrigger()

end


function Food_GameSpeedTrigger()
    
    Objective.Create            ( "Food_BulldozeCanteenGameSpeed" )
    Objective.SetFlags          ( true, true )
    Objective.TargetZone        ( 68, 50, 96, 71 )
    Objective.RequireFlag       ( "Indoor", false, 16 )
    
    Trigger.Create              ( "Food_GameSpeed" )
    Trigger.RequireObjective    ( "Food_BulldozeCanteenGameSpeed" )

end

function Food_GameSpeed()

    local gameSpeed = Game.GetGameSpeed()
    
    if gameSpeed < 2 then
        Game.AdviserIncoming        ( "CEO" )
        Game.CamMove                ( 41, 44, 111, 88, 2, false )
        Game.AdviserSay             ( "CEO", "adviser_food_gamespeed" )
    end

end

-------------------------------------------------------------------------------
-- Launch Part Two
-- Medical bay + clearance of wreckage is done.
-- Secure the prison by deploying guards
-------------------------------------------------------------------------------

function Food_LaunchPartTwo()
	
	Game.AdviserIncoming	( "CEO" )
	Game.AdviserSay 		( "CEO", "adviser_food_familyvisit1" )
	Game.AdviserSay 		( "CEO", "adviser_food_familyvisit2" )
	
    Food_FamilyVisitDonInWard2()

    Game.StopSkipping()
	Food_Deployment()

	Game.Pause 				(1)
	Game.AdviserSay			( "CEO", "adviser_food_todolist2" )
	
end


function Food_Deployment()

    Game.CamMove            ( -27, 9, 158, 125, 2, true )

    Game.AdviserSay         ( "CEO", "adviser_food_troublesoon1" )
    Game.AdviserSay         ( "CEO", "adviser_food_troublesoon2" )
    
    Game.Show               ( "Deployment" )
    Game.AdviserSay         ( "CEO", "adviser_food_troublesoon3" )
    Game.AdviserSay         ( "CEO", "adviser_food_troublesoon4" )
    Game.AdviserSay         ( "CEO", "adviser_food_troublesoon5" )
    Game.Hide               ( "Deployment" )
    	
    Objective.Create        ( "Food_DeployGuards" )
    Objective.Requires      ( "StationedGuards", "AtLeast", 10 )
    
    Objective.Create        ( "Food_DeployPatrol" )
    Objective.Requires      ( "PatrolGuardsInnerCourtFoodCampaign", "AtLeast", 2 )
    
    Trigger.Create              ( "Food_DeploymentDone" )
    Trigger.RequireObjective    ( "Food_DeployGuards" )
    Trigger.RequireObjective    ( "Food_DeployPatrol" )
	
end


function Food_DeploymentDone()

	Game.Hide( "Deployment" )
	
    Food_BuildKitchenAndCanteen();

end


-------------------------------------------------------------------------------
-- Build Kitchen and Canteen
-------------------------------------------------------------------------------

function Food_BuildKitchenAndCanteen()
			
    Game.CamMove            ( 0, 0, 150, 100, 2, true )
    
    Game.AdviserSay         ( "CEO", "adviser_food_rebuild1" )
    Game.AdviserSay         ( "CEO", "adviser_food_rebuild2" )
    Game.AdviserSay         ( "CEO", "adviser_food_rebuild3" )
	Game.AdviserSay         ( "CEO", "adviser_food_rebuild4" )
    Game.AdviserSay         ( "CEO", "adviser_food_rebuild5" )

		-- Kitchen objectives
		
	Objective.Create		( "Food_BuildKitchen" )
	Objective.RequireRoom	( "Kitchen", false )
 
	Objective.Create				( "Food_BuildKitchenCookers" )
	Objective.RequireObjectsInRoom	( "Food_BuildKitchen", "Cooker", 4 )
	Objective.SetParent				( "Food_BuildKitchen" )
	
	Objective.Create				( "Food_BuildKitchenFridges" )
	Objective.RequireObjectsInRoom	( "Food_BuildKitchen", "Fridge", 4 )	
	Objective.SetParent				( "Food_BuildKitchen" )

	Objective.Create				( "Food_BuildKitchenSink" )
	Objective.RequireObjectsInRoom	( "Food_BuildKitchen", "Sink", 1 )
	Objective.SetParent				( "Food_BuildKitchen" )

	Objective.Create 				( "Food_BuildKitchenBin" )
	Objective.RequireObjectsInRoom  ( "Food_BuildKitchen", "Bin", 1 )
	Objective.SetParent				( "Food_BuildKitchen" )

    Objective.Create                ( "Food_BuildKitchenFloor" )
    Objective.SetParent             ( "Food_BuildKitchen" )
	Objective.TargetRoom            ( "Food_BuildKitchen" )
    Objective.SetFlags              ( true, false )
    Objective.RequireMaterials      ( "ConcreteFloor", 70 )
    Objective.Invert                ()
    
    Objective.Create                ( "Food_BuildKitchenFloor_Hidden" )
    Objective.SetParent             ( "Food_BuildKitchenFloor" )
    Objective.SetFlags              ( false, true )
    Objective.RequireNamedRoom      ( "Food_BuildKitchen" )
	
    Objective.Create            	( "Food_BuildKitchenWaterMains" )
    Objective.SetParent         	( "Food_BuildKitchen" )	
	Objective.TargetRoom            ( "Food_BuildKitchen" )
    Objective.RequireFlag       	( "Watered", true, 100 )
	
    Objective.Create                ( "Food_HireChefs" )
	Objective.RequireObjects        ( "Cook", 8 )
	Objective.SetParent 			( "Food_BuildKitchen" )
	
    
		-- Canteen objectives
		
	Objective.Create		( "Food_BuildCanteen" )
	Objective.RequireRoom	( "Canteen", false ) 

	Objective.Create				( "Food_BuildServingTables" )
	Objective.RequireObjectsInRoom	( "Food_BuildCanteen", "ServingTable", 2 )	
	Objective.SetParent				( "Food_BuildCanteen" )

	Objective.Create				( "Food_BuildCanteenTables" )
	Objective.RequireObjectsInRoom	( "Food_BuildCanteen", "Table", 6 )
	Objective.SetParent				( "Food_BuildCanteen" )
	
	Objective.Create				( "Food_BuildCanteenChairs" )
	Objective.RequireObjectsInRoom	( "Food_BuildCanteen", "Bench", 12 )	
	Objective.SetParent				( "Food_BuildCanteen" )
    
	Objective.Create 				( "Food_BuildCanteenBin" )
	Objective.RequireObjectsInRoom  ( "Food_BuildCanteen", "Bin", 1 )
	Objective.SetParent				( "Food_BuildCanteen" )
	
    Objective.Create                ( "Food_BuildCanteenFloor" )
    Objective.SetParent             ( "Food_BuildCanteen" )
	Objective.TargetRoom            ( "Food_BuildCanteen" )
    Objective.SetFlags              ( true, false )
    Objective.RequireMaterials      ( "ConcreteFloor", 70 )
    Objective.Invert                ()
	
    Objective.Create                ( "Food_BuildCanteenFloor_Hidden" )
    Objective.SetParent             ( "Food_BuildCanteenFloor" )
    Objective.SetFlags              ( false, true )
    Objective.RequireNamedRoom      ( "Food_BuildCanteen" )

    --Objective.Create                ( "Food_CookMeals" )
    --Objective.RequireObjects        ( "IngredientsCooked", 100 )
	--Objective.SetParent				( "Food_BuildCanteen" )
	
	Trigger.Create				( "Food_KitchenAndCanteenFinished" )
    Trigger.RequireObjective    ( "Food_BuildCanteen" )
    Trigger.RequireObjective    ( "Food_BuildServingTables" )
    Trigger.RequireObjective    ( "Food_BuildCanteenTables" )
    Trigger.RequireObjective    ( "Food_BuildCanteenChairs" )
	Trigger.RequireObjective    ( "Food_BuildCanteenBin" )
    Trigger.RequireObjective    ( "Food_BuildKitchen" )
    Trigger.RequireObjective    ( "Food_BuildKitchenCookers" )
    Trigger.RequireObjective    ( "Food_BuildKitchenFridges" )
    Trigger.RequireObjective    ( "Food_BuildKitchenSink" )
	Trigger.RequireObjective    ( "Food_BuildKitchenBin" )
	Trigger.RequireObjective 	( "Food_BuildKitchenWaterMains" )
    Trigger.RequireObjective    ( "Food_HireChefs" )
   
end


-- Player has just finished building kitchen and canteen
-- Find drugs stashed away

function Food_KitchenAndCanteenFinished()

    Objective.Delete( "Food_BuildKitchenFloor_Hidden" )
    Objective.Delete( "Food_BuildCanteenFloor_Hidden" )

	Food_DrugsFound()			-- Leads to mafia flashback scene
	
	Game.Pause 				(1)
	Game.CamZoom            ( 5, 2, true )
	
    Game.StopSkipping()
    Food_BuildSprinklerSystem()
    Food_ExplainNeedsSystem()
	
end


-- Explain the needs system to the player,
-- Show him the needs report etc 
-- Give optional objectives to take care of all the needs of the prisoners 

function Food_ExplainNeedsSystem()

    Game.CamMove            ( 0, 0, 150, 100, 2, true )
    
    Game.IncreaseNeeds      ( "Recreation", 15 )
    Game.IncreaseNeeds      ( "Environment", 15 )

	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds1" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds2" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds3" )
	
	Game.Unlock         	( "Reports" )
	Game.Show 				( "Interface" )
	Game.Show 				( "Needs" )
	
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds4" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds5" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds6" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds7" )
	Game.AdviserSay 		( "CEO", "adviser_food_explainneeds8" )
	
	Objective.Create 		( "Food_Needs" )
	
	Objective.Create 		( "Food_HandleFoodNeed" )	
	Objective.SetParent		( "Food_Needs" )
	Objective.Requires 		( "NeedDischarged", "Food", 75 )
	
	Objective.Create 		( "Food_HandleBoredomNeed" )
	Objective.SetParent 	( "Food_Needs" )
	Objective.Requires 		( "NeedDischarged", "Recreation", 60 )
	
	Objective.Create 		( "Food_HandleEnvironmentNeed" )
	Objective.SetParent 	( "Food_Needs" )
	Objective.Requires 		( "NeedDischarged", "Environment", 70 )
	
	Game.Hide 				( "Interface" )

	Trigger.Create 				( "Food_BuildLaundry" )
	Trigger.RequireObjective 	( "Food_Needs" )
	
end 


function Food_BuildLaundry()

	Game.AdviserIncoming 	( "CEO" )
	Game.AdviserSay 		( "CEO", "adviser_food_needssuccess1" )
	
	Game.Show 				( "Interface" )
	Game.Show 				( "Needs" )

	Game.AdviserSay 		( "CEO", "adviser_food_needssuccess2" )
	Game.AdviserSay 		( "CEO", "adviser_food_needssuccess3" )
	Game.AdviserSay 		( "CEO", "adviser_food_needssuccess4" )

	Objective.Create 		( "Food_Laundry" )
	
	Objective.Create 		( "Food_BuildLaundry" )
	Objective.SetParent 	( "Food_Laundry" )
	Objective.RequireRoom	( "Laundry", true )

    Objective.Create        ( "food_hirejanitors" )
    Objective.SetParent     ( "Food_Laundry" )
    Objective.RequireObjects ( "Janitor", 10 )

	Objective.Create 		( "Food_HandleClothingNeed" )
	Objective.SetParent 	( "Food_Laundry" )
	Objective.Requires 		( "NeedDischarged", "Clothing", 80 )

	Game.Hide 				( "Interface" )

	Trigger.Create 				( "Food_LaundryDone" )
	Trigger.RequireObjective 	( "Food_Laundry" )
	
end 


function Food_LaundryDone()
	-- End of quest chain
end 


function Food_BuildSprinklerSystem()
 
        -- Sprinkler system
        
	Game.AdviserSay 			( "CEO", "adviser_food_sprinklerintro1" )
	Game.AdviserSay 			( "CEO", "adviser_food_sprinklerintro2" )
	Game.AdviserSay 			( "CEO", "adviser_food_sprinklers1" )
	Game.AdviserSay 			( "CEO", "adviser_food_sprinklers2" )
	
	Game.Show 					( "Interface" )

    Objective.Create            ( "Food_BuildSprinklers" )
    
    Objective.Create            	( "Food_BuildSprinklers1" )
    Objective.SetParent         	( "Food_BuildSprinklers" )
    Objective.RequireObjectsInRoom	( "Food_BuildKitchen", "Sprinkler", 2 )
    
    Objective.Create            	( "Food_BuildSprinklers2" )
    Objective.SetParent         	( "Food_BuildSprinklers" )
    Objective.RequireObjectsInRoom	( "Food_BuildCanteen", "Sprinkler", 2 )
    
    Objective.Create                ( "Food_ConnectWater" )
    Objective.SetParent             ( "Food_BuildSprinklers" )
    Objective.TargetRoom            ( "Food_BuildKitchen" )
    Objective.RequireFlag           ( "Watered", true, 100 )
    Objective.ShowCompletionProgress( false )
    
    Objective.Create                ( "Food_ConnectWater_Hidden" )
    Objective.SetParent             ( "Food_ConnectWater" )
    Objective.SetFlags              ( false, true )
    Objective.RequireObjectsInRoom  ( "Food_BuildKitchen", "Sprinkler", 2 )
    
    Objective.Create                ( "Food_ConnectWater2" )
    Objective.SetParent             ( "Food_BuildSprinklers" )
    Objective.TargetRoom            ( "Food_BuildCanteen" )
    Objective.RequireFlag           ( "Watered", true, 100 )
    Objective.ShowCompletionProgress( false )

    Objective.Create                ( "Food_ConnectWater2_Hidden" )
    Objective.SetParent             ( "Food_ConnectWater2" )
    Objective.SetFlags              ( false, true )
    Objective.RequireObjectsInRoom  ( "Food_BuildCanteen", "Sprinkler", 2 )

	Trigger.Create 				( "Food_SprinklersDone" )
	Trigger.RequireObjective 	( "Food_BuildSprinklers" )
		
end



-- Fight scene in shower
-- Run next round of objectives - sprinklers, feeding everyone, finding drugs

function Food_SprinklersDone()

    Objective.Delete    ( "Food_ConnectWater_Hidden" )
    Objective.Delete    ( "Food_ConnectWater2_Hidden" )

	Game.AdviserIncoming( "CEO" )
	
    Game.AdviserSay     ( "CEO", "cutscene_food_feudintro1" )
    Game.AdviserSay     ( "CEO", "cutscene_food_feudintro2" )
	Game.AdviserSay     ( "CEO", "cutscene_food_feudintro3" )

	Game.PolaroidTrigger 	( "campaign/food/ill_mafia_8.png", 39, 24, "Food_TriggerFightScene" )

	Objective.Create 		( "Food_TriggerFightScene" )
	Objective.Requires 		( "Nothing", "", 0 )
	
end 


function Food_TriggerFightScene()	
	
	Objective.Delete 	( "Food_TriggerFightScene" )
		
	Food_RunFight()
		
		-- We are focussed on Nico now 

	Game.AdviserSay 	( "CEO", "adviser_food_fightoutro1" )
    Game.CamZoom            ( 5, 2, true )

    Game.StopSkipping()

    Game.SetZoneBlocked( 4, false )   -- Sonny/Nico Cells
	Food_SearchForContraband()
		
end


function Food_RunFight()
	
	Game.FadeToBlack 	(1,true)
	Game.Pause (1)

	Food_FamilyFeud()

        -- Put Nico in the infirmary
		
    Game.SetSprite          ( "Nico", "NicoHospital" )
    Game.Damage             ( "Nico", -0.25, "Nico" )
    Game.SendEntityToObject ( "Nico", "NicoPos", -1, 0, -1 )
	Game.CamTrack 			( "Nico", 0.007 )
	Game.Pause (1)
    Game.FadeUp             (1,true)
	
	Game.Pause 	(2)

end



function Food_AllObjectivesComplete()
	
	Game.AdviserIncoming	( "CEO" )
	Game.AdviserSay 		( "CEO", "cutscene_food_successionintro" )
	Game.AdviserSay 		( "CEO", "cutscene_food_successionintro2" )
	Game.AdviserSay 		( "CEO", "cutscene_food_successionintro3" )
	
	Game.PolaroidTrigger 	( "campaign/food/ill_mafia_donunconcious.png", 33.5, 107, "Food_RunEnding" )

	Objective.Create 		( "Food_RunEnding" )
	Objective.Requires 		( "Nothing", "", 0 )
		
end 


function Food_RunEnding()
		
	Food_SuccessionEnding()

	Game.UnlockCollectable( "Riot" )	

	Game.Hide ( "WorldSounds" )

	Game.Pause(3)
    Game.SetCampaignChapter( "Riot" )

end

