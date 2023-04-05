//
//  Set.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 12/02/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation


class Match {
    private let SetsToWinaMatch = 3; //best of 5
    
    func addSetToPlayer1(){
        Player1.UpdateSetsWon(); //increment sets
    }
    /**
     This method will be called when player 2 wins a point
     */
    func addSetToPlayer2(){
        Player2.UpdateSetsWon(); //increments sets
    }
    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Sets() -> Int {
        return Player1.GetSetsWon()
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Sets() -> Int {
        return Player2.GetSetsWon()
    }
    func player1Won() -> Bool{
        return (Player1.GetSetsWon() == SetsToWinaMatch)
    }
    func player2Won() -> Bool {
        return (Player2.GetSetsWon() == SetsToWinaMatch)
    }
    func matchEnded () -> Bool{
        return(player2Won() || player1Won())
    }
}
let match = Match();
