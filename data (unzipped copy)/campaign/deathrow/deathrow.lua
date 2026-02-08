

function BeginChapter()
	
    Game.Show( "ObjectiveToolbarHighlights" )
    
    DeathRow_NiceIntroSequence()
    
    --Game.SetMap     ( "deathrow" )
    Game.StopSkipping()
    DeathRow_Intro()	
end


-------------------------------------------------------------------------------
-- Intro Sequence
-------------------------------------------------------------------------------

function DeathRow_NiceIntroSequence()

    Game.Pause          (1)
	
	Game.Show       ( "GameStartLogo" )
	Game.Pause 		( 2 ) 
	
	Game.Pause	 	( 4 )
    Game.Hide       ( "GameStartLogo" )
	
	 -- Company Logo on black
	Game.Sound		( "_Music", "CompanyLogo" )
    Game.Show		( "CompanyLogo" )
    
	Game.SetMap     ( "deathrow" )
	Game.CopyMapZone( "epilogue", 98, 1, 104, 78 )				-- This copies the road from epilogue
																-- I didn't edit the deathrow map directly because it's SOO old
    
    Game.CamMove	( 20, 6, 38, 16, 0, true )
    Game.FadeToBlack(0, false)
    Game.Pause		(3)	
        
    Game.Hide		( "CompanyLogo" )
    Game.Sound		( "_Music", "DeathRowIntro" )   
    
	Game.FadeUp     (3, false)
    
    -- Slow pan over cells
    -- Issue delivery of prisoners
    
	Game.CamMove	( 29, 6, 47, 16, 18, false )
	Game.Pause 		(13)
    
    -- Shower
    
    Game.Spawn      ( "Janitor", "Janitor", 77, 62 )
    Game.Spawn      ( "Janitor", "Janitor", 78, 64 )
	Game.CamMove	( 67, 58, 87, 69, 0, true )
    Game.CamZoom    ( 1.5, 15, false )
	Game.Pause 		(4)
        
    Game.Delivery 	( "Prisoner", 5, "Prisoner" )

    -- Construction work
    
    Game.CamMove    ( 19, 57, 47, 73, 0, true )
    Game.CamMove    ( 28, 57, 57, 73, 20, false )
    Game.Pause      ( 10 )
    
    -- Delivery of prisoners 
    
	Game.CamMove	( 88, 23, 109, 37, 0, true )
	Game.CamMove	( 75, 29, 111, 49, 10, false )
	Game.Pause 		( 11 )
    
    -- Admin offices 
    
	Game.CamMove	( 55, 6, 74, 17, 0, true )
	Game.CamMove	( 63, 6, 82, 17, 13, false )
	Game.Pause 		( 5 )

    -- Garbage loading onto truck
    
    Game.CamMove    ( 88, 53, 105, 63, 0, true )
    Game.CamZoom    ( 1.5, 10, false )
    Game.Pause      ( 5 )

	-- Edward + priest
	
	Game.CamMove	( 53, 62, 68, 72, 0, true )
	Game.CamZoom	( 0.5, 20, false )
	Game.Pause 		( 6 )
	
    -- Game logo over strong pull back to wide shot
    
	Game.CamMove    ( 0, 3, 113, 76, 2, false )
	Game.Show       ( "GameLogo" )
	Game.Pause 		( 2 ) 
	
	Game.Pause	 	( 4 )
    Game.Hide       ( "GameLogo" )
	Game.Pause 		( 5 )
end



-------------------------------------------------------------------------------
-- DeathRow Intro
-- Show the prison, explain the basic objective :
-- Build an execution chamber, and move a prisoner near to it
-------------------------------------------------------------------------------

function DeathRow_Intro()
    Game.SetZoneBlocked( 1, true )   -- Outside area indestructible.
    Game.SetZoneBlocked( 3, true )   -- Utilities area indestructible.
    Game.SetZoneBlocked( 4, true )   -- Powerstation indestructible.

    Game.AdviserIncoming	("Ceo")
	Game.CamMove			( 48, 15, 85, 38, 0, true )
	Game.CamMove			( 48, 24, 85, 46, 30, false )

	Game.AdviserSayBatch    ( "Ceo", "adviser_deathrowintro" )

    Game.CamMove            ( 0, 31, 41, 57, 5, true )
    Game.AdviserSay         ( "Ceo", "adviser_deathrowintrob_1" )
    Game.AdviserSay         ( "Ceo", "adviser_deathrowintrob_2" )
	
	Objective.Create				( "DeathRow_Building" )
	Objective.TargetZone			( 12, 34, 23, 47 )
	Objective.RequireBuilding		( false )
    Objective.SetAnimationTimer     ( -2 )
	Game.AdviserSay         		( "Ceo", "adviser_deathrowintrob_3" )
	
        -- Build jail door entrance
        
    Game.AdviserSay			( "Ceo", "adviser_deathrow_buildinside1" )
    Game.AdviserSay			( "Ceo", "adviser_deathrow_buildinside2" )

	Objective.Create				( "DeathRow_BuildOuterDoor" )
	Objective.TargetZone			( 19, 47, 20, 47 )
	Objective.RequireObjects		( "JailDoorLarge", 1 )

	Trigger.Create			( "DeathRow_BuildInternalWalls" );
	Trigger.RequireObjective( "DeathRow_Building" )
	Trigger.RequireObjective( "DeathRow_BuildOuterDoor" )


		-- Create a trigger to start a cutscene
		-- once building is underway
		
	Objective.Create				( "DeathRow_BuildFoundations" )
	Objective.TargetZone			( 22, 46, 23, 47 )
	Objective.RequireBuilding		( true )
	Objective.SetFlags				( false, true )
	
	Trigger.Create					( "DeathRow_ExplainFoundations" )
	Trigger.RequireObjective		( "DeathRow_BuildFoundations" )
end


function DeathRow_ExplainFoundations()

	Game.AdviserIncoming	( "Ceo" )
	
	Game.CamMove			( 1, 53, 34, 74, 3, true )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_explain1" )
	
	Game.CamMove			( 3, 37, 34, 57, 10, false )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_explain2" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_explain3" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_explain4" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_explain5" )
		
end


function DeathRow_BuildInternalWalls()

	Objective.Create				( "DeathRow_BuildInternalWalls" )
	Objective.TargetZone			( 13, 42, 18, 42 )
	Objective.RequireMaterials		( "BrickWall", 100 )
	
	Objective.Create				( "DeathRow_BuildInternalWalls" )
	Objective.TargetZone			( 21, 42, 22, 42 )
	Objective.RequireMaterials		( "BrickWall", 100 )
	
	Objective.Create				( "DeathRow_BuildInternalWalls" )
	Objective.TargetZone			( 16, 43, 16, 43 )
	Objective.RequireMaterials		( "BrickWall", 100 )

	Objective.Create				( "DeathRow_BuildInternalWalls" )
	Objective.TargetZone			( 16, 46, 16, 46 )
	Objective.RequireMaterials		( "BrickWall", 100 )
	
	Trigger.Create					( "DeathRow_BuildInternalObjects" )
	Trigger.RequireObjective		( "DeathRow_BuildInternalWalls" )

	Game.AdviserSay			( "Ceo", "adviser_deathrow_internalwalls1" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_internalwalls2" )
end


function DeathRow_BuildInternalObjects()

	Objective.Create				( "DeathRow_BuildInternalDoors" )
	Objective.TargetZone			( 19, 42, 20, 42 )
	Objective.RequireObjects		( "JailDoorLarge", 1 )
	
	Objective.Create				( "DeathRow_BuildInternalDoors" )
	Objective.TargetZone			( 16, 44, 16, 45 )
	Objective.RequireObjects		( "JailDoorLarge", 1 )
	
	Trigger.Create					( "DeathRow_BuildRoomDesignations" )
	Trigger.RequireObjective		( "DeathRow_BuildInternalDoors" )
	Trigger.RequireObjective		( "DeathRow_BuildInternalDoors" )

	Game.AdviserSay			( "Ceo", "adviser_deathrow_internaldoors1" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_internaldoors2" )	
end


function DeathRow_BuildRoomDesignations()

	Game.AdviserSay			( "Ceo", "adviser_deathrow_designation1" )

	Objective.Create				( "DeathRow_DesignateCell" )
	Objective.TargetZone			( 13, 43, 15, 46 )
	Objective.RequireRoom			( "Cell", false )
	Objective.RequireRoomFill		( 100 )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_designation2" )
	
	Objective.Create				( "DeathRow_DesignateExecution" )
	Objective.TargetZone			( 13, 35, 22, 41 )
	Objective.RequireRoom			( "Execution", false )
	Objective.RequireRoomFill		( 100 )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_designation3" )
	
	Trigger.Create					( "DeathRow_BuildRoomObjects" )
	Trigger.RequireObjective		( "DeathRow_DesignateCell" )
	Trigger.RequireObjective		( "DeathRow_DesignateExecution" )
end


function DeathRow_BuildRoomObjects()

	Objective.Create				( "DeathRow_CellObjects1" )
	Objective.TargetZone			( 13, 43, 13, 44 )
	Objective.RequireObjects		( "Bed", 1 )

	Objective.Create				( "DeathRow_CellObjects2" )
	Objective.TargetZone			( 13, 46, 13, 46 )
	Objective.RequireObjects		( "Toilet", 1 )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_roomrequirements1" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_roomrequirements2" )
	
	Objective.Create				( "DeathRow_ExecutionObjects" )
	Objective.TargetZone			( 17, 37, 18, 38 )
	Objective.RequireObjects		( "ElectricChair", 1 )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_roomrequirements3" )

	Trigger.Create				( "DeathRow_OptionalImprovements" )
	Trigger.RequireObjective	( "DeathRow_CellObjects1" )
	Trigger.RequireObjective	( "DeathRow_CellObjects2" )
	Trigger.RequireObjective	( "DeathRow_ExecutionObjects" )
    
end


function DeathRow_RequireElectricChair()

    Objective.Create                ( "DeathRow_ElectricChairExistence" )
    Objective.TargetZone            ( 17, 37, 18, 38 )
    Objective.RequireNamedObject    ( "DeathRow_ExecutionObjects_ElectricChair" )
    Objective.Invert                ()
    Objective.SetFlags              ( true, true )

    Trigger.Create                  ( "Deathrow_RemakeElectricChair" )
    Trigger.RequireObjective        ( "DeathRow_ElectricChairExistence" )

end


function Deathrow_RemakeElectricChair()

    -- The chair has been destroyed, require that it be rebuilt by asking
    -- the user to satisfy the deathrow objects objective again.
    Objective.Create                ( "DeathRow_ExecutionObjects" )
    Objective.TargetZone            ( 17, 37, 18, 38 )
    Objective.RequireObjects        ( "ElectricChair", 1 )
    
    Trigger.Create                  ( "DeathRow_RequireElectricChair" )
    Trigger.RequireObjective        ( "DeathRow_ExecutionObjects" )

end


function DeathRow_OptionalImprovements()
	
	--D11.LJ #PA-8701 Allow the outdoors area to be edited and built on for lights improvemnet. Was preventing optional success
	Game.SetZoneBlocked( 1, false )		
	
    Game.Rename                 ( "DeathRow_DesignateExecution_ElectricChair", "DeathRow_ExecutionObjects_ElectricChair" )
    DeathRow_RequireElectricChair()

	Game.AdviserIncoming		( "Ceo" )
	Game.AdviserSay				( "Ceo", "adviser_deathrow_optional1" )
	Game.AdviserSay				( "Ceo", "adviser_deathrow_optional2" )
	
	Game.CamMove				( 7, 40, 24, 51, 2, true )
	Game.CamZoom				( 1.2, 10, false )
	
	Game.AdviserSay				( "Ceo", "adviser_deathrow_optional3" )
	
	Game.CamMove				( 4, 32, 33, 50, 2, true )
	Game.CamZoom				( 1.2, 10, false )
	
	Game.AdviserSay				( "Ceo", "adviser_deathrow_optional4" )

	Game.CamMove				( 8, 44, 31, 58, 2, true )
	Game.CamZoom				( 1.2, 10, false )
	
	Game.AdviserSay				( "Ceo", "adviser_deathrow_optional5" )
	
	DeathRow_TransferPrisoner()
	
end


function DeathRow_TransferPrisoner()
	
	Game.PolaroidTrigger			( "campaign/deathrow/genpop.png", 60, 66, "DeathRow_SetupMurder" )

	Objective.Create 			( "DeathRow_TransferInmate" )
	Objective.Requires 			( "Nothing", "", 0 )

	Game.CamMoveAndZoom			( 54, 62, 67, 73, 3.0, 5, true )
	Game.CamZoom				( 0.7, 20, false )
	Game.Pause 				( 4 )
	
	Game.AdviserSay				( "Ceo", "adviser_deathrow_transfer05" )
	Game.AdviserSay				( "Ceo", "adviser_deathrow_transfer06" )
	Game.AdviserSay				( "Ceo", "adviser_deathrow_transfer1" )
	Game.AdviserSay				( "Ceo", "adviser_deathrow_transfer2" )
		
	DeathRow_OptionalImprovementObjectives()
	
end

function DeathRow_OptionalImprovementObjectives()

	Objective.Create			( "DeathRow_Window" )
	Objective.TargetZone		( 12, 43, 15, 47 )
	Objective.RequireObjects	( "Window", 1 )
	Objective.SetFlags			( true, false )
    Objective.SetParent         ( "DeathRow_TransferInmate" )
	
	Objective.Create			( "DeathRow_Bookshelf" )
	Objective.TargetZone		( 13, 43, 15, 46 )
	Objective.RequireObjects	( "Bookshelf", 1  )
	Objective.SetFlags			( true, false )
	Objective.SetParent         ( "DeathRow_TransferInmate" )
    	
	Objective.Create			( "DeathRow_Flooring" )
	Objective.TargetZone		( 13, 35, 22, 46 )
	Objective.RequireMaterials	( "ConcreteFloor", 80 )
	Objective.Invert			()
	Objective.SetFlags			( true, false )
	Objective.SetParent         ( "DeathRow_TransferInmate" )
	
    Game.SetZoneBlocked( 2, false )  -- Make yard area editable.
    Objective.Create			( "DeathRow_Path" )
	Objective.TargetZone		( 18, 48, 25, 53 )
	Objective.RequireMaterials	( "PavingStone", 20 )
	Objective.SetFlags			( true, false )
	Objective.SetParent         ( "DeathRow_TransferInmate" )
			
	Objective.Create			( "DeathRow_OuterLights" )
	Objective.TargetZone		( 10, 47, 25, 52 )
	Objective.RequireObjects	( "Light", 1 )
	Objective.SetFlags			( true, false )
	Objective.SetParent         ( "DeathRow_TransferInmate" )
    	
end
