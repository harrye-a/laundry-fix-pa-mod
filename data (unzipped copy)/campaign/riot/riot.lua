
local testMode = false

-------------------------------------------------------------------------------
-- Begin Chapter
-------------------------------------------------------------------------------

function BeginChapter()

	Game.Hide 				( "WorldSounds" )
	Game.UnlockCollectable  ( "Riot" );

	Game.FadeToBlack		(0,true)
	Game.SetMap				( "riot" )
	Game.CamZoom 			( 10, 1, true )				
	
	Game.Hide 				( "RiotMusic" )		
	Game.Hide 				( "FogOfWar" )
	Game.Unlock				( "FireEngine" )

	showEntities = true

	Riot_SetupPrisoners		()
	
	Game.ExclusionZone 	( "AllMap", 	11, 29, 181, 186, showEntities )
	Game.ExclusionZone 	( "MaxSec", 	50, 120, 176, 186, showEntities )
	Game.ExclusionZone 	( "MaxSec", 	50, 120, 176, 186, showEntities )
	Game.ExclusionZone  ( "MaxSec", 	89, 109, 143, 154, showEntities )
	
	Riot_SetupNegotiator 	()
	Riot_StartFire			()
	
	Riot_NewsBroadcast		()	

	Game.Show 				( "RiotMusic" )

    Game.SetZoneBlocked( 1, true )   -- Hostage area indestructible.
	Riot_BasicInstructions	()
	Riot_SetupTimers 		()
	Riot_SetupTriggerZones	() 

	Game.Show 				( "FogOfWar" )
		
end


function Riot_SetupTimers()

	-- Batch 1 : Riot police + paramedics

	Objective.Create 			( "Riot_Timer1" )
	Objective.RequireTimePassed	( 60 )
	Objective.SetFlags 			( false, true )
	
	Trigger.Create              ( "Riot_ReinforcementsBatch1" )
    Trigger.RequireObjective    ( "Riot_Timer1" )


    -- Conditional : Recapture the entire gen pop wing
    -- Tell the player to resecure it with guards, and build an infirmary

    Objective.Create 						( "Riot_SecureGenPop" )
    Objective.RequirePrisonersUnderControl	( 71, 77, 161, 108 )
	Objective.SetFlags 						( false, true )

    Trigger.Create 							( "Riot_Resecure" )
    Trigger.RequireObjective 				( "Riot_SecureGenPop" )

end


function CreateTriggerZone( x, y, x2, y2, objectType, quantity, functionName )

	Objective.Create		( functionName )
	Objective.TargetZone	( x, y, x2, y2 )
	Objective.RequireObjects( objectType, quantity )
	Objective.SetFlags 		( false, true )
	
	Trigger.Create 			( functionName )
	Trigger.RequireObjective( functionName )

end

function CreateTriggerTimer( timeDelay, functionName )

	Objective.Create 			( functionName )
	Objective.RequireTimePassed	( timeDelay )
	Objective.SetFlags 			( false, true )
	
	Trigger.Create              ( functionName )
    Trigger.RequireObjective    ( functionName )

end 


function Riot_SetupTriggerZones()

	-- gen pop east 145, 94 to 154, 105
	-- OR gen pop west 78, 98 to 87, 107
	-- Trigger 1x riot squad, whichever happens first

	CreateTriggerZone( 145, 94, 154, 105, "RiotGuard", 1, "Riot_TriggerGenPopEast" )			
	CreateTriggerZone( 78, 98, 87, 107, "RiotGuard", 1, "Riot_TriggerGenPopWest" )

	-- special wing 35, 90 to 44, 103 : 1x riot squad

	CreateTriggerZone( 35, 90, 44, 103, "RiotGuard", 1, "Riot_TriggerSpecialWing" )

	-- max sec east gate 159, 112 to 166, 120
	-- OR max sec west gate 77, 130 to 86, 141
	-- Trigger first hostage scene, whichever happens first

	CreateTriggerZone( 159, 102, 166, 120, "RiotGuard", 1, "Riot_TriggerMaxSecEastGate" )
	CreateTriggerZone( 67, 130, 86, 141, "RiotGuard", 1, "Riot_TriggerMaxSecWestGate" )


	-- max sec west entrance 66, 155 to 68, 162
	-- OR max sec north entrance 115, 123 to 122, 128
	-- Trigger 1x armed guards

	CreateTriggerZone( 62, 155, 68, 162, "RiotGuard", 1, "Riot_TriggerMaxSecWest" )
	CreateTriggerZone( 115, 123, 122, 128, "RiotGuard", 1, "Riot_TriggerMaxSecNorth" )

end 


function Riot_TriggerGenPopEast()
   	CreateTriggerTimer  ( 120, "Riot_ReinforcementsBatch2" )
   	Objective.Delete	( "Riot_TriggerGenPopWest" )
   	Trigger.Delete		( "Riot_TriggerGenPopWest" )

end

function Riot_TriggerGenPopWest()
   	CreateTriggerTimer	( 120,  "Riot_ReinforcementsBatch2" )
   	Objective.Delete	( "Riot_TriggerGenPopEast" )
   	Trigger.Delete		( "Riot_TriggerGenPopEast" )
end

function Riot_TriggerSpecialWing()
	CreateTriggerTimer( 60, "Riot_ReinforcementsBatch2" )
end

function Riot_TriggerMaxSecEastGate()
	CreateTriggerTimer 	( 60, "Riot_ArmedReinforcements" )
	Objective.Delete 	( "Riot_TriggerMaxSecWestGate" )
	Trigger.Delete 		( "Riot_TriggerMaxSecWestGate" )
end 

function Riot_TriggerMaxSecWestGate()
	CreateTriggerTimer 	( 60, "Riot_ArmedReinforcements" )
	Objective.Delete 	( "Riot_TriggerMaxSecEastGate" )
	Trigger.Delete 		( "Riot_TriggerMaxSecEastGate" )
end 

function Riot_TriggerMaxSecWest()
	CreateTriggerTimer	( 60, "Riot_UnlockReinforcements" )
	Objective.Delete	( "Riot_TriggerMaxSecNorth" )
	Trigger.Delete		( "Riot_TriggerMaxSecNorth" )
end 

function Riot_TriggerMaxSecNorth()
	CreateTriggerTimer	( 60, "Riot_UnlockReinforcements" )
	Objective.Delete	( "Riot_TriggerMaxSecWest" )
	Trigger.Delete		( "Riot_TriggerMaxSecWest" )
end 


-------------------------------------------------------------------------------
-- Basic Instructions
-------------------------------------------------------------------------------

function Riot_BasicInstructions()
	
	-- Only very limited instructions to start with 
	Game.StopSkipping       ()
	Game.AdviserIncoming 	( "Negotiator" )
	
	Game.CamMoveToObject	( "NegotiatorCamera", 1, 1.0, true )
	Game.PolaroidAtMarker	( "NegotiatorPolaroid", "campaign/riot/ill_chap4_negotiator.png", 1 )
	Game.CamMoveToObject	( "NegotiatorCamera", 4, 0.5, false )
	
	Game.Pause 				(2)
	
	Game.AdviserSay 		( "Negotiator", "adviser_riot_negotiator1" )
	Game.AdviserSay 		( "Negotiator", "adviser_riot_negotiator2" )
	Game.AdviserSay 		( "Negotiator", "adviser_riot_negotiator3" )
	Game.AdviserSay 		( "Negotiator", "adviser_riot_negotiator4" )
			
	Objective.Create		( "Riot_StopTheRiot" )
	Objective.Requires 		( "RiotingPrisoners", "Below", 3 )

	Game.HidePolaroid 		( "NegotiatorPolaroid" )
	
end

-------------------------------------------------------------------------------
-- Setup Negotiator
-------------------------------------------------------------------------------

function Riot_SetupNegotiator()

	Riot_SpawnHostageActors ( "Negotiator", "Negotiator", "CueNegotiator", 0, 1 )
	Game.GiveEquipment 		( "Negotiator", "CbRadio" )
	
	-- Spawn badly injured guards 
	
	for i = 1, 10 do 
		local posX = math.random( 164.0, 173.0 )
		local posY = math.random( 12.0, 15.0 )			
		local name = "NegotiatorGuard" .. i;
		local damage = math.random( 15, 18 )
		
		Game.Spawn			( "Guard", name, posX, posY )		
		Game.LoseEquipment 	( name )
		Game.Damage 		( name, damage, name )
	end
end

-------------------------------------------------------------------------------
-- Setup Prisoners
-------------------------------------------------------------------------------

function Riot_SetupPrisoners()
	
	-- Special wing
	
	Game.SpawnPrisoners ( 13, 54, 46, 137, "minsec" )
	Game.Misconduct		( 13, 54, 46, 137, "Rioting" )

	
	-- Normal sec / central wing
	
	Game.SpawnPrisoners	( 76, 76, 156, 123, "normal" )
	Game.Misconduct		( 76, 76, 156, 123, "Rioting" )
	
	-- Max sec / south wing
	
	Game.SpawnPrisoners ( 67, 128, 127, 176, "maxsec" )
	Game.Misconduct		( 67, 128, 127, 176, "Rioting" )

	
	-- Spawn some weapons for the max sec guys
		
	weapons = { "Shank", "Baton", "Knife", "Club", "Hammer" }		
	
	for i = 1, 30 do	
		local posX = math.random( 70, 155 )
		local posY = math.random( 155, 163 )			
		local weapon = weapons[ math.random(1,5) ]				
		Game.Spawn			( weapon, weapon, posX, posY )		
	end
	
	for i = 1, 20 do	
		local posX = math.random( 114, 130 )
		local posY = math.random( 123, 151 )			
		local weapon = weapons[ math.random(1,5) ]				
		Game.Spawn			( weapon, weapon, posX, posY )		
	end

	-- some med sec weapons 
	
	for i = 1, 4 do
		local posX = math.random( 89, 143 )
		local posY = math.random( 97, 102 )
		local weapon = weapons[ math.random(1, 2) ]
		Game.Spawn 			( weapon, weapon, posX, posY )
	end
	
	-- Security room
	
	for i = 1, 3 do 
		Game.SpawnPrisoners	( 129, 137, 133, 141, "maxsec" )
	end 

	Game.Misconduct		( 129, 137, 133, 141, "Rioting" )

	Game.Spawn		( "Shank", "Shank", 130, 138 )		
	Game.Spawn		( "Baton", "Baton", 132, 140 )		

end


-----------------------------------------------------------------------------------------------------
-- Start Fire
-------------------------------------------------------------------------------------------------------

function Riot_StartFire()

	for x = 20, 23 do
		for y = 124, 127 do
			Game.Spawn( "Fire", "Fire", x, y )
		end
	end 	

end


-----------------------------------------------------------------------------------------------------
-- Reinforcements batch 1
-------------------------------------------------------------------------------------------------------

function Riot_ReinforcementsBatch1()

	Game.AdviserIncoming( "Negotiator" )

	Game.VehicleCallout	( "RiotPolice", "RiotPolice1" )

	Game.CamMoveToObject( "CamEntranceWide", 1, 1.0, true )
	Game.CamMoveToObject( "CamEntranceClose", 10, 1.0, false )

	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements1" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements2" )

	Game.VehicleCallout	( "Paramedics", "Paramedics" )
	Game.CamMoveToObject( "CamEntranceWide", 0, 0.9, true )
	Game.CamMoveToObject( "CamEntranceClose", 10, 1.0, false )
	
	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements3" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements4" )
end



-----------------------------------------------------------------------------------------------------
-- Reinforcements batch 1b
-------------------------------------------------------------------------------------------------------

function Riot_ReinforcementsBatch1b()

	Game.AdviserIncoming( "Negotiator" )

	Game.VehicleCallout	( "RiotPolice", "RiotPolice1" )

	Game.CamMoveToObject( "CamEntranceWide", 1, 1.0, true )
	Game.CamMoveToObject( "CamEntranceClose", 10, 1.0, false )

	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements1" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_firstreinforcements2" )

end


-----------------------------------------------------------------------------------------------------
-- Resecure
-- Occurs once the central gen pop wing has been recaptued
-- The player is given a proper set of objectives from Heller
-------------------------------------------------------------------------------------------------------

function Riot_Resecure()

	Game.AdviserIncoming( "Mayor" )

	Game.AdviserSay 		( "Mayor", "adviser_riot_helleradvice1" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_helleradvice2" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_deployguards1" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_deployguards2" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_deployguards3" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_deployguards4" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_deployguards5" )
 
	Game.RemoveExclusionZone ( "AllMap" )
 
 	Riot_SetupRecaptureObjectives()


 	-- Start a timer for the Doctor to phone and ask for help
	-- Start a timer to the first hostage cutscene

 	CreateTriggerTimer ( 60, "Riot_DoctorNeedsHelp" )
    CreateTriggerTimer 	( 120, "Riot_TriggerNextCutscene" );

end 


function Riot_DoctorNeedsHelp()

 	Game.AdviserIncoming 	( "Doctor" )
 	Game.AdviserSay 		( "Doctor", "adviser_riot_infirmary1" )
 	Game.AdviserSay 		( "Doctor", "adviser_riot_infirmary2" )
 	Game.AdviserSay 		( "Doctor", "adviser_riot_infirmary3" )
	Game.AdviserSay 		( "Doctor", "adviser_riot_infirmary4" )

	Objective.Create 		( "Riot_MedicalNeeds" )
	
	Objective.Create 		( "Riot_Infirmary" )
	Objective.SetParent 	( "Riot_MedicalNeeds" )
	Objective.RequireRoom	( "MedicalWard", true )

	Objective.Create 		( "Riot_Morgue" )
	Objective.SetParent 	( "Riot_MedicalNeeds" )
	Objective.RequireRoom	( "Morgue", true )

	Trigger.Create 			( "Riot_MedicalNeedsDone" )
	Trigger.RequireObjective ( "Riot_MedicalNeeds" )
	
end 

function Riot_MedicalNeedsDone()
end 



-----------------------------------------------------------------------------------------------------
-- Reinforcements batch 2
-------------------------------------------------------------------------------------------------------

function Riot_ReinforcementsBatch2()

	Game.AdviserIncoming( "Negotiator" )
	Game.VehicleCallout	( "RiotPolice", "RiotPolice3" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_secondreinforcements1" )

end



-----------------------------------------------------------------------------------------------------
-- Reinforcements batch 3
-------------------------------------------------------------------------------------------------------

function Riot_ReinforcementsBatch3()

	Game.AdviserIncoming( "Negotiator" )

	Game.VehicleCallout	( "RiotPolice", "RiotPolice3" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_secondreinforcements1" )
	Game.VehicleCallout	( "RiotPolice", "RiotPolice3" )

end


-----------------------------------------------------------------------------------------------------
-- Armed Reinforcements 
-------------------------------------------------------------------------------------------------------

function Riot_ArmedReinforcements()

	Game.AdviserIncoming( "Negotiator" )

	Game.VehicleCallout	( "ArmedPolice", "ArmedPolice" )

	Game.CamMoveToObject( "CamEntranceWide", 1, 1.0, true )
	Game.CamMoveToObject( "CamEntranceClose", 10, 1.0, false )
	
	Game.AdviserSay		( "Negotiator", "adviser_riot_armedreinforcements1" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_armedreinforcements2" )
	Game.AdviserSay		( "Negotiator", "adviser_riot_armedreinforcements3" )
end

-----------------------------------------------------------------------------------------------------
-- Unlock Reinforcements 
-- The player can now use the Emergencies button to summon as many Riot Guards and Paramedics as required
-------------------------------------------------------------------------------------------------------

function Riot_UnlockReinforcements()

	Game.AdviserIncoming( "Negotiator" )
	Game.AdviserSay 	( "Negotiator", "adviser_riot_reinforcementsunlocked1" )
	Game.AdviserSay 	( "Negotiator", "adviser_riot_reinforcementsunlocked2" )

	Game.Unlock( "EmergencyCallouts" )

end 


-------------------------------------------------------------------------------------------------------
-- Recapture Objectives
-- Properly formed objectives to neutralise all rioting prisoners, then re-secure the wings with Guards
-------------------------------------------------------------------------------------------------------

function Riot_SetupRecaptureObjectives()

	Objective.Create 		( "Riot_ResecureWings" )
    Objective.Requires      ( "StationedGuards", "AtLeast", 20 )

	Trigger.Create 			( "Riot_ResecureWings_Done" )
	Trigger.RequireObjective( "Riot_ResecureWings" )
	
	Objective.Create            			( "Riot_SecureGenPop" )
	Objective.RequirePrisonersUnderControl	( 71, 77, 161, 122 )
	Objective.SetTargetVisible 				( false )
	Objective.SetParent						( "Riot_StopTheRiot" )

	Objective.Create            			( "Riot_SecureSpecialWing" )
	Objective.RequirePrisonersUnderControl	( 14, 55, 45, 135 )
	Objective.SetTargetVisible 				( false )
    Objective.SetParent						( "Riot_StopTheRiot" )
	
	Objective.Create            			( "Riot_SecureMaxSec" )
	Objective.RequirePrisonersUnderControl	( 61, 124, 170, 174 )
	Objective.SetTargetVisible 				( false )
	Objective.SetParent						( "Riot_StopTheRiot" )
	
    Objective.Create 						( "Riot_putoutfires" )
    Objective.RequireObjects    			( "Fire", 1 )
    Objective.Invert            			()
    Objective.SetParent						( "Riot_StopTheRiot" )
	
    Trigger.Create 				( "Riot_TriggerNextCutscene" )
	Trigger.RequireObjective 	( "Riot_StopTheRiot" )
	Trigger.RequireObjective	( "Riot_SecureGenPop" )
	Trigger.RequireObjective	( "Riot_SecureSpecialWing" )
	Trigger.RequireObjective	( "Riot_SecureMaxSec" )
end

function Riot_ResecureWings_Done()
end 

function Riot_PrisonRecaptured()

	Riot_RunAssaultCutscene()

	Riot_CleanupAfterAssault()
	
	Game.Pause 	(3)
	Game.FadeUp (3, true)
	Game.Show 	( "WorldSounds" )
	
	Riot_SetupCleanupObjectives()

	Game.RemoveExclusionZone ( "MaxSec" )
	
end 


-- Cleanup after assault
-- Remove all actors, bits of shit lying around etc 

function Riot_CleanupAfterAssault()

	Game.Remove( "Negotiator" )
	
	Game.Remove( "AnotherHostage1" )
	Game.Remove( "AnotherHostage2" )
	Game.Remove( "AnotherHostage3" )
	
	Game.Remove( "FrontTeam1" )
	Game.Remove( "FrontTeam2" )
	Game.Remove( "FrontTeam3" )
	Game.Remove( "FrontTeam4" )

	Game.Remove( "RearTeam1" )
	Game.Remove( "RearTeam2" )
		
    Game.Remove("Car1")
    Game.Remove("Car2")
    Game.Remove("Car3")		
    
    Game.Remove("HostageDoor1")
    Game.Remove("HostageDoor2")
	
		-- Put holes in the walls where the doors were to the canteen 
		
	Game.SetMaterial( 133, 155, "BurntFloor" )
	Game.SetMaterial( 148, 155, "BurntFloor" )
		
end


function Riot_SetupCleanupObjectives()

    Game.SetZoneBlocked     ( 1, false )   -- Hostage area editable
	Game.Unlock         	( "Reports" )

    Game.AdviserIncoming            ( "Mayor" )
    Game.Show                       ( "Interface" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup1" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup2" )
	Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup2b" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup3" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup4" )


	-- Armoury / armed patrols in max sec 
	
	Objective.Create 		( "Riot_Armoury" )
	
	Objective.Create 			( "Riot_Armoury_Research" )
	Objective.SetParent 		( "Riot_Armoury" )
	Objective.Requires 			( "Unlocked", "Armoury", 1 )
	
	Objective.Create 			( "Riot_Armoury_Build" )
	Objective.RequireRoom		( "Armoury", true )
	Objective.SetParent 		( "Riot_Armoury" )
	
	Objective.Create 			( "Riot_Armoury_Deploy" )
	Objective.SetParent 		( "Riot_Armoury" )
	Objective.Requires      	( "PatrolArmed", "AtLeast", 2 )

    -- Tazers + body armour

    Game.AdviserSay             ( "Mayor", "adviser_riot_cleanup5" )

	Objective.Create 			( "Riot_Armoury_Armour" )
	Objective.SetParent 		( "Riot_Armoury" )
	Objective.Requires 			( "Unlocked", "BodyArmour", 1 )
	
	Objective.Create 			( "Riot_Armoury_Tazers" )
	Objective.SetParent 		( "Riot_Armoury" )
	Objective.Requires 			( "Unlocked", "Tazers", 1 )
   	
	
    -- Build solitary

    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup8" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup8b" )

    Objective.Create 				( "Riot_Solitary" )
    Objective.RequireRoomsAvailable	( "Solitary", 5 )

	Trigger.Create 				( "Riot_CleanupObjectivesPartTwo" )
	Trigger.RequireObjective 	( "Riot_Armoury" )
	Trigger.RequireObjective	( "Riot_Armoury_Research" )
	Trigger.RequireObjective	( "Riot_Armoury_Build" )
	Trigger.RequireObjective 	( "Riot_Armoury_Deploy" )
	Trigger.RequireObjective 	( "Riot_Armoury_Armour" )
	Trigger.RequireObjective 	( "Riot_Armoury_Tazers" )
	Trigger.RequireObjective	( "Riot_Solitary" )
	

    -- Zone Staff Offices
	
    Game.SetZoneRoom    ( "Office", 135, 137, 139, 141 )
    Game.SetZoneRoom    ( "Office", 141, 137, 145, 141 )
    Game.SetZoneRoom    ( "Office", 147, 137, 151, 141 )
   
    -- Front gate polaroid to finish

    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup11" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup12" )

    Game.PolaroidTrigger 	( "campaign/riot/ill_chap4_2.png", 169, 14, "Riot_PlayerExitsMap" )

	Objective.Create 		( "Riot_PlayerExitsMap" )
	Objective.Requires 		( "Nothing", "", 0 )

end


function Riot_CleanupObjectivesPartTwo()

	Game.AdviserIncoming 			( "Mayor" )
	Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup13" )

	-- Prisoner work program 

    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup6" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup7" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup7b" )
    Game.IncreaseNeeds              ( "Clothing", 60 )

    Objective.Create 	( "Riot_PrisonerWork" )

    Objective.Create 		( "Riot_CleaningCupboard" )
    Objective.RequireRoom	( "CleaningCupboard", true )
    Objective.SetParent 	( "Riot_PrisonerWork" )

    Objective.Create 		( "Riot_InmatesInCleaning" )
    Objective.SetParent 	( "Riot_PrisonerWork" )
    Objective.Requires 		( "PrisonerJobs", "CleaningCupboard", 5 )

    Objective.Create 		( "Riot_CleanPrison" )
    Objective.SetParent 	( "Riot_PrisonerWork" )
    Objective.Requires 		( "NeedDischarged", "Environment", 70 )

    Objective.Create 		( "Riot_Laundry" )
    Objective.RequireRoom	( "Laundry", true )
    Objective.SetParent 	( "Riot_PrisonerWork" )

    Objective.Create 		( "Riot_InmatesInLaundry" )
    Objective.SetParent 	( "Riot_PrisonerWork" )
    Objective.Requires 		( "PrisonerJobs", "Laundry", 5 )

    Objective.Create 		( "Riot_ProvideLaundry" )
    Objective.SetParent 	( "Riot_PrisonerWork" )
    Objective.Requires 		( "NeedDischarged", "Clothing", 70 )

	Trigger.Create 				( "Riot_PrisonerWork_Done" )
	Trigger.RequireObjective 	( "Riot_PrisonerWork" )
	Trigger.RequireObjective 	( "Riot_CleaningCupboard" )
	Trigger.RequireObjective	( "Riot_InmatesInCleaning" )
	Trigger.RequireObjective	( "Riot_CleanPrison" )
	Trigger.RequireObjective 	( "Riot_Laundry" )
	Trigger.RequireObjective 	( "Riot_InmatesInLaundry" )
	Trigger.RequireObjective 	( "Riot_ProvideLaundry" )


    -- Staff Room

    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup9" )
	Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup9b" )

    Objective.Create 				( "Riot_StaffRoom" )
    Objective.RequireRoom   		( "Staffroom", true )

	Trigger.Create 				( "Riot_StaffRoom_Done" )
	Trigger.RequireObjective	( "Riot_StaffRoom" )


    -- Financial requirements

    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup10" )
	Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup10b" )

    Objective.Create 	( "Riot_BalanceBooks" )

    Objective.Create 	( "Riot_BalanceBooks_Balance" )
    Objective.SetParent ( "Riot_BalanceBooks" )
    Objective.Requires 	( "Cash", "Above", 0 )

    Objective.Create 	( "Riot_BalanceBooks_Cashflow" )
    Objective.SetParent ( "Riot_BalanceBooks" )
    Objective.Requires  ( "Cashflow", "Above", 0 )
	
	
	    -- Front gate polaroid to finish
		-- (Already exists)
		
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup11" )
    Game.AdviserSay                 ( "Mayor", "adviser_riot_cleanup12" )

end

function Riot_PrisonerWork_Done()
end 

function Riot_StaffRoom_Done()
end

function Riot_PlayerExitsMap()

	Game.UnlockCollectable( "Conviction" )

	Game.FadeToBlack		(3,true)
	Game.Hide 				( "WorldSounds" )
	Game.Pause 				(3)	
	Game.TestAchievement	( "RiotOptionals" )
    Game.SetCampaignChapter ( "Conviction" )

end


function Riot_TriggerNextCutscene()
   return Riot_RunCutsceneOnce( "Seen_Riot_Cutscene_1", Riot_RunHostagesFirstScene ) and
          Riot_RunCutsceneOnce( "Seen_Riot_Cutscene_2", RunRouletteScene ) and
          Riot_RunCutsceneOnce( "Seen_Riot_Cutscene_3", Riot_PrisonRecaptured )
end


-- Run a cutscene (cutsceneFunction) only by tracking whether it has run
-- by means of a hidden objective (objectiveName).
function Riot_RunCutsceneOnce(objectiveName, cutsceneFunction)
    if Objective.Exists(objectiveName) then
        return true
     end

     cutsceneFunction()

     Objective.Create( objectiveName )
     Objective.SetFlags( false, true )

     return false
end
