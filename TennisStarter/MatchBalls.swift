//
//  MatchBalls.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 06/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
import AVFAudio

class MatchBalls {
    private var matchBallsFetched = 0; //keeps track of balls fetched for logic
    
    func newBallsCheck() -> Bool { //performs a new balls check
        var newBalls = false
        if ((Player1.GetGamesWonInMatch() + Player2.GetGamesWonInMatch()) >= (7 + 9*matchBallsFetched)){
            print("Ball count : \(7 + 9*matchBallsFetched)")
            self.matchBallsFetched += 1;
            print("Number of times fetched(Updated): \(matchBallsFetched)") 
            fetchBallsCall(); //play new balls sound
            newBalls = true
        }
        return newBalls
    }
    
    private func fetchBallsCall() {
        //reference needed
        let utterance = AVSpeechUtterance(string: "New Balls please");
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US");
        AVSpeechSynthesizer().speak(utterance);
    }
    func resetMatchBalls(){
        self.matchBallsFetched = 0;
    }
}

let matchBalls = MatchBalls();
