//
//  SpyPersonalView.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal

class SpyPersonalView: PersonalViewInput {
    
    var dataToShow: Data!
    var nameToShow: String!
    var entitiesToBeUpdated: [RecipeEntity]!
    
    func showUserAvatar(_ data: Data) {
        dataToShow = data
    }
    
    func showUserName(_ name: String) {
        nameToShow = name
    }
    
    func updateRecipes(_ entities: [RecipeEntity]) {
        entitiesToBeUpdated = entities
    }
}
