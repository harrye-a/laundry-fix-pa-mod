

function CutsceneRiotIntro()

	Game.FadeToBlack	(0,true)
    Game.SetMap			( "riot" )
	Game.Hide 			( "FogOfWar" )
	Game.Hide 			( "RiotMusic" )
	Game.Hide			( "WorldSounds" )

    Riot_SetupPrisoners()
    Riot_StartFire()

    Game.Pause(1)

    Riot_NewsBroadcast()
    
    Game.FadeToBlack    ( 3, true )
    Game.GameOver       ()

end 


function Riot_NewsBroadcast()

    -- Breaking news intro
    
    Game.UnlockCollectable("RiotIntro")

	Game.Sound              ( "__RiotIntro", "NewsIntro" ) 	
	Game.Pause 				(0.3)
	Game.CamMoveToObject    ( "NewsCamera", 0, 0.2, true )
	Game.PolaroidAtMarker   ( "NewsBackdrop", "campaign/riot/breaking-news.png", 1 ) 
	Game.FadeUp             ( 0, false ) 
    Game.CamZoom 			( 2.0, 5.8, true )
	Game.CamZoom 			( 1.8, 0.2, true )
	
    Game.Sound              ( "__RiotIntro", "NewsLoop" ) 	
 	Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_02" )

     
    -- CEO charles wallace

    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/riot/ill_chap4_wallacePR.png", 0 ) 
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_1" )

    --  Several Judges arrested
 
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_2" )
    Game.HidePolaroid 		( "NewsPolaroid1" )
    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/riot/ill_chap4_judge1.png", 0 ) 
    Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/riot/ill_chap4_judge2.png", 0 ) 
 	Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_3" )

 	Game.HidePolaroid 		( "NewsPolaroid1" )
    Game.HidePolaroid 		( "NewsPolaroid2" )

    -- Benedict ring leader

    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/conviction/ill_chap3_BenedictMugshot.png", 0 )
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_8" )

 	-- Mafia family

    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_4" )   

    Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/food/ill_mafia_7.png", 0 )
    --Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/riot/ill_chap4_arguing_benedict.png", 0 ) 
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_5" )

 	Game.HidePolaroid 		( "NewsPolaroid1" )
    Game.HidePolaroid 		( "NewsPolaroid2" )

    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/riot/ill_chap4_7.png", 0 ) 
    Game.AdviserSay         ( "NewsReader", "adviser_riot_newsintroheller_1" )
    Game.PolaroidAtMarker   ( "NewsPolaroid2", "campaign/riot/ill_chap4_8.png", 0 ) 
    Game.AdviserSay         ( "Mayor", "adviser_riot_newsintroheller_2" )
    Game.AdviserSay         ( "Mayor", "adviser_riot_newsintroheller_3" )
    Game.AdviserSay         ( "Mayor", "adviser_riot_newsintroheller_4" )
    
    -- The deputy, ie you

    Game.HidePolaroid       ( "NewsPolaroid1" )
    Game.HidePolaroid       ( "NewsPolaroid2" )

    Game.PolaroidAtMarker   ( "NewsPolaroid1", "campaign/riot/ill_chap4_mysteriousman.png", 0 ) 
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_6" )
    Game.AdviserSay			( "NewsReader", "adviser_riot_newsintro_7" )


    -- News outro jingle + cam pullout on carnage

    Game.Sound              ( "__RiotIntro", "NewsIntro" ) 
    Game.StopSound          ( "__RiotIntro", "NewsLoop" )

	Game.Show				( "WorldSounds" )
    Game.Pause              (0.7)
      
    -- Spawn a guard in max sec to die

     Game.Spawn              ( "Guard", "RedShirt", 0, 0 )
     Game.SendEntityToObject ( "RedShirt", "MarkerRedshirt", 0, 1, -1 )

     Game.Spawn              ( "Guard", "RedShirt2", 0, 0 )
     Game.SendEntityToObject ( "RedShirt2", "MarkerRedshirt", 0, 1, -1 )

    -- Quick flash through several super violent prison riot shots
    
    Game.CamMoveToObject    ( "IntroClose1", 0, 0.8, true ) 
    Game.HidePolaroid       ( "NewsPolaroid1" )
    Game.HidePolaroid       ( "NewsBackdrop" )
    Game.CamZoom            (0.9, 5, false )
    Game.Pause              (1.3)
 
    Game.PolaroidAtMarker   ( "PolaroidClose2", "campaign/riot/ill_chap4_10b.png", 1 )
    Game.CamMoveToObject    ( "IntroClose2", 0.2, 1.0, true )
    Game.CamZoom            (0.9, 5, false )
    Game.Pause              (1.3)
   
    Game.CamMoveToObject    ( "IntroClose4", 0.2, 1.0, true )
    Game.HidePolaroid       ( "PolaroidClose2" )
    Game.CamZoom            (0.9, 5, false )
    Game.Pause              (1.3)
    
    Game.CamMoveToObject    ( "IntroClose3", 0.2, 0.8, true )
    Game.Pause              (0.2)
    Game.CamZoom            (1.3, 1.0, true)
    
    Game.CamMoveToObject    ( "IntroFar", 0.2, 1.0, true )
    Game.Pause              (2.0)
    
    Game.Show 				( "FogOfWar" )

end

