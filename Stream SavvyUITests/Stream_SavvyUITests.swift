//
//  Stream_SavvyUITests.swift
//  Stream SavvyUITests
//
//  Created by Carl Lewis on 11/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import XCTest

class Stream_SavvyUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCUIApplication().textFields["Email"].tap()
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["On Demand"].tap()
        snapshot("1OnDemand")
        
        let firstChild = app.collectionViews.cells.element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
            app.buttons["Watch Episodes"].tap()
            snapshot("3Episodes")
            app.navigationBars["Stream_Savvy.EpisodeCollectionView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            
            
            app.navigationBars["Stream_Savvy.ContentDetailView"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
            
        }
        
        tabBarsQuery.buttons["Live"].tap()
        snapshot("4Live")
        
        let favoritesButton = app.tabBars.buttons["Favorites"]
        favoritesButton.tap()
        
        sleep(5)
        
        snapshot("5Favorites")
        
        app.navigationBars["Stream_Savvy.FavoritesView"].buttons["Search"].tap()
        
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("orange")
        
        
        sleep(5)
        snapshot("7Search")
        
    }
    
}
