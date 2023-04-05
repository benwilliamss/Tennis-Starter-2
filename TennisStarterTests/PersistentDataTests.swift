//
//  PersistentDataTests.swift
//  TennisStarterTests
//
//  Created by BEN  WILLIAMS on 05/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//
import XCTest
import Foundation
class PersistentDataTests: XCTestCase {
    
    var game   : Game!
    var set    : Set!
    var match  :  Match!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        game = Game()
        set = Set()
        match = Match()
        mirror = Mirror(reflecting: game!)
        mirror = Mirror(reflecting: set!)
        mirror = Mirror(reflecting: match!)
    }
    
    func testDataOnStartUp(){
        
    }
    func testReadWriteData(){
        for _ in 1...3{
            game.addPointToPlayer2()
            game.addPointToPlayer1()
            set.addGameToPlayer1()
            set.addGameToPlayer2()
            match.addSetToPlayer1()
        }
        PlayerPersistentData().Write()
        print("Data read : \(PlayerPersistentData().Read())")
        XCTAssertEqual(PlayerPersistentData().Read(), "", "Read the data from storage")
    }
    func testPowerDownRead(){
        //testReadWriteData()
        //power down --> Unable to find a method for this
        // XCTAssertEqual(PlayerPersistentData().Read(), <#T##expression2: Equatable##Equatable#>, <#T##message: String##String#>) PlayerPersistentData().Read()
        
    }
}
