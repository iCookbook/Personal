//
//  MockPersonalRouter.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal
@testable import Models
@testable import Persistence

class MockPersonalRouter: PersonalRouterInput {
    
    func openRecipeDetailsModule(for recipe: Models.Recipe) {
    }
    
    func openRecipeFormModule(for recipe: Persistence.Recipe?) {
    }
}
