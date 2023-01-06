//
//  SpyPersonalView.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Personal

class SpyPersonalView: PersonalViewInput {
    
    var dataToShow: Data!
    var nameToShow: String!
    var entitiesToBeUpdated: [RecipeEntity]!
    var selectedTab: Tabs!
    
    var expectation: XCTestExpectation!
    
    func showUserAvatar(_ data: Data) {
        dataToShow = data
    }
    
    func showUserName(_ name: String) {
        nameToShow = name
    }
    
    func updateRecipes(for selectedTab: Tabs, _ entities: [RecipeEntity]) {
        self.selectedTab = selectedTab
        entitiesToBeUpdated = entities
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
}
