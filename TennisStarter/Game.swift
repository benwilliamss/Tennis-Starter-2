//from TieBreak import;

class Game {
    /*
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    private var GameOutcome  : [String] = ["0","15","30","40", "A", "G"];
    
    func addPointToPlayer1(){
            var newScore : String?;
            if(tieBreak.Check()){
                newScore =  "0";
                if (Int(Player1.GetPointsWon()) ?? -1) != -1 { //handle nil values
                    newScore = String(Int(Player1.GetPointsWon())! + 1);
                }
            }
            else {
                var nextScoreIndex : Int = GameOutcome.firstIndex(of:Player1.GetPointsWon()) ?? 0;
                nextScoreIndex += ((nextScoreIndex+1) < GameOutcome.count) ? 1 : 0;
                newScore = GameOutcome[nextScoreIndex];
                if(Player2.GetPointsWon() == "A" && newScore == "A")
                {
                    newScore = "40";
                    Player2.updatePointsWon(newValue: "40"); //equal
                }
            }
            Player1.updatePointsWon(newValue: newScore!);
    }
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
            var newScore : String?;
            if(tieBreak.Check()){
                newScore =  "0";
                if (Int(Player2.GetPointsWon()) ?? -1) !=  -1 {
                    newScore = String(Int(Player2.GetPointsWon())! + 1);
                }
            }
            else {
                var nextScoreIndex : Int = GameOutcome.firstIndex(of:Player2.GetPointsWon()) ?? 0;
                nextScoreIndex += ((nextScoreIndex+1) < GameOutcome.count) ? 1 : 0;
                newScore = GameOutcome[nextScoreIndex];
                if(Player1.GetPointsWon() == "A" && newScore == "A")
                {
                    newScore = "40";
                    Player1.updatePointsWon(newValue: "40"); //equal
                }
            }
            Player2.updatePointsWon(newValue: newScore!);
    }

    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        return Player1.GetPointsWon()
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        return Player2.GetPointsWon()
    }
    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        var result: Bool?;
        if (tieBreak.Check()){
            result = (Player1.GetPointsWon() >= tieBreak.GetPointsToWin()) &&
            (Int(Player1.GetPointsWon()) ?? 0) - (Int(Player2.GetPointsWon()) ?? 0) >= tieBreak.GetPointMargin();
        }
        else {
            let gamePlayer1Index = (GameOutcome.firstIndex(of:Player1.GetPointsWon()) ?? 0);
            let gamePlayer2Index = (GameOutcome.firstIndex(of:Player2.GetPointsWon()) ?? 0);
            result = (gamePlayer1Index > 3) //past "40"
            && ((gamePlayer1Index - gamePlayer2Index) >= 2);//2 margin
        }
        return result!
    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        var result: Bool?;
        if (tieBreak.Check()){
            result = (Player2.GetPointsWon() >= tieBreak.GetPointsToWin()) &&
            (Int(Player2.GetPointsWon()) ?? 0) - (Int(Player1.GetPointsWon()) ?? 0) >= tieBreak.GetPointMargin();
        }
        else {
            let gamePlayer1Index = GameOutcome.firstIndex(of:Player1.GetPointsWon()) ?? 0;
            let gamePlayer2Index = GameOutcome.firstIndex(of:Player2.GetPointsWon()) ?? 0;
            result = (gamePlayer2Index > 3) //past "40"
            && ((gamePlayer2Index - gamePlayer1Index) >= 2); //2 margin
        }
        return result!
    }
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        //check if the game is complete, i.e if the player.GetPointsWon == "End"
        return player1Won()  || player2Won()
    }
    
    /**
     If player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     */
    func gamePointsForPlayer1() -> Int{
        let currentPointsStr = Player1.GetPointsWon();
        let Player1CurrentPointsInt : Int =  (GameOutcome.firstIndex(of: currentPointsStr) ?? 0);  //find index/Int of score
        let Player2CurrentPointsInt  : Int =  (GameOutcome.firstIndex(of: Player2.GetPointsWon()) ?? 0); //find index/Int of score
        addPointToPlayer1() //add points to determine win
        let result = player1Won() //did the player win?
        Player1.updatePointsWon(newValue: currentPointsStr) //restore previous value
        return (result) ? (Player1CurrentPointsInt - Player2CurrentPointsInt) : 0;
    }
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        let currentPointsStr = Player2.GetPointsWon();
        let Player2CurrentPointsInt : Int =  (GameOutcome.firstIndex(of: currentPointsStr) ?? 0); //offset by 0 index by 1
        let Player1CurrentPointsInt  : Int =  (GameOutcome.firstIndex(of: Player1.GetPointsWon()) ?? 0); //offset by 0 index by 1
        addPointToPlayer2() //add points
        let result = player2Won() //did the player win?
        Player2.updatePointsWon(newValue: currentPointsStr) //restore previous value
        return (result) ? (Player2CurrentPointsInt - Player1CurrentPointsInt) : 0;
    }
}

let game = Game();
