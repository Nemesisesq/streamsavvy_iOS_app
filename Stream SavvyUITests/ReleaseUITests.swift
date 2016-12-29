//
//  ReleaseUITests.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/27/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import XCTest

class ReleaseUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOnDemand() {
        
        
        let app = XCUIApplication()
        let cells = app.collectionViews.cells
        let firstCell = cells.element(boundBy: 0)
        
        firstCell.tap()
        
        app.buttons["Watch Episodes"].tap()
        
        let seasons = app.collectionViews.cells
        
        
        sleep(10)
        

            assert(seasons.count > 0)

//        
//        
//        
        let tableCells = app.tables.cells
        let epiCell = tableCells.element(boundBy: 0)
//
        epiCell.tap()
        app.navigationBars["Stream_Savvy.EpisodeCollectionView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        
        
        
        
        let x = app.buttons["ADD TO FAVORITES"]; if x != nil{
            x.tap()
        } else {
            app.buttons["Remove From Favorites"].tap()
            
        }
        
        
        
        
        app.navigationBars["Stream_Savvy.ContentDetailView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        
        
        
        
        
        
        
    }
    
    func testLive(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Live"].tap()
        sleep(2)
        
        let tableCells = app.tables.cells
        
        let firstCell = tableCells.element(boundBy: 0)
        sleep(2)
        firstCell.tap()
        
        let backButton = app.navigationBars["Stream_Savvy.LiveDetailsView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        
        backButton.tap()
        
    }
    
    func testFavorites(){
        XCUIApplication().tabBars.buttons["Favorites"].tap()
        
        let app = XCUIApplication()
        app.tabBars.buttons["Favorites"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        
    }
}
