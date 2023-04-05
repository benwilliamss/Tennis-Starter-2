//
//  Tie_Break.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 07/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation

class TieBreak {
    var newTieBreak                  : Bool   = true;
    private let _tieBreakPointWin    : String = "7";
    private let _tieBreakPointMargin : Int    = 2;

    func Check() -> Bool {
        return  TieBreakButNotGame5() || Game5TieBreak()
    }
    private func Game5TieBreak() -> Bool {
       return (Player1.GetGamesWon() == 12 && Player2.GetGamesWon() == 12) &&
                    (Player1.GetSetsWon() == 2 && Player2.GetSetsWon() == 2)
    }
    
    private func TieBreakButNotGame5() -> Bool{
        return (Player1.GetGamesWon() == 6 && Player2.GetGamesWon() == 6) &&
                !(Player1.GetSetsWon() == 2 && Player2.GetSetsWon() == 2)
    }
    func GetPointsToWin() -> String {
        return _tieBreakPointWin
    }
    func GetPointMargin() -> Int {
        return _tieBreakPointMargin
    }
    func TieBreakSetWonSet5() -> Bool {
        //used to determine tie break set win - Not for game 5
       return
        ((Player1.GetGamesWon() == 13 && Player2.GetGamesWon() == 12) ||
         (Player1.GetGamesWon() == 12 && Player2.GetGamesWon() == 13)) &&
            (Player1.GetSetsWon() == 2 && Player2.GetSetsWon() == 2)
    }
    func TieBreakSetWonNotSet5() -> Bool{
        //used to determine tie break set win - for game 5
            return  ((Player1.GetGamesWon() == 7 &&         Player2.GetGamesWon() == 6) ||
                     (Player1.GetGamesWon() == 6 && Player2.GetGamesWon() == 7)) &&
                    !(Player1.GetSetsWon() == 2 && Player2.GetSetsWon() == 2)
        }
}
let tieBreak = TieBreak();
