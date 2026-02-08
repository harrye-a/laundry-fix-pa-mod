
-------------------------------------------------------------------------------
-- Robbery cutscene
-------------------------------------------------------------------------------

function CutsceneHeist()

    --Conviction_HeistCutscene()

    Game.SetMap( "conviction" )
    Game.FadeToBlack(0,true)

    CutsceneHurstSecondVisit()

     Game.FadeUp             (1,false)
     Game.GameOver           ()

end


function FireVolley( attacker, target, numShots, reloadTime, pause, coverMarker, coverOrientationX, coverOrientationY )

    for i = 1, numShots do
        Game.UseWeapon( attacker, target )
        Game.Pause(reloadTime)
    end

    Game.SendEntityToObject( attacker, coverMarker, coverOrientationX, coverOrientationY, -1 )

    Game.Pause(pause)
end


function Conviction_HeistCutscene()
    
    Game.UnlockCollectable("ConvictionHeist")

    Game.SetMap                 ( "heistmap" )
    Game.FadeToBlack            ( 0, false )
    Game.Show                   ( "Flashback" )
	Game.CamMoveToObject        ( "cam1", 0, 1, true )
    Game.FadeUp                 ( 2, false )
    
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic1" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX1" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX2" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX3" )

    
    -- Benedict and Morgan slowly stalk through a shady side alleyway somewhere

	Game.SendEntityToObject     ( "Benedict", "benedict1", 1, 0, 0.3 )
    Game.SendEntityToObject     ( "Morgan", "morgan1", 1, 0, 0.25 )
	Game.CamMoveToObject        ( "cam2", 10, 1, false )

    Game.Pause                  (2)
    Game.AdviserSay             ( "Morgan", "conviction_secondvisit_8")
    Game.Pause                  (3)

    --Game.PolaroidAtMarker       ( "polaroid_approach", "campaign/conviction/ill_chap3_jail0.png", 1 )

    Game.Pause                  (3)
    Game.AdviserSay             ( "Morgan", "conviction_secondvisit_9")

    Game.SendEntityToObject     ( "Benedict", "benedict2", 1, 0, 0.7 )
    Game.SendEntityToObject     ( "Morgan", "morgan2", 1, 0, 0.6 )
	Game.CamMoveToObject        ( "cam3", 5, 1, false )
    Game.SendEntityToObject     ( "Guard 1", "guard1surrender", 0, -1, 0.2 )
    Game.SendEntityToObject     ( "Guard 2", "guard2surrender", 0, -1, 0.2 )
	Game.Pause                  (6)

    Game.Sound                  ( "__ConvictionHeist", "HeistMusic2" )
    Game.AdviserSay             ( "BenedictArmed", "conviction_secondvisit_10" )	
	Game.AdviserSay             ( "BenedictArmed", "conviction_secondvisit_11" )	
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic3" )

    -- benedict and morgan approach the guards

    Game.SendEntityToObject     ( "Benedict", "benedict3", 0, -1, 1 )
    Game.Pause                  (0.2)
    Game.SendEntityToObject     ( "Morgan", "morgan3", 0, -1, 1 )
    Game.Pause                  (1)
	Game.CamMoveToObject        ( "cam4", 1, 1, false )
    Game.Pause                  (1)
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX5" )
    Game.AdviserSay             ( "BenedictArmed", "adviser_conviction_heist8" )

    -- Guards surrender
    
    Game.SendEntityToObject     ( "Guard 1", "guard1surrender", 0, 1, 1 )
    Game.SendEntityToObject     ( "Guard 2", "guard2surrender", 0, 1, 0.6 )
    Game.Pause                  (3)

    -- morgan grabs teh cash bags from the guards

    Game.PolaroidAtMarker       ( "polaroid_grab", "campaign/conviction/ill_chap3_bankrob1.png", 1 )
    Game.AdviserSay             ( "BenedictArmed", "adviser_conviction_heist1" )

    Game.SendEntityToObject     ( "Morgan", "guard1surrender", 0, -1, 1.0 )
    Game.Pause                  ( 1 )
    Game.LoseEquipment          ( "Guard 1" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX6" )
    Game.Pause                  ( 0.5 )
    Game.SendEntityToObject     ( "Morgan", "guard2surrender", 0, -1, 1.0 )
    Game.Pause                  ( 0.5 )
    Game.LoseEquipment          ( "Guard 2" )
    Game.Pause                  ( 0.5 )
    Game.SendEntityToObject     ( "Morgan", "morgan3", 0, -1, 1 )
    Game.Pause                  (2)


    -- Camera move as we hear sirens and skidding tires
    -- Copcar arrives, negotiator gets out
    
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX7" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX8" )

	Game.CamMoveToObject        ( "cam5", 2, 0.7, false )

    Game.SendEntityToObject     ( "CopCar", "copcar1", 0.8, 1, 2.2 )
    Game.Pause                  (3)
	Game.CamMoveToObject        ( "cam5", 3, 1.1, false )
    Game.SendEntityToObject     ( "Police3", "getoutcar1", 1, -1, -1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX9" )
    Game.Pause                  (0.5)
    Game.SendEntityToObject     ( "Police3", "getoutcar1", 0, 1, -1 )


    -- Second car arrives, two cops get out
    -- Cops demand surrender

    Game.SendEntityToObject     ( "CopCar2", "copcar2", 0, 1, 2.2 )
    Game.Pause                  (2)
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX10" )
    Game.SendEntityToObject     ( "Police1", "getoutcar2", 1, -1, -1 )
    Game.Pause                  (0.3)
    Game.SendEntityToObject     ( "Police1", "getoutcar2", 1, 0, -1 )
    Game.SendEntityToObject     ( "Police1", "firingline2", 0, 1, 0.6 )

    Game.SendEntityToObject     ( "Police2", "getoutcar3", -1, 1, -1 )
    Game.Pause                  (0.3)
    Game.SendEntityToObject     ( "Police2", "getoutcar3", 1, 1, -1 )
    Game.SendEntityToObject     ( "Police2", "firingline3", 0, 1, 0.6 )

    -- Morgan and Benedict run for cover behind a car
    -- Cops demand surrender

    Game.SendEntityToObject     ( "Morgan", "morgan4", 1, 0, 1.5 )
    Game.SendEntityToObject     ( "Benedict", "benedict4", 1, 0, 1.5 )

    Game.Pause                  (3)
    Game.PolaroidAtMarker       ( "polaroid_cops", "campaign/conviction/ill_chap3_bankrob2.png", 1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX11" )
    Game.AdviserSay             ( "Detective", "adviser_conviction_heist2" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX12" )


    -- Benedict fires first. Everyone takes cover
    
	Game.CamMoveToObject        ( "cam6", 20, 1, false )
    Game.HidePolaroid           ( "polaroid_cops" )
    
    Game.StopSound              ( "__ConvictionHeist", "HeistSFX2" )
    Game.StopSound              ( "__ConvictionHeist", "HeistSFX7" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX13" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX14" )
    
    FireVolley                  ( "Benedict", "CopCar", 2, 1, 0, "benedict4", 0, 1 )
    Game.SendEntityToObject     ( "Morgan", "morgan4", 0, 1, -1 )
	Game.AdviserSay 			( "MorganArmed", "adviser_conviction_heist2b" )
	Game.Pause                  (1)
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic4" )
    Game.StopSound              ( "__ConvictionHeist", "HeistMusic3" )

    -- Cops return fire
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX15" )
    FireVolley                  ( "Police2", "Benedict", 2, 0.3, 1, "firingline3", 0, 1 )
    Game.AdviserSay             ( "BenedictArmed", "adviser_conviction_heist3" )
    FireVolley                  ( "Police1", "Benedict", 3, 0.3, 1, "firingline2", 0, 1 )


    -- Benedict fires lots, cops shoot back a bit
    
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX16" )
    FireVolley                  ( "Benedict", "CopCar", 4, 1, 0, "benedict4", 0, 1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX17" )
    FireVolley                  ( "Police2", "Benedict", 3, 0.3, 1.5, "firingline3", 0, 1 )


    -- Benedict shouts at Morgan for not firing.
	-- They take cover as the cops blast their car to pieces

    Game.Sound                  ( "__ConvictionHeist", "HeistMusic5" )
    Game.AdviserSay             ( "BenedictArmed", "adviser_conviction_heist4" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX18" )
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic6" )
    Game.PolaroidAtMarker       ( "polaroid_crims", "campaign/conviction/ill_chap3_coweringrobbers.png", 1 )
		
    FireVolley                  ( "Police1", "Benedict", 5, 0.2, 1, "firingline2", 0, 1 )
    FireVolley                  ( "Police2", "Benedict", 3, 0.3, 1, "firingline3", 0, 1 )


    -- Benedict shoots cop

    FireVolley                  ( "Benedict", "Police1", 1, 1, 0, "benedict4", 0, -1 )
	Game.HidePolaroid 			( "polaroid_crims" )
    Game.CamMoveToObject        ( "cam_copclose", 0.0, 1.2, false )
    FireVolley                  ( "Benedict", "Police1", 1, 0, 0, "benedict4", 0, -1 )
    Game.Damage                 ( "Police1", 1, "Benedict" )
    Game.PolaroidAtMarker       ( "polaroid_cops", "campaign/conviction/ill_chap3_bankrob4.png", 1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic7" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX19" )
    Game.Pause                  (3)
    Game.CamMoveToObject        ( "cam6", 0.0, 1, false )
    Game.HidePolaroid           ( "polaroid_cops" )


    -- Cops shoot benedict

    Game.Pause                  (1)
    FireVolley                  ( "Police2", "Benedict", 3, 0.3, 0, "firingline3", 0, 1 )
    Game.Pause                  (2)

    FireVolley                  ( "Police2", "Benedict", 2, 0.3, 0, "firingline3", 0, 1 )
    Game.CamMoveToObject        ( "cam_crimclose", 0.0, 1, false )
    FireVolley                  ( "Police2", "Benedict", 1, 0.0, 0, "firingline3", 0, 1 )
    Game.Damage                 ( "Benedict", 0.6, "Police2" )
    Game.DropEquipment          ( "Benedict" )
	Game.SendEntityToObject 	( "Benedict", "benedict4", 0, 1, -1 )
    Game.PolaroidAtMarker       ( "polaroid_crims", "campaign/conviction/ill_chap3_bankrob5.png", 1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic8" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX20" )
    FireVolley                  ( "Police2", "Benedict", 3, 0.3, 0, "firingline3", 0, 1 )
    --Game.AdviserSay             ( "Benedict", "adviser_conviction_heist6" )
    Game.Pause                  (3)
    Game.CamMoveToObject        ( "cam6", 3, 1.2, false )
    Game.HidePolaroid           ( "polaroid_crims" )


    -- Morgan panics, drops his weapon and surrenders
    
    Game.CamMoveToObject        ( "cam_crimclose", 0.0, 1, false )
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic9" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX21" )
    Game.AdviserSay             ( "MorganArmed", "adviser_conviction_heist10" )
    Game.DropEquipment          ( "Morgan" )

    Game.SendEntityToObject     ( "Police2", "police1", -1, 0, 1 )
    Game.SendEntityToObject     ( "Police3", "detective1", -1, 0, 1 )

    Game.Sound                  ( "__ConvictionHeist", "HeistSFX22" )
    Game.AdviserSay             ( "MorganArmed", "adviser_conviction_heist11" )
    Game.PolaroidAtMarker       ( "polaroid_crims", "campaign/conviction/ill_chap3_bankrob6.png", 1 )
    Game.Sound                  ( "__ConvictionHeist", "HeistMusic10" )
    Game.Sound                  ( "__ConvictionHeist", "HeistSFX23" )
    Game.StopSound              ( "__ConvictionHeist", "HeistSFX1" )

    Game.SendEntityToObject     ( "Police2", "Morgan", -1, 0, 0.1 )
    Game.SendEntityToObject     ( "Police3", "Benedict", -1, 0, 0.1 )

    Game.CamZoom                ( 2.0, 10, false )
	Game.Pause 					(3)
    Game.FadeToBlack            ( 5, true )
    
end

