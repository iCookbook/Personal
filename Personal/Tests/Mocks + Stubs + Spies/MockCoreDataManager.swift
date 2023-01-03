//
//  MockCoreDataManager.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import Persistence

class MockCoreDataManager: CoreDataManagerProtocol {
    
    func fetchRecipes() -> [Recipe]? {
        nil
    }
    
    func createRecipe(with data: RecipeData) {
    }
    
    func update(_ recipe: Recipe, with data: RecipeData) {
    }
    
    func delete(_ recipe: Recipe) {
    }
    
    func createStep(with data: StepData, for recipe: Recipe) {
    }
    
    func update(_ step: Step, with data: StepData) {
    }
    
    func delete(_ step: Step) {
    }
}
