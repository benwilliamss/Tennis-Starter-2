//
//  Serving.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 07/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
import AVFAudio


class Serve  {
    private var Player1Serving   = true; //player 1 serves first
    private var servingGameStart = true; //handle tie break serves - matches the start serve
    private var serveAlternate = 0; //handles alternating tiebreak serving
    
    func NextServe(newMatch : Bool) -> Bool {
        let previousServe = Player1Serving; //serve value at the start
        if(newMatch){ Player1Serving     =  true } //player one serves first
        else if (tieBreak.Check() && tieBreak.newTieBreak){
            Player1Serving     =  !Player1Serving;
            tieBreak.newTieBreak = false; //start of the tie break
        }
        else if(game.complete()) {
            Player1Serving     = !servingGameStart;
            servingGameStart   = Player1Serving;
            tieBreak.newTieBreak = true; //reset tie break values
            serveAlternate = 0; //reset tie break values
        }
        else if(tieBreak.Check() && !tieBreak.newTieBreak){ //tie break everytwo points
            serveAlternate += 1;
            Player1Serving =  ((serveAlternate % 2) == 0) ?  !Player1Serving : Player1Serving; //Alternate serve every 2
        }
        if (previousServe != Player1Serving){ //new server?
            ServeSound();
        }
        return  Player1Serving
    }
    private func ServeSound(){
        /* code adapted from (Ios - Creating and Playing a Sound in Swift, n.d.)*/
        if let url = Bundle.main.url(forResource: "Sound", withExtension: "wav"){
            var sound  : SystemSoundID = 0; //try put this in
            AudioServicesCreateSystemSoundID(url as CFURL, &sound);
            AudioServicesPlaySystemSound(sound)
        }
    }
}

let serve = Serve();
