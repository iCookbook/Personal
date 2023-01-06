//
//  SpyPersonalInteractor.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Personal
@testable import Persistence

class SpyPersonalInteractor: PersonalInteractorInput {
    
    var userAvatarDidObtain = false
    var userNameDidObtain = false
    var userAvatarDataToBeSave: Data!
    var userNameToBeSaved: String!
    var favouritesRecipesDidProvide = false
    var personalRecipesDidProvide = false
    var coreDataManagerFlagDidProvide = false
    
    var expectation: XCTestExpectation!
    
    func obtainUserAvatar() {
        userAvatarDidObtain = true
    }
    
    func obtainUserName() {
        userNameDidObtain = true
    }
    
    func saveUserAvatar(_ data: Data) {
        userAvatarDataToBeSave = data
    }
    
    func saveUserName(_ name: String) {
        userNameToBeSaved = name
    }
    
    func provideFavouritesRecipes() {
        favouritesRecipesDidProvide = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    func providePersonalRecipes() {
        personalRecipesDidProvide = true
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
    
    func provideCoreDataManager(with recipe: Recipe?) {
        coreDataManagerFlagDidProvide = true
    }
}
