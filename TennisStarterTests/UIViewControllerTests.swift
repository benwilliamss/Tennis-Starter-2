//
//  UIViewControllerTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 28/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import XCTest
@testable import TennisStarter

class ViewControllerTests: XCTestCase {
    var game : Game!
    var set  : Set!
    var controllerT = ViewController()
    var mirror: Mirror!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        storyboard.instantiateInitialViewController()
        //storyController.loadViewIfNeeded()
        controllerT.loadView()

        //controllerT = ViewController();
        //controllerT.loadViewIfNeeded()
        //mirror = Mirror(reflecting: controllerT!)
        set = Set()
        mirror = Mirror(reflecting: set!)
        game = Game()
        mirror = Mirror(reflecting: game!)
    }
    
    //test restart button
    
    func testRestartButton(){
        _ = controllerT.view
        for _ in 0...1 {
            game.addPointToPlayer1()
            set.addGameToPlayer2()
            match.addSetToPlayer2()
        }
        XCTAssertEqual(game.player1Score(),"30" , "Test if a score is present before reset")
        XCTAssertEqual(set.player2Games(), 2, "Test if other scores are present before reset")
        XCTAssertEqual(match.player2Sets(), 2, "Test if other scores are present before reset")
        let buttonPress = UIButton();
        controllerT.restartPressed(buttonPress);
        XCTAssertEqual(game.player1Score(),"0" , "Test if a score is present before reset")
        XCTAssertEqual(set.player2Games(), 0, "Test if other scores are present before reset")
        XCTAssertEqual(match.player2Sets(), 0, "Test if other scores are present before reset")
    }
    //test player 1 button
    
    //test player 2 button
    
    //test write persistent data
    
    //test read persistent data
    
    //check player 1 stats
    
    //check player 2 stats
    
    //test the buttons are disabled on a game win
    
    //test when a UI pop up is displayed for schedule match
}

