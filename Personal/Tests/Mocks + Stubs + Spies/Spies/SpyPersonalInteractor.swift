//
//  SpyPersonalInteractor.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Personal

class SpyPersonalInteractor: PersonalInteractorInput {
    
    var userAvatarDidObtained = false
    var userNameDidObtained = false
    var userAvatarDataToBeSaved: Data!
    var userNameToBeSaved: String!
    var favouritesRecipesDidProvided = false
    var personalRecipesDidProvided = false
    
    var expectation: XCTestExpectation!
    
    func obtainUserAvatar() {
        userAvatarDidObtained = true
    }
    
    func obtainUserName() {
        userNameDidObtained = true
    }
    
    func saveUserAvatar(_ data: Data) {
        userAvatarDataToBeSaved = data
    }
    
    func saveUserName(_ name: String) {
        userNameToBeSaved = name
    }
    
    func provideFavouritesRecipes() {
        favouritesRecipesDidProvided = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    func providePersonalRecipes() {
        personalRecipesDidProvided = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
}
