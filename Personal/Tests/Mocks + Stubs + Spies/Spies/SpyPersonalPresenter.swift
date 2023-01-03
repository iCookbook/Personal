//
//  SpyPersonalPresenter.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal

class SpyPersonalPresenter: PersonalInteractorOutput {
    
    var userAvatarData: Data!
    var provideUserAvatarWasCalled = false
    var userName: String!
    var provideUserNameWasCalled = false
    var entities: [RecipeEntity]!
    
    func provideUserAvatar(_ data: Data) {
        userAvatarData = data
        provideUserAvatarWasCalled = true
    }
    
    func provideUserName(_ name: String) {
        userName = name
        provideUserNameWasCalled = true
    }
    
    func provideRecipes(_ entities: [RecipeEntity]) {
        self.entities = entities
    }
}
