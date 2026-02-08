

function BeginChapter()

	Game.UnlockCollectable( "Epilogue" );

    Epilogue_NewsIntro()
    EpilogueSandbox()
	
	
	Game.Unlock     ( "Reports" )
	Game.Unlock		( "SandboxObjectives" )
    Game.Unlock     ( "EmergencyCallouts" )
    Game.Unlock     ( "LandExpand" )
end


function CutsceneEpilogueIntro()

	Epilogue_NewsIntro()		

	Game.GameOver()
	
end 


-- News Intro
-- Pan up on the chapter 1 prison, do all the same camera moves
-- This time with the news music playing in the background

function Epilogue_NewsIntro()

	Game.UnlockCollectable("EpilogueIntro")
	
	Game.SetMap		 ( "epilogue" )       
	Game.FadeToBlack (0, true)
	Game.Hide 		( "WorldSounds" )
	Game.CopyMapZone ( "deathrow-beforeexecution", 11, 33, 25, 55 )
	
	Game.SetSprite		( "CameraMan", "CameraMan" )
	Game.SetSprite  	( "Reporter", "NewsReporter" )
	Game.GiveEquipment	( "Reporter", "Microphone" )
	
	-- News jingle intro 
	
	Game.PolaroidAtMarker   ( "NewsBackdrop", "campaign/epilogue/breaking-news.png", 1 ) 
	Game.Sound              ( "__RiotIntro", "NewsIntro" ) 	
	Game.CamMoveToObject    ( "NewsCamera", 0, 0.2, true )
	Game.Pause 				(0.3)
	Game.FadeUp             ( 0, false ) 
    Game.CamZoom 			( 2.0, 5.8, true )
	Game.CamZoom 			( 1.8, 0.2, true )

	-- News anchor gives intro 
	
    Game.Sound              ( "__RiotIntro", "NewsLoop" ) 	
 	
	Game.AdviserSay			( "NewsReader", "epilogue_newsintro1" )
    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/riot/ill_chap4_13b.png", 0 ) 
    Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/riot/ill_chap4_wallacePR.png", 0 ) 	
	Game.AdviserSay			( "NewsReader", "epilogue_newsintro2" )	
	Game.AdviserSay			( "NewsReader", "epilogue_newsintro4" )
	Game.AdviserSay			( "NewsReader", "epilogue_newsintro5" )
	Game.AdviserSay			( "NewsReader", "epilogue_newsintro6" )
	
	
	-- News jinlge outro - show the prison 
	
    Game.Sound              ( "__RiotIntro", "NewsIntro" ) 
    Game.StopSound          ( "__RiotIntro", "NewsLoop" )
    Game.Sound              ( "__EpilogueIntro", "Music1" )
	Game.SendEntityToObject	( "Reporter", "ReporterCue1", 0, 1, -1 )	
	
    Game.CamMove			( 20, 6, 38, 16, 0, true )  

	Game.HidePolaroid       ( "NewsBackdrop" )
	Game.HidePolaroid       ( "NewsPolaroid1" )
	Game.HidePolaroid       ( "NewsPolaroid2" )

	Game.CamMove			( 33, 6, 51, 16, 10, false )   
	Game.Pause 				(6)       
	Game.CamMove    		( 0, 3, 113, 76, 0.5, false )
	Game.Pause 				( 4 )	
	

	-- Reporter on site takes over, whilst we are still looking at the wide shot 
    
    Game.Sound              ( "__EpilogueIntro", "Music2" )
	
	Game.AdviserSay			( "Reporter", "epilogue_reporter1" )
	Game.AdviserSay			( "Reporter", "epilogue_reporter2" )
		
	-- Cut to film crew on site
	-- Heller interview 
	
    Game.Sound              ( "__EpilogueIntro", "Music3" )
    Game.PolaroidAtMarker   ( "PolaroidDemolish", "campaign/epilogue/ill_chap5_construction.png", 2 )
	Game.CamMoveToObject	( "cam0", 0, 1.0, true )
	Game.CamMoveToObject	( "cam1", 4, 1.1, false )	
	Game.Pause 				(2)
 	Game.AdviserSay			( "Reporter", "epilogue_reporter3" )
	Game.SendEntityToObject	( "Reporter", "ReporterCue1", -1, 0, 0.1 )	
	Game.CamZoom 			( 0.9, 20, false )
	Game.AdviserSay			( "Reporter", "epilogue_reporter4" )
	Game.AdviserSay			( "Mayor", "epilogue_reporter5" )
	Game.AdviserSay			( "Reporter", "epilogue_reporter6" )
	Game.AdviserSay			( "Reporter", "epilogue_reporter6b" )
	Game.AdviserSay			( "Mayor", "epilogue_reporter7" )
	Game.AdviserSay			( "Mayor", "epilogue_reporter8" )

	-- Discussion of death penalty facility
		
	Game.AdviserSay			( "Reporter", "epilogue_reporter9" )
	Game.CamMoveToObject 	( "cam3", 1, 1.0, true )
	Game.AdviserSay			( "Reporter", "epilogue_reporter10" )
	Game.AdviserSay			( "Mayor", "epilogue_reporter12" )	
	Game.CamMoveToObject 	( "cam1", 1, 1.2, true )
	Game.SendEntityToObject	( "Reporter", "ReporterCue1", 0, 1, -1 )	
	Game.AdviserSay 		( "Reporter", "epilogue_reporterend1" )
    
    Game.Sound              ( "__RiotIntro", "NewsLoop" )
    Game.StopSound          ( "__EpilogueIntro", "Music1" )
    Game.StopSound          ( "__EpilogueIntro", "Music2" )
    Game.StopSound          ( "__EpilogueIntro", "Music3" )

	
	-- Cut back to the studio
	-- Bit more dialogue, move over to Hurst on the telephone
	
	Game.CamMoveToObject    ( "NewsCamera", 0, 1.2, true )
	Game.PolaroidAtMarker   ( "NewsBackdrop", "campaign/epilogue/breaking-news.png", 1 ) 

	Game.AdviserSay			( "NewsReader", "epilogue_newstransition1" )
    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/epilogue/ill_chap3_jail5.png", 0 ) 			
	Game.AdviserSay			( "NewsReader", "epilogue_newstransition2" )
    
    Game.StopSound          ( "__RiotIntro", "NewsLoop" ) 
    Game.Sound              ( "__RiotIntro", "NewsOutro" ) 

	Game.FadeToBlack(1,true)
	
	Game.Show( "WorldSounds" )
	
end 



-- Epilogue Sandbox
-- Sets up the death row (chapter 1) map already under demolition
-- Heller tasks you to do whatever you want

function EpilogueSandbox()

	Game.SetMap( "epilogue-sandbox" )
	Game.FadeToBlack(0,true)	
	Game.CopyMapZone ( "deathrow-beforeexecution", 11, 33, 25, 55 )
	Game.CamTrack( "Heller", 0.01 )		
	Game.FadeUp(2,true)

	Game.Pause(1)
	Game.GiveEquipment( "Heller", "MobilePhone" )		
	Game.Pause(1)
    Game.StopSkipping()
	Game.AdviserIncoming( "Mayor" )
	
	Game.CamZoom 		( 4.0, 10.0, false )
	Game.AdviserSay ( "Mayor", "epilogue_sandbox_1" )
	Game.AdviserSay ( "Mayor", "epilogue_sandbox_2" )
		
	Game.SendEntityToObject( "Heller", "Exit", 0, 1, 0.5 )	
	Game.CamTrack( "Heller", 0.03 )	
	Game.Pause(3)
	Game.AdviserSay ( "Mayor", "epilogue_sandbox_3" )
	Game.AdviserSay ( "Mayor", "epilogue_sandbox_4" )
	Game.AdviserSay ( "Mayor", "epilogue_sandbox_5" )
    Game.AdviserSay ( "Mayor", "epilogue_sandbox_5b" )
    Game.AdviserSay ( "Mayor", "epilogue_sandbox_5c" )

	Game.CamMove    ( -16, -4, 129, 86, 3, true )


    Game.AdviserSay ( "Mayor", "epilogue_sandbox_6" )
    Game.Remove( "Heller" )

    -- Sandbox objectives, including the CEO's letter

    Game.Unlock		( "SandboxObjectives" )

    -- Hint to take grants

	Objective.Create( "epilogue_grants" )
	Objective.Requires( "Nothing", "", 0 )

	Objective.Create( "epilogue_certifiedprison" )
	Objective.Requires( "Nothing", "", 0 )
	
	-- Only actual objective : build a certified prison to a minimum standard 
	
	Objective.Create( "epilogue_capacity" )
	Objective.SetParent( "epilogue_certifiedprison" )
	Objective.Requires( "Prisoners", "AtLeast", 100 )

	Objective.Create( "epilogue_bankbalance" )
	Objective.SetParent( "epilogue_certifiedprison" )
	Objective.Requires( "Cash", "AtLeast", 60000 )
	
	Objective.Create( "epilogue_cashflow" )
	Objective.SetParent( "epilogue_certifiedprison" )
	Objective.Requires( "Cashflow", "AtLeast", 1 )
	
	Trigger.Create( "EpilogueBasicPrisonFinished" )
	Trigger.RequireObjective( "epilogue_capacity" )
	Trigger.RequireObjective( "epilogue_bankbalance" )
	Trigger.RequireObjective( "epilogue_cashflow" )
	
end 


function EpilogueBasicPrisonFinished() 

	Objective.Delete( "epilogue_grants" )
    Objective.Delete( "epilogue_certifiedprison" )
	
	Game.AdviserIncoming( "Mayor" )	
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_1" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_2" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_3" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_4" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_5" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_6" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_8" )
	Game.AdviserSay( "Mayor", "epilogue_basiccompletion_9" )
	
	
	-- Re-offending rate objective and trigger
	
	Objective.Create( "epilogue_reoffending" )
   	Objective.Requires( "Nothing", "", 0 )

	Objective.Create( "epilogue_reoffending_rate" )
	Objective.SetParent( "epilogue_reoffending" )
	Objective.Requires( "ReoffendingRate", "AtMost", 30 )
	
	Objective.Create( "epilogue_reoffending_released" )
	Objective.SetParent( "epilogue_reoffending" )
	Objective.Requires( "PrisonersReleased", "AtLeast", 10 )
	
	Trigger.Create( "EpilogueDoneFinalOptional" )
	Trigger.RequireObjective( "epilogue_reoffending_rate" )
	Trigger.RequireObjective( "epilogue_reoffending_released" )
	
	
	-- Polaroid to leave the map objective
		
    Game.PolaroidTrigger 	( "campaign/epilogue/ill_chap7_1.png", 104, 37, "Epilogue_PlayerExitsMap" )
    
	Objective.Create 		( "Epilogue_PlayerExitsMap" )
    Objective.Requires 		( "Nothing", "", 0 )
	
	
	-- This is here just to be safe.
	-- These should be unlocked anyway.
	
	Game.Unlock     ( "Reports" )                         
	Game.Unlock		( "SandboxObjectives" )               
    Game.Unlock		( "EmergencyCallouts" )
    Game.Unlock     ( "LandExpand")

end 


function EpilogueDoneFinalOptional() 

    Objective.Clear( "epilogue_reoffending" )
	Game.TestAchievement( "BootstrapsOptionals" )
    
end


function Epilogue_PlayerExitsMap()
   
	Game.SaveMap( "epilogue-inprogress" )
	Game.FadeToBlack(2,true)

    -- Upon answering, we go to the chapter 4 prison and get some words from Hurst
	-- Then we see Morgan released and go home

	Epilogue_Parole()	
	EpilogueHome()
    Game.Pause(4)
	CutsceneEpilogueCredits()

		
	-- Unlock all chapter polaroids
	-- Inlcuding the ones that aren't actually used in any scenes
	
	Game.UnlockCollectable( "AllChapterPolaroids" )	
	
end 


