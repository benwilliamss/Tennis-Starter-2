//
//  Set.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 13/02/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//


import Foundation
class Set {
    //games tracking logic
    private let GamesToWinaSet = 6;
    
    func addGameToPlayer1(){
        if (player1WonSet()) { //end of set?
            Player2.UpdateGamesWon(); //reset to games to 0 for player 2
        }
        Player1.UpdateGamesWon();
    }

    func addGameToPlayer2(){
        /*var newGamesValue = 1; /*Player2.GetCurrentGamesWonInSet();
        newGamesValue+=1;*/
        if (player2WonSet()) {
            newGamesValue = 0;
            Player1.UpdateGamesWon(enter0ToReset: 0);
        }*/
        if (player2WonSet()) { //end of set?
            Player1.UpdateGamesWon(); //reset to games to 0 for player 1
        }
        Player2.UpdateGamesWon();
    }
    
    func player1Games() -> Int {
        return Player1.GetCurrentGamesWonInSet()
    }
    
    func player2Games() -> Int {
        return Player2.GetCurrentGamesWonInSet()
    }
    
    func player1WonSet() -> Bool{
        return  (Player1.GetCurrentGamesWonInSet()  >= GamesToWinaSet
                && (Player1.GetCurrentGamesWonInSet() - Player2.GetCurrentGamesWonInSet() >= 2))
        ||  tieBreak.TieBreakSetWonNotSet5() || tieBreak.TieBreakSetWonSet5()
    }
    func player2WonSet() -> Bool{
        return (Player2.GetCurrentGamesWonInSet() >= GamesToWinaSet
                && (Player2.GetCurrentGamesWonInSet() - Player1.GetCurrentGamesWonInSet() >= 2))
        ||  tieBreak.TieBreakSetWonNotSet5() || tieBreak.TieBreakSetWonSet5()
    }
    func complete () -> Bool {
        return player2WonSet()  || player1WonSet()
    }
}

let set = Set();
