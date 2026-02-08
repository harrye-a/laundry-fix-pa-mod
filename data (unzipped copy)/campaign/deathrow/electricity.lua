

-------------------------------------------------------------------------------
-- DeathRow_AddElectricity
-- Runs when all starting objectives have been completed
-- Shows you the electrical system, asks you to connect the dark cells up
-------------------------------------------------------------------------------

function DeathRow_AddElectricity()   

    -- Allow the Utilities areas to be edited, except for the power station (zone 4)
    Game.SetZoneBlocked( 2, false )
    Game.SetZoneBlocked( 3, false )

    Game.AdviserIncoming	( "Ceo" )

    Game.CamMove            ( 3, 32, 33, 50, 10, false )
    Game.AdviserSayBatch    ( "Ceo", "adviser_deathrowelectricity" )      

    Game.Unlock             ( "Electricity" )
	    
    Game.Show               ( "Utilities" )   
    Game.CamMove            ( 0, 0, 110, 80, 3, true )
	Game.Pause				( 3 )
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_1" )      
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_2" )      
		
    Game.CamMove            ( 69, 17, 93, 32, 3, true )
    Game.CamZoom            ( 1.5, 10.0, false )
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_3" )      

    Game.Hide				( "Utilities" )   
	Game.Pause				( 1 )	
    Game.CamMoveAndZoom     ( 13, 9, 34, 23, 3.0, 5, true )
    Game.CamZoom            ( 1.5, 10.0, false )
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_4" )      
	Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_4b" )

    Game.Show               ( "Utilities" )   
	Game.CamMove			( 6, 3, 56, 34, 3, true )
	Game.Pause				( 1 )	
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_5" )      
    Game.AdviserSay         ( "Ceo", "adviser_deathrowelectricityb_6" )      
	
	Objective.Create		( "DeathRow_CellPower" )
	Objective.TargetZone	( 19, 8, 21, 10 )
	Objective.RequireFlag	( "Powered", true, 90 )

	Objective.Create		( "DeathRow_CellPower" )
	Objective.TargetZone	( 19, 15, 21, 16 )
	Objective.RequireFlag	( "Powered", true, 90 )

	Objective.Create		( "DeathRow_CellPower" )
	Objective.TargetZone	( 19, 18, 21, 19 )
	Objective.RequireFlag	( "Powered", true, 90 )

	Objective.Create		( "DeathRow_CellPower" )
	Objective.TargetZone	( 19, 21, 21, 22 )
	Objective.RequireFlag	( "Powered", true, 90 )

	Objective.Create		( "DeathRow_CellPower" )
	Objective.TargetZone	( 19, 24, 21, 27 )
	Objective.RequireFlag	( "Powered", true, 90 )

    Trigger.Create              ( "DeathRow_ConnectChair" )
    Trigger.RequireObjective    ( "DeathRow_CellPower" );
	
	Game.Hide               ( "Utilities" )   
end


-------------------------------------------------------------------------------
-- DeathRow_ConnectChair
-- The player has just finished wiring up the new wing of cells
-- Now wire up the electric chair and new cell
-------------------------------------------------------------------------------

function DeathRow_ConnectChair()

	--D11.LJ #PA-8701 Allow the outdoors area to be edited and built on for the Electrical cables and lights. Was BLOCKING campaign progress
	Game.SetZoneBlocked( 1, false )		

    Game.AdviserIncoming	( "Ceo" )
	Game.PowerOff			( "DeathRow_ExecutionObjects_ElectricChair" )
	
    Game.CamMove            ( 1, 30, 35, 51, 2, true )
    Game.CamZoom            ( 1.5, 10, false )

    Game.AdviserSay		    ( "Ceo", "adviser_deathrow_connectchair_1" )
	Game.AdviserSay		    ( "Ceo", "adviser_deathrow_connectchair_2" )
	
	Game.CamMove			( 12, 34, 24, 42, 2, true )
	Game.AdviserSay		    ( "Ceo", "adviser_deathrow_connectchair_3" )

    Objective.Create            ( "Deathrow_Chairpower" )
    Objective.TargetZone        ( 13, 35, 22, 41 )
    Objective.RequireFlag       ( "Powered", true, 90 )
    Objective.ShowCompletionProgress( false )
    
    Objective.Create            ( "Deathrow_DirectChairPower" )
    Objective.RequireObjectPower( "DeathRow_ExecutionObjects_ElectricChair" )
    Objective.SetFlags          ( false, true )
    Objective.SetParent         ( "Deathrow_Chairpower" )
    
	Objective.Create			( "Deathrow_CondemnedCellPower" )
	Objective.TargetZone		( 13, 43, 15, 46 )
	Objective.RequireFlag		( "Powered", true, 90 )
    Objective.ShowCompletionProgress( false )
    
    Trigger.Create              ( "DeathRow_TestChair" )
    Trigger.RequireObjective    ( "Deathrow_Chairpower" )    
	Trigger.RequireObjective	( "Deathrow_CondemnedCellPower" )
	
end



-------------------------------------------------------------------------------
-- DeathRow_TestChair
-- Runs when the electric chair is successfully wired up to the mains
-- Turns on the chair, shorts out the power to the prison.  Asks you to fix.
-------------------------------------------------------------------------------

function DeathRow_TestChair()
    	
    Game.AdviserIncoming	( "Ceo" )
	Game.PowerOff			( "DeathRow_ExecutionObjects_ElectricChair" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_testchair_1" )
	Game.CamMove            ( 11, 33, 25, 42, 0, true )
	Game.Show               ( "Utilities" )   
	Game.AdviserSay			( "Ceo", "adviser_deathrow_testchair_2" )
	
	Game.PowerOn			( "DeathRow_ExecutionObjects_ElectricChair" )
	Game.CamMove            ( 0, 0, 110, 80, 5, true )
	Game.Pause				( 4 )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_testchair_3" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_testchair_4" )
		
	Game.CamMove            ( 71, 16, 95, 31, 3, true )
	
	Game.PowerOff			( "DeathRow_ExecutionObjects_ElectricChair" )
	Game.PowerOff			( "DeathRow_PowerStation" )
	
	Objective.Create				( "DeathRow_PowerOn" )
	Objective.RequireObjectOn		( "DeathRow_PowerStation" );
	Game.AdviserSay					( "Ceo", "adviser_deathrow_testchair_5" )
	Game.AdviserSay					( "Ceo", "adviser_deathrow_testchair_5b" )

	Objective.Create				( "DeathRow_ExpandPower" )
	Objective.TargetZone			( 81, 21, 81, 23 )
	Objective.RequireObjects		( "Capacitor", 3 )
	Game.AdviserSay					( "Ceo", "adviser_deathrow_testchair_6" )
	
	Objective.Create				( "DeathRow_ChairWorking" )
	Objective.RequireObjectOn		( "DeathRow_ExecutionObjects_ElectricChair" )
	Game.AdviserSay					( "Ceo", "adviser_deathrow_testchair_7" )

    -- Allow the power station to be edited now.
	-- D11.AParcell #4149 we do not want the generator to be able to be dismantled at any point
    -- Game.SetZoneBlocked( 4, false )

    Trigger.Create					( "DeathRow_AllDone" )
	Trigger.RequireObjective		( "DeathRow_PowerOn" )
	Trigger.RequireObjective		( "DeathRow_ExpandPower" )
	Trigger.RequireObjective		( "DeathRow_ChairWorking" )
    
    Game.Hide                       ( "Utilities" )
	
end



function DeathRow_AllDone()

	Game.AdviserIncoming	( "Ceo" )
	
	Game.PowerOff			( "DeathRow_ExecutionObjects_ElectricChair" )
	Game.Hide				( "Utilities" )
	
	Game.AdviserSay			( "Ceo", "adviser_deathrow_execution_1" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_execution_2" )
	Game.AdviserSay			( "Ceo", "adviser_deathrow_execution_3" )
	
	Game.FadeToBlack		( 1, true )
	
	DeathRow_SetupConfessionAndExecution()

    -- Make sure that when skipping the screen goes to black before the next map


    Game.StopSkipping       ()
    Game.FadeToBlack        ( 0, false )


    Game.Pause(1)
    Game.UnlockCollectable( "Food" )
    Game.SetCampaignChapter ( "Food" )
    
end
