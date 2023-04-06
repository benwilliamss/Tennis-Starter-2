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
        let player1GamesWon = player1History.getPreviousGamesWonInMatch() + Player1.GetGamesWon();//Games won in the match
        let player2GamesWon = player2History.getPreviousGamesWonInMatch() + Player2.GetGamesWon();//Games won in the match
        if ((player1GamesWon + player2GamesWon) >= (7 + 9*matchBallsFetched)){
            self.matchBallsFetched += 1;
            fetchBallsCall(); //play new balls sound
            newBalls = true
        }
        return newBalls
    }
    
    private func fetchBallsCall() {
        /*Swift text to speech. (n.d.). Stack Overflow. Retrieved April 5, 2023, from https://stackoverflow.com/questions/42023612/swift-text-to-speech*/
        let utterance = AVSpeechUtterance(string: "New Balls please");
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US");
        AVSpeechSynthesizer().speak(utterance);
    }
    func resetBallsFetched(){ //reset count e.g. new match etc.
        self.matchBallsFetched = 0;
    }
}

let matchBalls = MatchBalls();
