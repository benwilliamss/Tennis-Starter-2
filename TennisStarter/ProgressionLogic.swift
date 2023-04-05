//
//  MatchLogic.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 02/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
//classes to handle overall match logic

class GameProgressionLogic {
    fileprivate let setWon = SetProgressionLogic ();
    func player1(){//Player 1 wont the game -> Reset points & check if set is won also
        game.addPointToPlayer1();
        set.addGameToPlayer1();
        if (set.player1WonSet())
        {
            setWon.player1()
        }
        matchBalls.newBallsCheck();
    }
    func player2(){ //Player 2 wont the game -> Reset points & check if set is won also
        game.addPointToPlayer2(); //may need a niche case for tiebreak matchwin
        set.addGameToPlayer2();
        if (set.player2WonSet())
        {
            setWon.player2()
        }
        matchBalls.newBallsCheck();//resets points to 0
    }
}

private class SetProgressionLogic { //made private as only used by the PlayerWonGame class & not to be consfused with Set class methods
    func player1 (){
        //set.addGameToPlayer1()
        match.addSetToPlayer1(); //reset sets
        if(match.matchEnded()){ //condition to keep games score when won --> like in the example of this project
            Player1.logGames()//needed for previous games in set label//stores previous labels
            Player2.logGames()
        } //maybe because no call to store previous lables on end game
        else{set.addGameToPlayer1(); } //Resets games to 0
        //usually called in addGameToPlayer
    }
    func player2(){
        //set.addGameToPlayer2()
        match.addSetToPlayer2(); //reset sets
        if(match.matchEnded()){
            Player1.logGames()//needed for previous games in set label//stores previous labels
            Player2.logGames()
        }
        else{set.addGameToPlayer2();}//Resets games to 0
    }
}
let gameWon = GameProgressionLogic()
