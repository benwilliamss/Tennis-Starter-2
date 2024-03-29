//
//  MatchLogic.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 02/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
//classes to handle overall match logic
class GameProgressionLogic { //handles the logic to progress the game display and scores
    fileprivate let setProgression = SetProgressionLogic (); //composition to use class functionality
    func player1(){//Player 1 wont the game -> Reset points & check if set is won also
        //game.addPointToPlayer1();
        if(game.player1Won()){
            Player1.resetPointsValue() //reset value on game won
            set.addGameToPlayer1(); //player won game
            player1History.incrementTotalGameWon()
            setProgression.player1() //checks set progression
            if (!match.matchEnded()){
                Player2.resetPointsValue() //don't reset player score at end game
            }
            matchBalls.newBallsCheck(); //match ball check at the end of each game
        }
    }
    func player2(){ //Player 2 wont the game -> Reset points & check if set is won also
        //game.addPointToPlayer2(); //may need a niche case for tiebreak matchwin
        if(game.player2Won()){ //player 2 won
            Player2.resetPointsValue() //refactor into progression logic??
            set.addGameToPlayer2();
            player2History.incrementTotalGameWon()
            setProgression.player2() //checks set progression
            if (!match.matchEnded()){ //retain points if match has ended - dont update
                Player1.resetPointsValue()
            }
            matchBalls.newBallsCheck(); //match ball check at the end of each game
        }
    }
}

private class SetProgressionLogic { //made private as only used by the PlayerWonGame class & not to be consfused with Set class methods
    //handles the progression of sets and end match functions
    func player1 (){ //player 1 won set
        if (set.player1WonSet()) //check if player 1 has won a set
        {
            match.addSetToPlayer1(); //add set
            player1History.incrementTotalSetsWon()
            player1History.logGames(GamesWon: Player1.GetGamesWon()) //store game labels
            player2History.logGames(GamesWon: Player2.GetGamesWon())
            if(!match.matchEnded()){ //match still playing?
                Player1.resetGamesValue()//reset game values
                Player2.resetGamesValue()
            }
        }
    }
    func player2(){ //player2 won set
        if (set.player2WonSet()) //check if player 1 has won a set
        {
            match.addSetToPlayer2(); //add set
            player2History.incrementTotalSetsWon()
            player1History.logGames(GamesWon: Player1.GetGamesWon()) //store game labels
            player2History.logGames(GamesWon: Player2.GetGamesWon())
            if(!match.matchEnded()){ //match still playing?
                Player1.resetGamesValue() //reset game values
                Player2.resetGamesValue()
            }
        }
    }
}
let GameProgression = GameProgressionLogic()

