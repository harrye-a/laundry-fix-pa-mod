
local testMode = false


function BeginChapter()	

    Game.UnlockCollectable( "Conviction" );

    Game.SetMap ( "conviction" )
	Game.FadeToBlack(0,true)

	Game.Unlock ( "Reports" )
    Game.Unlock ( "EmergencyCallouts" )

	Game.SetZoneBlocked( 2, true )
	
	if not testMode then
		
		CutsceneMorgan()
		
		Game.CamZoom ( 3.0, 1, true )
        Game.FadeUp(2)
        
    end

    Conviction_ExpandCapacityTo40()

end


-----------------------------------------------------------------------------------------------------
-- Hurst phones you, explains that we cant have any more suicides
-- We need to focus on the welfare of these men
-- Start by expanding and giving space to everyone and all new arrivals
-----------------------------------------------------------------------------------------------------

function Conviction_ExpandCapacityTo40()

    Game.StopSkipping       ()
	Game.AdviserIncoming 	( "Hurst" )
	
	Game.AdviserSay 		( "Hurst", "conviction_intro_1" )
	Game.AdviserSay 		( "Hurst", "conviction_intro_2" )
    Game.AdviserSay 		( "Hurst", "conviction_intro_3" )
    Game.AdviserSay 		( "Hurst", "conviction_intro_4" )
    Game.AdviserSay 		( "Hurst", "conviction_intro_5" )
	
	Game.CamMoveToObject 	( "NewZoneCam", 5, 1, true )
	Game.CamZoom 			( 0.9, 15, false )
	
	Game.Show 				( "Planning" )
	Game.AdviserSay 		( "Hurst", "conviction_intro_5b" )
	Game.AdviserSay 		( "Hurst", "conviction_intro_5c" )	
    Game.AdviserSay 		( "Hurst", "conviction_intro_6" )
	Game.Hide 				( "Planning" )

	
	Objective.Create 				( "conviction_expandcapacity50" )

	Objective.Create                ( "conviction_expandcapacity_cells" )
    Objective.SetParent             ( "conviction_expandcapacity50" )
	Objective.TargetZone            ( 100, 12, 211, 98 )
    Objective.RequireRoomsAvailable ( "Cell", 40 )

	Objective.Create                ( "conviction_expandcapacity_shower" )
    Objective.SetParent             ( "conviction_expandcapacity50" )
	Objective.TargetZone            ( 100, 12, 211, 98 )
	Objective.SetTargetVisible      ( false )	
    Objective.RequireRoom           ( "Shower", true )
		    
	Objective.Create                ( "conviction_expandcapacity_yard" )
    Objective.SetParent             ( "conviction_expandcapacity50" )
	Objective.TargetZone            ( 100, 12, 211, 98 )
    Objective.SetTargetVisible      ( false )
    Objective.RequireRoom           ( "Yard", true )
	
	Objective.Create                ( "conviction_expandcapacity_intake" )
    Objective.SetParent             ( "conviction_expandcapacity50" )
    Objective.Requires 				( "Prisoners", "AtLeast", 40 )
    Objective.ShowCompletionProgress( false )
		
	Trigger.Create 				( "SectionACompleted" )
	Trigger.RequireObjective	( "conviction_expandcapacity50" )

end 


function SectionACompleted()

    Game.AdviserIncoming    ( "Hurst" )

    CutsceneHurstSecondVisit()

	Game.CamZoom( 3, 1.0, true )
    Game.FadeUp(1)

	Conviction_WorkProgram()

end 


function Conviction_WorkProgram()

    Game.StopSkipping               ()
    Game.AdviserIncoming            ( "Hurst" )
    Game.AdviserSay                 ( "Hurst", "conviction_workintro1" )
    Game.AdviserSay                 ( "Hurst", "conviction_workintro2" )
    Game.AdviserSay                 ( "Hurst", "conviction_workintro3" )
    Game.AdviserSay                 ( "Hurst", "conviction_workintro4" )


	Objective.Create 				( "conviction_workprogram" )
	
	Objective.Create 				( "conviction_unlocklabour" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.Requires 				( "Unlocked", "PrisonLabour", 1 )
	
        -- Takes longer, not included in trigger
        Objective.Create 				( "conviction_work_trainkitchen" )
        Objective.SetParent				( "conviction_workprogram" )
        Objective.Requires 				( "ReformPassed", "KitchenInduction", 5 )
	
	Objective.Create 				( "conviction_work_kitchen" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.Requires 				( "PrisonerJobs", "Kitchen", 3 )

	Objective.Create 				( "conviction_work_workshop" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.RequireRoom			( "Workshop", true )

        -- Takes longer, not included in trigger
        Objective.Create 				( "conviction_work_trainworkshop" )
        Objective.SetParent				( "conviction_workprogram" )
        Objective.Requires 				( "ReformPassed", "WorkshopInduction", 10  )

	Objective.Create 				( "conviction_work_assignworkshop" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.Requires 				( "PrisonerJobs", "Workshop", 3  )
	
	Objective.Create 				( "conviction_work_exportszone" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.RequireRoom			( "Exports", true  )
    
    Objective.Create                ("conviction_work_setintake")
    Objective.SetParent             ("conviction_workprogram")
    Objective.Requires              ( "Intake", "Equal", 10 )
	
	Trigger.Create  			( "WorkProgramCompleted" )
	Trigger.RequireObjective	( "conviction_unlocklabour" )
	Trigger.RequireObjective	( "conviction_work_kitchen" )
	Trigger.RequireObjective	( "conviction_work_workshop" )
	Trigger.RequireObjective	( "conviction_work_assignworkshop" )	
	Trigger.RequireObjective	( "conviction_work_exportszone" )	
    Trigger.RequireObjective    ( "conviction_work_setintake" )
	

		-- These objectives take a lot longer, so are seperate from the trigger

	Objective.Create 				( "conviction_work_produceplates" )
	Objective.SetParent				( "conviction_workprogram" )
	Objective.RequireManufactured   ( "LicensePlate", 100 ) 
	
end 


function WorkProgramCompleted()

	Game.AdviserIncoming ( "Hurst" )
    Game.AdviserSay      ( "Hurst", "conviction_visitationintro_1" )

    if not testMode then
        ConvictionVisitation()
	end

	Game.FadeUp(1)

    Game.AdviserIncoming    ( "Hurst" )
    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_1" )
    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_2" )

    Game.StopSkipping()
	Conviction_ImprovedVisitation()
	Conviction_Education()
	Conviction_ExpandCapacityTo100()


    -- Completing all of those should trigger the end

    Trigger.Create              ( "AllConvictionWorkDone" )
    Trigger.RequireObjective    ( "conviction_visitation" )
    Trigger.RequireObjective    ( "conviction_education" )
    Trigger.RequireObjective    ( "conviction_expandcapacity100" )

end


function Conviction_ImprovedVisitation()

    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_3" )
    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_4" )

	Objective.Create 				( "conviction_visitation" )
	
	Objective.Create 				( "conviction_visitationroom" )
	Objective.SetParent				( "conviction_visitation" )
	Objective.RequireRoom			( "Visitation", true )

	Objective.Create 				( "conviction_visitationcount" )
	Objective.SetParent				( "conviction_visitation" )
	Objective.Requires 				( "TotalVisitCount", "AtLeast", 20 )
		
	Objective.Create 				( "conviction_telephones" )
	Objective.SetParent				( "conviction_visitation" )
	Objective.RequireObjectsInAllRoomsType( "PhoneBooth", "Yard", 5 )
	
	Objective.Create 				( "conviction_mailroom" )
	Objective.SetParent				( "conviction_visitation" )
	Objective.RequireRoom			( "MailRoom", true )
	
	Objective.Create 				( "conviction_mailroomwork" )
	Objective.SetParent				( "conviction_visitation" )
	Objective.Requires 				( "PrisonerJobs", "MailRoom", 3 )
	
end 


function Conviction_Education()

    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_5" )
    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_6" )

	Objective.Create 				( "conviction_education" )
	
	Objective.Create 				( "conviction_unlockeducation" )
	Objective.SetParent				( "conviction_education" )
	Objective.Requires 				( "Unlocked", "Education", 1 )
	
	Objective.Create 				( "conviction_education_classroom" )
	Objective.SetParent				( "conviction_education" )
	Objective.RequireRoom			( "Classroom", true )
	
	Objective.Create 				( "conviction_education_class" )
	Objective.SetParent				( "conviction_education" )
	Objective.Requires			    ( "ReformRunning", "FoundationEducation", 1 )

	Objective.Create 				( "conviction_education_chapel" )
	Objective.SetParent				( "conviction_education" )
	Objective.RequireRoom			( "Chapel", true )

	Objective.Create 				( "conviction_education_spiritual" )
	Objective.SetParent				( "conviction_education" )
	Objective.Requires			    ( "ReformRunning", "SpiritualGuidance", 1 )

	
end 


function Conviction_ExpandCapacityTo100()

    Game.AdviserSay         ( "Hurst", "conviction_helpinmates_7" )

    Objective.Create 				( "conviction_expandcapacity100" )

    Objective.Create                ( "conviction_expandcapacity_cells100" )
    Objective.SetParent             ( "conviction_expandcapacity100" )
    Objective.RequireRoomsAvailable ( "Cell", 80 )

end


-----------------------------------------------------------------------------------------------------
-- Player has completed all build requirements
-- Show closing scene - Morgan decides to live
-- Then leave behind optional objectives that take much longer
-----------------------------------------------------------------------------------------------------


function AllConvictionWorkDone()

    -- Potential suicide of Morgan
	
    ConvictionSuicide()
    
    
    -- Cleanup old visitaion wing
    
    ConvictionCleanupVisitation()
    
    
	-- Fade up on wide shot
	
	Game.CamMoveToObject 			( "cam3", 0, 10, true )
	Game.Pause  (3)
 	Game.FadeUp (3)
		
    Game.AdviserIncoming            ( "Hurst" )
    Game.AdviserSay                 ( "Hurst", "conviction_outro1" )
    Game.AdviserSay                 ( "Hurst", "conviction_outro2" )
    Game.AdviserSay                 ( "Hurst", "conviction_outro3" )


    -- Optional progress objectives

	-- Chris: Removed this objective as it takes FOREVER
    --Objective.Create 				( "conviction_education_learn" )
    --Objective.Requires			    ( "ReformPassed", "FoundationEducation", 5 )
	

    Objective.Create                ( "conviction_expandcapacity_cells200" )
    Objective.RequireRoomsAvailable ( "Cell", 120 )


    -- Polaroid to end the map

    Game.PolaroidTrigger 	( "campaign/conviction/ill_chap3_kerrybabypicture.png", 19, 64, "Conviction_PlayerExitsMap" )

    Objective.Create 		( "Conviction_PlayerExitsMap" )
    Objective.Requires 		( "Nothing", "", 0 )

end


function ConvictionCleanupVisitation()

    Game.Remove             ( "Visitor0" )
    Game.Remove             ( "VisitedPrisoner" )
    Game.Remove             ( "VisitationGuard" )
    Game.Remove             ( "VisitationGuard2" )

    numVisitors = 9
    
    for i = 2, numVisitors do
		visitorName = "Visitor" .. i
		Game.Remove         ( visitorName )
	end 
end

function Conviction_PlayerExitsMap()

	Game.UnlockCollectable( "Epilogue" )

    Game.FadeToBlack		(3,true)
	Game.Hide		( "WorldSounds" )
	Game.Pause 		(3)
	Game.TestAchievement	( "ConvictionOptionals" )
    Game.SetCampaignChapter ( "Epilogue" )

end


-----------------------------------------------------------------------------------------------------
-- Sequence of events and objectives
-----------------------------------------------------------------------------------------------------


--		---------
-- 		SECTION A 
--		---------

-- 		DONE CUTSCENE: Hurst visits Morgan

-- 		Intake is turned on, lots of prisoners due to arrive soon. We need to expand rapidly.
-- 		Need to be able to force control intake from script.
--
-- 		DONE OBJECTIVE: Build a whole new cell block facility
--		--> Leads to SECTION B

--		---------
--		SECTION B
--		---------

--		CUTSCENE: Hurst visits Morgan again. Why are you here Morgan?
-- 		DONE CUTSCENE: Heist 
--		Morgan asks if his wife can at least come and visit, with their baby.

-- 		Start a work program that teaches real world skills. Cooking. Machine work. Carpentry.

--		DONE OBJECTIVE: Train X prisoners to work in the kitchen, then assign them.
-- 		DONE OBJECTIVE: Build a workshop. Train prisoners to use it.
-- 		DONE	- Start producing license plates for profit
-- 			- Build a shop, pay prisoners a decent wage

--		Too long to wait here for training + production of license plates. Should be background objective

-- 		DONE CUTSCENE: Morgan visitation 
--		-- > Leads to SECTION C

--		------------
--		SECTION C
-- 		In Any Order
--		------------

-- 		We have an existing knackered visitation wing. No contact permitted.
--		Visitors have to queue for ages.

-- 		DONE OBJECTIVE: Run improved visitation 
--		DONE	- Build a new visitation wing.
-- 		DONE	- Support family visits from 20 families.
-- 		DONE- Add telephones
--		DONE	- Build a mail room and let inmates write to their loved ones. Especially Morgan.

--			--> SECTION C2
--			--> - Chief: Introduction to contraband theft/smuggling.
--				 Explain weapons and tools found in workshop. Start using metal detectors.
--				- Chief: Watch out for smuggling. Explain contraband smuggling. 
-- 				- Build a kennel. Deploy guard dogs.
-- 		
--		DONE OBJECTIVE: Create more welfare opportunies - Education is the key.
-- 		DONE	- Build a classroom. Pass X prisoners through basic and Y prisoners through advanced learning courses.
--		DONE	- Build a library, assign prisoners to work there 
--		DONE	- Build a chapel, do spiritual guidance
--
-- 		OBJECTIVE: Continue to expand
-- 		DONE	- We keep receiveing lots of prisoners. Expand capacity to 100 or so.

-- 			- CHIEF: Seperate out the Max Sec prisoners into their own self contained zone.
-- 			- Self contained kitchen and canteen
-- 			- Run laundry, cleaning services

--> Leads to SECTION D


--		------------
--		SECTION D
--		------------
--
-- 		CUTSCENE: Morgan suicide / ending
--      Optional objectives follow
--
--		DONE OBJECTIVE: Prisoner intake and parole services
-- 		DONE	- Chief: We need a Reception, so we can properly search inmates as they arrive 
-- 		DONE	- Hurst: We need a parole service to give inmates hope of release, and a reason to believe 
-- 			Learn about reoffending rates, and how they can be manipulated through punishment, reform
--
--
-----------------------------------------------------------------------------------------------------

