//
//  TennisPlayer.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 03/02/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
class Player {
    //Sets and Gets current match values
    private var PointsWon : String =  "0";
    private var SetsWon   : Int =  0;
    private var GamesWon  : Int =  0;
    var previousGamesWon  : String = ""; //needed for previous games in set label
    private var totalGamesWon : Int    = 0;
    //maybe refactor into a player history class
    func GetSetsWon() -> Int{
        return self.SetsWon
    }
    func GetPointsWon() -> String {
        return self.PointsWon
    }
    func GetCurrentGamesWonInSet() -> Int {
        return self.GamesWon
    }
    func UpdatePointsWon(newValue : String){
        //Values are controlled by the addPoints in games so only certain values can update this property
        self.PointsWon = newValue;
    }
    func UpdateGamesWon(newValue : Int){
        print("Update games called")
        if(newValue == 0){
            previousGamesWon += String(GamesWon)
        }; //on reset, store the games
        self.totalGamesWon += (newValue > 0) ? 1 : 0;
        self.GamesWon = (newValue >= 0) ? newValue: 0;
    }
    func UpdateSetsWon(newValue : Int){
        self.SetsWon  = (newValue >= 0) ? newValue: 0;
    }
    func ResetValue() {
        self.PointsWon = "0";
        self.SetsWon   =  0;
        self.GamesWon  =  0;
        previousGamesWon = "";
    }
    func GetGamesWonInMatch() -> Int {
        return totalGamesWon/*(GetCurrentGamesWonInSet() + previousGamesWon.map{Int(String($0)) ?? 0}.reduce(0,+))*/
    }
}

final class PlayerPersistentData { //make a static instance
    var file: URL?;
    init(){
        //initialise path
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
        file = URL(fileURLWithPath: "PlayerLastMatchDataFile", relativeTo: path);
    }
    func Write(){
        //if let file = fileURL {
        let player1D = "Player1 Data Last Match \nsets: \(Player1.GetSetsWon()) games: \(Player1.GetCurrentGamesWonInSet()) points: \(Player1.GetPointsWon())";
        let player2D = "\nPlayer2 Data Last Match \nsets: \(Player2.GetSetsWon()) games: \(Player2.GetCurrentGamesWonInSet()) points: \(Player2.GetPointsWon())";
        let dataToAddToFile = player1D + player2D;

        if let data = dataToAddToFile.data(using: .utf8){
               do {
                  try data.write(to: file!);
                   print("Plyer data Written")
               }
               catch {
                  print("Error unable to writep player 1 data!")
               }
            };
        }
    
    
    func Read() -> String {
        /*let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
        let file = URL(fileURLWithPath: "myFile", relativeTo: path);*/
        var fileInfo : String = "Unable to read the file";
            do {
             // Get the saved data
                let savedData = try Data(contentsOf: file!)
             // Convert the data back into a string
                if let savedString = String(data: savedData, encoding: .utf8) {
                    print(savedString)
                    fileInfo = savedString;
                }
            }
            catch {
             // Catch any errors
                print("Unable to read the file")
            }
        return fileInfo
    }
}
let Player1 = Player(); //global player instance
let Player2 = Player();





