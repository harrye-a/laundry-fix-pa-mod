
-------------------------------------------------------------------------------
-- Dump Rotten Food
-- This uncoveres the smuggled drugs and begins the contraband subplot
-------------------------------------------------------------------------------

function Food_DumpRottenFood()

	Game.CamMoveAndZoom		( 98, 37, 125, 54, 2, 3, true )
	Game.AdviserSay 		( "CEO", "adviser_food_troublesoon6" )

	Objective.Create 		( "Food_DumpFood" )
	Objective.RequireObjects( "IngredientsSpoiled", 1 )
	Objective.Invert 		()
	
	Trigger.Create 				( "Food_DrugsFound" )
	Trigger.RequireObjective	( "Food_DumpFood" )

end


-------------------------------------------------------------------------------
-- Drugs found in food boxes
-- Show the palermo mafia house flashback
-------------------------------------------------------------------------------

function Food_DrugsFound()

	Game.AdviserIncoming	( "CEO" )	
	Game.AdviserSay			( "CEO", "adviser_food_founddrugs1" )
	
	Game.CamMoveAndZoom		( 98, 37, 125, 54, 2, 3, true )
	
	Game.Polaroid       	( "DrugsFound", "campaign/food/ill_mafia_crate.png", 108, 44, 7, 7 )
	Game.Pause				(2)
	
	Game.AdviserSay			( "CEO", "adviser_food_founddrugs2" )	
	Game.AdviserSay			( "CEO", "adviser_food_founddrugs3" )	
	Game.AdviserSay			( "CEO", "adviser_food_founddrugs4" )


	-- Palermo family flashback 
    Game.BeginSkippable()
    
	Game.FadeToBlack( 1, true )
	Game.SaveMap( "food-family" )
	
	Food_MafiaHouseScene()
	
	Game.FadeToBlack( 1, true )
	Game.SetMap( "food-family" )
    
    Game.EndSkippable()
    Game.HidePolaroid       ( "DrugsFound" )
    
	Game.CamTrack   ( "TheDon", 0.004 )
	Game.FadeUp( 1, false )
	
end


-------------------------------------------------------------------------------
-- Ask the player to search for more drugs around the prison
-------------------------------------------------------------------------------

function Food_SearchForContraband()
	
	Game.Unlock         ( "Reports" )
	
	-- Give drugs + withdrawal to all addicted people

	for i = 1, 6 do
		local addictName = "Addict" .. i
		Game.GiveContraband( addictName, "Drugs" )
		Game.GiveStatusEffect( addictName, "withdrawal", 1 )
	end

    for i = 1, 7 do
		local addictName = "Alcoholic" .. i
		Game.GiveContraband( addictName, "Booze" )
		Game.GiveStatusEffect( addictName, "withdrawal", 1 )
	end

	-- Ask the player to search for all drugs

	Game.AdviserSay 		( "CEO", "adviser_food_findalldrugs2" )
	Game.AdviserSay 		( "CEO", "adviser_food_findalldrugs3" )
	Game.AdviserSay 		( "CEO", "adviser_food_findalldrugs4" )
	
    Game.ClearIntelHistory  ()
    
	Objective.Create 		( "Food_FindAllDrugs" )
	Objective.Requires      ( "ContrabandFound", "Narcotics", 3 )						-- There are 6 drugs spawned, but some may get taken by the addicts

	Objective.Create 		( "Food_HireMoreGuards" )
	Objective.RequireObjects( "Guard", 30 )
	Objective.SetFlags		( true, false )
	Objective.SetParent		( "Food_FindAllDrugs" )
	
	Trigger.Create 			( "Food_FoundMoreDrugs" )
	Trigger.RequireObjective( "Food_FindAllDrugs" )

end


-------------------------------------------------------------------------------
-- More drugs found, and addicts as well
-- Ask the player to setup rehab facilities for drug addicts
-------------------------------------------------------------------------------

function Food_FoundMoreDrugs()

	Game.AdviserIncoming	( "CEO" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound1" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound2" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound2b" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound3" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound4" )
	Game.AdviserSay			( "CEO", "adviser_food_drugsfound5" )
	Game.AdviserSay			( "CEO", "adviser_food_todolist2" )
	
	
	-- Alcoholics

	Objective.Create 		( "Food_AlcoholProgram" )
	Objective.Requires 		( "ReformRunning", "AlcoholicsMeeting", 1 )

	Objective.Create 		( "Food_BuildCommonRoom" )
	Objective.SetParent 	( "Food_AlcoholProgram" )
	Objective.RequireRoom	( "CommonRoom", true )
 
	Objective.Create				( "Food_BuildCommonRoomChairs" )
	Objective.RequireObjectsInRoom	( "Food_BuildCommonRoom", "Chair", 8 )
	Objective.SetParent				( "Food_AlcoholProgram" )
	
	Objective.Create 		( "Food_HelpAlcoholics" )
	Objective.Requires 		( "NeedDischarged", "Alcohol", 70 )
	Objective.ShowCompletionProgress( false )
	

	-- Drugs

	Objective.Create 		( "Food_DrugTreatment" )
	Objective.Requires 		( "ReformRunning", "Methadone", 1 )

	Objective.Create 		( "Food_CureAddictions" )	
	Objective.Requires 		( "NeedDischarged", "Drugs", 70 )
	Objective.ShowCompletionProgress( false )

	
	Trigger.Create 				( "Food_AllObjectivesComplete" )
	Trigger.RequireObjective    ( "Food_AlcoholProgram" )
    Trigger.RequireObjective    ( "Food_DrugTreatment" )
		
    Trigger.Create              ( "Food_HelpAlcoholics_Done" )
    Trigger.RequireObjective    ( "Food_HelpAlcoholics" )
    Trigger.PreserveObjectives  ()

    Trigger.Create              ( "Food_CureAddictions_Done" )
    Trigger.RequireObjective    ( "Food_CureAddictions" )
    Trigger.PreserveObjectives  ()

end


function Food_HelpAlcoholics_Done()

    Objective.Clear( "Food_HelpAlcoholics" )
    
end 


function Food_CureAddictions_Done()

    Objective.Clear( "Food_CureAddictions" )
    
end 

