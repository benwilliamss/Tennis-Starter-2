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
        Player1.incrementGamesWon();
    }

    func addGameToPlayer2(){
         Player2.incrementGamesWon()
    }
    
    func player1Games() -> Int {
        return Player1.GetGamesWon()
    }
    
    func player2Games() -> Int {
        return Player2.GetGamesWon()
    }
    
    func player1WonSet() -> Bool{
        return  (Player1.GetGamesWon()  >= GamesToWinaSet
                && (Player1.GetGamesWon() - Player2.GetGamesWon() >= 2))
        ||  tieBreak.TieBreakSetWonNotSet5() || tieBreak.TieBreakSetWonSet5()
    }
    func player2WonSet() -> Bool{
        return (Player2.GetGamesWon() >= GamesToWinaSet
                && (Player2.GetGamesWon() - Player1.GetGamesWon() >= 2))
        ||  tieBreak.TieBreakSetWonNotSet5() || tieBreak.TieBreakSetWonSet5()
    }
    func complete () -> Bool {
        return player2WonSet()  || player1WonSet()
    }
}

let set = Set();
