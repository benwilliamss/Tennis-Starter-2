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
        var newGamesValue = Player1.GetCurrentGamesWonInSet();
        newGamesValue+=1;
        if (player1WonSet()) {
            newGamesValue = 0;
            Player2.UpdateGamesWon(newValue: 0);
        }
        Player1.UpdateGamesWon(newValue: newGamesValue);
    }

    func addGameToPlayer2(){
        var newGamesValue = Player2.GetCurrentGamesWonInSet();
        newGamesValue+=1;
        if (player2WonSet()) {
            newGamesValue = 0;
            Player1.UpdateGamesWon(newValue: 0);
        }
        Player2.UpdateGamesWon(newValue: newGamesValue);
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
