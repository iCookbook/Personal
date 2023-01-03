//
//  SpyPersonalInteractor.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal

class SpyPersonalInteractor: PersonalInteractorInput {
    
    var userAvatarDidObtained = false
    var userNameDidObtained = false
    var userAvatarDataToBeSaved: Data!
    var userNameToBeSaved: String!
    var favouritesRecipesDidProvided = false
    var personalRecipesDidProvided = false
    
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
    }
    
    func providePersonalRecipes() {
        personalRecipesDidProvided = true
    }
}
