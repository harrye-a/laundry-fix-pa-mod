
function CutsceneRiotAssault()

    Game.SetMap	( "riot" )
    
	SpawnAllHostages()

    Game.SendEntityToObject	( "Benedict", "FacingHostages", 0, -1, 0 )
	Game.Damage				( "GuardHostage", 100, "GuardHostage" )
	Game.SetSprite 			( "GuardHostage", "Hostage2Dead" )

	Riot_RunAssaultCutscene()
    
    Game.GameOver()
	
end 

function Riot_RunAssaultCutscene()
    
    Game.UnlockCollectable("RiotAssault")
    
	Game.Hide ( "RiotMusic" )
	Game.Hide 	( "WorldSounds" )
	
	-- Short dialog exchange - benedict demands a bus

	Game.AdviserIncoming	( "RiotBenedict" )	
    Game.Sound              ( "__RiotAssault", "Breach1" )
	Game.CamMoveToObject    ( "CanteenWide", 1, 0.8, true )
	Game.CamMoveToObject 	( "CanteenInside", 15, 1.0, false )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_assault03" )

    Game.Sound              ( "__RiotAssault", "BreachPhoneSlam" )
    Game.PolaroidAtMarker   ( "HostagePolaroid1", "campaign/riot/ill_chap4_9.png", 3 )
    Game.Pause              (2)
    Game.HidePolaroid       ( "HostagePolaroid1" )

    -- Mayor is having none of it

    Game.StopSound          ( "__RiotAssault", "Breach1" )
    Game.Sound              ( "__RiotAssault", "Breach2" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_assault01" )
	Game.AdviserSay 		( "Mayor", "adviser_riot_assault02" )
	
	-- Benedict hangs up


	Game.CamMoveToObject 	( "CanteenInside", 0, 1.0, true )

	--Game.AdviserSay	 		( "RiotBenedict", "adviser_riot_assault2" )
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_assault3" )
	Game.AdviserSay	 		( "RiotBenedict", "adviser_riot_assault4" )
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_assault5" )
	Game.AdviserSay	 		( "RiotBenedict", "adviser_riot_assault6" )
	
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_8.png", 2 )	
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_assault7" )


	-- Spawn swat

	SpawnSwatTeam			( "FrontTeam3", "AssaultFront2", 1, 0)
	SpawnSwatTeam			( "FrontTeam4", "AssaultFront1", 1, 0)
	Game.SendEntityToObject	( "FrontTeam3", "Assault2", -1, 0, 0.4 )
	Game.SendEntityToObject	( "FrontTeam4", "Assault1", 1, 0, 0.4 )
	
	SpawnSwatTeam		( "FrontTeam1", "Assault4", -1, 0 )
	SpawnSwatTeam		( "FrontTeam2", "Assault3", 1, 0 )
	SpawnSwatTeam		( "RearTeam1", "AssaultRear1", 0, 1 )
	SpawnSwatTeam		( "RearTeam2", "AssaultRear2", 0, 1 )	
	
	Game.GiveEquipment 	( "FrontTeam1", "BatteringRam" )
	Game.GiveEquipment 	( "FrontTeam2", "BatteringRam" )
	Game.GiveEquipment 	( "FrontTeam3", "BatteringRam" )
	Game.GiveEquipment 	( "FrontTeam4", "BatteringRam" )
	Game.GiveEquipment	( "RearTeam1", "AssaultRifle" )
	Game.GiveEquipment	( "RearTeam2", "AssaultRifle" )


	-- Benedict hears something

	Game.CamMoveToObject 	( "CamAssault", 0.0, 1.1, true )	
	Game.CamZoom 			( 0.9, 5, false )
	Game.Pause	 			(1)
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_assault7b" )
	Game.AdviserSay	 		( "RiotBenedict", "adviser_riot_assault8" )


	-- Distraction team start banging on the doors

	Game.HidePolaroid		( "HostagePolaroid1" )
    
    Game.Sound              ( "__RiotAssault", "BreachDoorsmash1" )

	Game.PolaroidAtMarker	( "PolaroidAssault1", "campaign/riot/ill_chap4_13b.png", 2 )
	Game.PolaroidAtMarker	( "PolaroidAssault2", "campaign/riot/ill_chap4_13.png", 2 )
	Game.Pause 				(3)
	Game.CamMoveToObject 	( "CamAssault2", 0.2, 1, true )
	Game.Pause 				(1)
    Game.Sound              ( "__RiotAssault", "BreachDoorsmash2" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_assault9" )
	Game.CamMoveToObject 	( "CanteenInside", 0.2, 1, true )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_assault9b" )

	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettewallace1.png", 2 )	

    Game.StopSound  		( "__RiotAssault", "Breach2" )
    Game.Sound              ( "__RiotAssault", "BreachGunCock" )
	Game.AdviserSay	 		( "RiotBenedict", "adviser_riot_assault10" )


	-- Wall is breached

	Game.FadeToColour		( 1,1,1,1, 0.0, true )
	Game.Sound 				( "__RiotAssault", "BreachCarnage" )
	Game.HidePolaroid		( "HostagePolaroid1" )
		
	for x = 136, 138 do
		Game.SetMaterial( x, 142, "BurntFloor" )		
        Game.Spawn      ( "Rubble", "rubble", x, 142 )
    end
	
	Game.FadeToColour		( 1,1,1,0, 0.1, false )
	Game.Pause(0.5)

	Game.SendEntityToObject( "RearTeam1", "AssaultInside1", 0, 1, 1.5 )
	Game.SendEntityToObject( "RearTeam2", "AssaultInside2", 0, 1, 1.5 )
	
	Game.Pause(0.5)

	-- Everyone gets shot

    FireVolley      ( "RearTeam1", "BenHench1", 2, 0.1 )
    Game.Damage		( "BenHench1", 100, "RearTeam1" )
    Game.Pause 		(0.2)

    FireVolley      ( "RearTeam2", "BenHench2", 2, 0.1 )
    Game.Damage		( "BenHench2", 100, "RearTeam2" )
	Game.Pause 		(0.2)
	
    FireVolley      ( "RearTeam1", "Benedict", 2, 0.1 )
    Game.Damage		( "Benedict", 100, "RearTeam1" )

    FireVolley      ( "RearTeam1", "Ceo", 2, 0.1 )              -- stupid trigger finger
	Game.Damage		( "Ceo", 100, "RearTeam1" )
	Game.SetSprite	( "Ceo", "Hostage1Dead" )
	Game.Pause 		(0.2)

    FireVolley      ( "RearTeam2", "BenHench3", 2, 0.1 )
    Game.Damage		( "BenHench3", 100, "RearTeam2" )
	Game.Pause 		(0.2)
	
	-- breath again
	
    Game.Sound 		( "__RiotAssault", "Breach3" )
	Game.Pause(3)
	
	Game.CamZoom( 2, 10, true )

	-- Take a look at each body in turn

	Game.CamTrack( "Benedict", 0.006, true )
	Game.Pause(2)
	Game.CamMoveToObject( "Ceo", 5, 1.0, true )
	Game.Pause(3)

	-- Distraction team breaks through
	
	Game.HidePolaroid 		( "PolaroidAssault1" )
	Game.HidePolaroid 		( "PolaroidAssault2" )
	
	Game.PolaroidAtMarker( "HostagePolaroid2", "campaign/riot/ill_chap4_wallace_death2.png", 1 )

	Game.CamZoom 		( 3.0, 10, false )
	Game.Pause 			(5)
	Game.FadeToBlack 	(5,true)

	Game.Show 	( "RiotMusic" )
	
    Game.HidePolaroid ( "HostagePolaroid2" )       

end


function FireVolley( attacker, target, numShots, reloadTime )

    for i = 1, numShots do
        Game.UseWeapon		( attacker, target )
        Game.Pause			(reloadTime)
    end
end

function SpawnSwatTeam( name, destMarker, faceX, faceY )

	Game.Spawn				( "Actor", name, 0, 0 )
	Game.SetSprite 			( name, "RiotGuard" )
	Game.SendEntityToObject	( name, destMarker, faceX, faceY, -1 )
	
end 
