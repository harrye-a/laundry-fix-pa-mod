



function CutsceneRiotRoulette()

    Game.SetMap	( "riot" )
    
	SpawnAllHostages()

	RunRouletteScene()

    Game.FadeToBlack    ( 3, true )
    Game.GameOver       ()

end 

function RunRouletteScene()
    
    Game.UnlockCollectable("RiotRoulette")
    
    Game.AdviserIncoming    ( "Negotiator" )
    Game.Hide 				( "RiotMusic" )
	Game.Hide 				( "WorldSounds" )

    --Game.AdviserSay         ( "Negotiator", "adviser_riot_rouletteintro1" )
    Game.AdviserSay         ( "Negotiator", "adviser_riot_rouletteintro2" )

    Game.Sound              ( "__RiotHostages", "HostagesMusic1" )
	Game.CamMoveToObject 	( "CanteenInside", 1, 1.0, true )

	-- Benedict begins interrogation
	-- Removes bullets from gun
	
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette1" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_removingbullets.png", 1 )
    Game.Sound              ( "__RiotRoulette", "Unload1" );

	Game.Pause 				(1.5)
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_gun3bullets.png", 1 )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic2" )
    Game.Pause 				(1.5)
    Game.Sound              ( "__RiotRoulette", "Unload2" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_gun4bullets.png", 1 )
	Game.Pause 				(1.5)
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_gun5bullets.png", 1 )
	Game.Pause 				(1.5)
    Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_twobullets.png", 1 )
    Game.Sound              ( "__RiotRoulette", "BarrelSpin" )
    Game.Pause              (2.0)

    Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette2" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette2b" )
	Game.Pause 				(1)
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette3" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette4" )
    Game.Sound              ( "__RiotRoulette", "BarrelSpin" )
    Game.Pause              (0.5)
    Game.Sound              ( "__RiotRoulette", "BarrelClose" );
    Game.Sound              ( "__RiotRoulette", "RouletteMusic3" )
	Game.HidePolaroid 		( "HostagePolaroid1" )
	
		Riot_SuspiciousFlashback1()

	-- Guard is threatened
	
	Game.SendEntityToObject ( "Benedict", "FacingHostageGuard", -1, 0, 0.3 )
	Game.Pause 				(3)
    Game.Sound              ( "__RiotRoulette", "GunCock1" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettecop1.png", 1 )	
    Game.Sound              ( "__RiotRoulette", "RouletteMusic5" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette6" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic6" )
    Game.Sound              ( "__RiotRoulette", "Execute" )

    Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettecop2.png", 1 )
	Game.Pause 				(3)
	
	-- Guard is shot
	
    Game.FadeToColour		( 1,1,1,1, 0.0, true )
    Game.FadeToColour		( 1,1,1,0, 0.1, false )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettecop2b.png", 3 )
    Game.StopSound          ( "__RiotRoulette", "RouletteMusic4" )
    Game.StopSound          ( "__RiotRoulette", "RouletteMusic6" )
	Game.SetSprite 			( "GuardHostage", "Hostage2Dead" )
	Game.Damage 			( "GuardHostage", 100, "Benedict" )
	Game.Pause 				(3)
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette7" )
	Game.HidePolaroid 		( "HostagePolaroid1" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette8" )
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette9" )
	


	-- Janitor is threatened, gun doesnt fire
	
	Game.SendEntityToObject ( "Benedict", "BehindHostageJanitor", -1, 0, 0.3 )
	Game.Pause 				(3)
    Game.Sound              ( "__RiotRoulette", "Janitor1" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette10" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic8" )

			Riot_SuspiciousFlashback2()

	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette11" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic10" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette11e" )
    Game.Sound              ( "__RiotRoulette", "BarrelSpin" )
    Game.Pause              (0.5)
    Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettejanitor.png", 1 )
    Game.Sound              ( "__RiotRoulette", "GunCock2" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic11" )
    Game.Sound              ( "__RiotRoulette", "Janitor2" )

	Game.Pause 				(3)
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettejanitorB.png", 1 )	
	Game.Pause 				(3.4)
    Game.HidePolaroid 		( "HostagePolaroid1" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic12" )
	Game.Pause 				(2)
	

	-- Benedict clicks against his own head
	
	Game.SendEntityToObject ( "Benedict", "FacingHostages", 0, -1, 0.3 )
	Game.Pause 				(3)
    Game.Sound              ( "__RiotRoulette", "RouletteMusic13" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette12" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic14" )
    Game.Sound              ( "__RiotRoulette", "Benedict1" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettebenedict.png", 1 )	
	Game.Pause 				(5)
    Game.Sound              ( "__RiotRoulette", "Benedict2" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic15" )
	Game.HidePolaroid 		( "HostagePolaroid1" )
	Game.Pause 				(4)
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette12b" )
	

	-- Benedict aims at the CEO, last chance
	
	Game.SendEntityToObject ( "Benedict", "Hostage1", 0, 1, 0.3 )
	Game.Pause 				(3)
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettewallace1.png", 1 )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic16" )
    Game.Sound              ( "__RiotRoulette", "Crying2" )
	Game.Pause 				(3)

	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette13" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic17" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettewallace2.png", 1 )	
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette14" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic18" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettewallace2B.png", 1 )	
    Game.Sound              ( "__RiotRoulette", "TriggerSqueeze1" )
	Game.Pause 				(1)
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_roulettewallace2C.png", 1 )	
    Game.Sound              ( "__RiotRoulette", "TriggerSqueeze2" )
	Game.Pause 				(1)
	
	-- Ceo buckles
	
    Game.Sound              ( "__RiotRoulette", "RouletteMusic19" )
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette15" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic20" )
	Game.HidePolaroid 		( "HostagePolaroid1" )	
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette16" )
	
	Game.SendEntityToObject	( "Benedict", "FacingHostages", 0, -1, 0.3 )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_arguing_wallace.png", 1 )	
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette17" )	
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette17b" )
    Game.Sound              ( "__RiotRoulette", "RouletteMusic21" )
	Game.PolaroidAtMarker	( "HostagePolaroid1", "campaign/riot/ill_chap4_arguing_benedict.png", 1 )	
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette18" )
	Game.AdviserSay 		( "RiotCeo", "adviser_riot_roulette19" )
	Game.Pause 				(2)
    Game.Sound              ( "__RiotRoulette", "RouletteMusic22" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette20" )
	

	Game.HidePolaroid 		( "HostagePolaroid1" )
	Game.Show 				( "RiotMusic" )
	Game.Show 				( "WorldSounds" )
	
end




function Riot_SuspiciousFlashback1()

    -- Cut to office flashback 

    Game.Show               ( "Flashback" )
    Game.CamMoveToObject    ( "OfficeCam", 0, 1.1, false )
    Game.Spawn              ( "Actor", "CeoFlashback", 0, 0 )
    Game.SetSprite          ( "CeoFlashback", "Ceo" )
    Game.SendEntityToObject ( "CeoFlashback", "OfficeEntry", 0, 1, -1 )
    Game.SendEntityToObject ( "CeoFlashback", "OfficeDesk", -1, 0, 1.25 )
    Game.Pause              (2)
    Game.CamMoveToObject    ( "OfficeCam2", 4, 1.0, true )
    Game.CamZoom            ( 0.95, 20, false )

    Game.AdviserSay         ( "RiotCeo", "adviser_riot_hostages6")
    Game.PolaroidAtMarker   ( "OfficePolaroid", "campaign/riot/ill_chap4_fileandgun.png", 3 )
    Game.Sound              ( "__RiotRoulette", "Deskdraw" )
    Game.Pause              (3)
 
   -- The CEO picks up the gun, then the file

    Game.GiveEquipment      ( "CeoFlashback", "Clipboard" )
    Game.Pause              (1)
    Game.LoseEquipment      ( "CeoFlashback" )
    Game.Pause              (1)
    Game.GiveEquipment      ( "CeoFlashback", "Gun" )
    Game.Pause              (2)

    -- The ceo then picks up a lighter and sets fire to the clipboard

    Game.LoseEquipment      ( "CeoFlashback" )
    Game.Pause              (1)
    Game.GiveEquipment      ( "CeoFlashback", "Lighter" )

    Game.PolaroidAtMarker   ( "OfficePolaroid", "campaign/riot/ill_chap4_wallace_lightingfolder.png", 3 )
	Game.Sound 				( "__RiotRoulette", "SetsFire" )
    Game.Pause              (3)

    Game.Sound              ( "__RiotRoulette", "RouletteMusic4" )
    Game.AdviserSay         ( "RiotBenedict", "adviser_riot_hostages7")
 
    Game.Hide 				( "Flashback" )
	Game.CamMoveToObject 	( "CanteenInside", 0, 1.0, false )

    Game.HidePolaroid       ( "OfficePolaroid" )

end 


function Riot_SuspiciousFlashback2()

    -- Benedict + henchmen rush in

    Game.Spawn              ( "Actor", "BenedictFlashback", 0, 0 )
    Game.SetSprite          ( "BenedictFlashback", "Benedict" )
    Game.SendEntityToObject ( "BenedictFlashback", "OfficeEntry", 0, 1, -1 )
    Game.SendEntityToObject ( "BenedictFlashback", "OfficeAttack1", 1, 1, 1 )

    Game.Spawn              ( "Actor", "BenedictFlashback2", 0, 0 )
    Game.SetSprite          ( "BenedictFlashback2", "BenedictHenchman1" )
    Game.SendEntityToObject ( "BenedictFlashback2", "OfficeEntry", 0, 1, -1 )
    Game.SendEntityToObject ( "BenedictFlashback2", "OfficeAttack2", 1, 1, 0.8 )
	Game.GiveEquipment 		( "BenedictFlashback2", "Club" )

    Game.Spawn              ( "Actor", "BenedictFlashback3", 0, 0 )
    Game.SetSprite          ( "BenedictFlashback3", "BenedictHenchman2" )
    Game.SendEntityToObject ( "BenedictFlashback3", "OfficeEntry", 0, 1, -1 )
    Game.SendEntityToObject ( "BenedictFlashback3", "OfficeAttack3", 1, 1, 0.9 )
	Game.GiveEquipment 		( "BenedictFlashback3", "Shotgun" )

    Game.LoseEquipment      ( "CeoFlashback" )
    Game.GiveEquipment      ( "CeoFlashback", "Clipboard" )

    Game.Pause              (1)
    Game.Show 				( "Flashback" )
    Game.CamMoveToObject 	( "OfficeCam", 0, 1.0, false )
    Game.CamMoveToObject 	( "OfficeCam2", 3, 1.0, true )
    Game.CamZoom            ( 0.95, 20, false )

    Game.PolaroidAtMarker   ( "OfficePolaroid", "campaign/riot/ill_chap4_wallace_scared.png", 3 )
	Game.Sound 				( "__RiotRoulette", "FolderBurns" )
    Game.Pause              (3)
   
    Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette11b" )
	Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette11c" )

    Game.PolaroidAtMarker   ( "OfficePolaroid", "campaign/riot/ill_chap4_benedict_mob.png", 3 )
    Game.Pause              (3)

    Game.AdviserSay 		( "RiotBenedict", "adviser_riot_roulette11d" )
    
    Game.Sound              ( "__RiotRoulette", "RouletteMusic9" )
    Game.Sound              ( "__RiotRoulette", "Crying1" )


    -- Back to the canteen

    Game.Hide               ( "Flashback" )
    Game.CamMoveToObject    ( "CanteenInside", 0, 1.0, true )
    

    -- Tidy up

    Game.HidePolaroid       ( "OfficePolaroid" )
    Game.HidePolaroid       ( "OfficePolaroid2" )
    
	Game.Remove 			( "BenedictFlashback" )
	Game.Remove 			( "BenedictFlashback2" )
	Game.Remove 			(  "BenedictFlashback3" )
	Game.Remove 			( "CeoFlashback" )
end

