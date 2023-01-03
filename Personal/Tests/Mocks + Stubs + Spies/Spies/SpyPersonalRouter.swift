//
//  SpyPersonalRouter.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal
@testable import Models
@testable import Persistence

class SpyPersonalRouter: PersonalRouterInput {
    
    var apiModel: Models.Recipe!
    var persistenceModel: Persistence.Recipe?
    
    func openRecipeDetailsModule(for recipe: Models.Recipe) {
        apiModel = recipe
    }
    
    func openRecipeFormModule(for recipe: Persistence.Recipe?) {
        persistenceModel = recipe
    }
}
