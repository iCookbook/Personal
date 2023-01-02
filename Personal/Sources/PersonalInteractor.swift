//
//  PersonalInteractor.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//  

import Foundation
import Persistence
import Resources

final class PersonalInteractor {
    weak var presenter: PersonalInteractorOutput?
    let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension PersonalInteractor: PersonalInteractorInput {
    
    func obtainUserAvatar() {
        guard let data = UserDefaults.userAvatar else { return } // do nothing
        presenter?.provideUserAvatar(data)
    }
    
    func obtainUserName() {
        guard let name = UserDefaults.userName else { return } // do nothing
        presenter?.provideUserName(name)
    }
    
    func saveUserAvatar(_ data: Data) {
        UserDefaults.userAvatar = data
    }
    
    func saveUserName(_ name: String) {
        UserDefaults.userName = name
    }
    
    func provideFavouritesRecipes() {
        let entities = UserDefaults.favouriteRecipes.map {
            RecipeEntity(title: $0.label ?? "", subtitle: $0.description ?? "", imageData: $0.imageData ?? Data())
        }
        presenter?.provideRecipes(entities)
    }
    
    func providePersonalRecipes() {
        let recipes = coreDataManager.fetchRecipes() ?? []
        let entities = recipes.map {
            RecipeEntity(title: $0.name,
                         subtitle: $0.comment ?? "\(Texts.Discover.cookingTime): \($0.cookingTime) \(Texts.RecipeDetails.minutes(count: Int($0.cookingTime))), \(Texts.Discover.servingsCount.lowercased()): \($0.numberOfServings)",
                         imageData: $0.imageData ?? Images.sampleRecipeImage!.pngData()!)
        }
        presenter?.provideRecipes(entities)
    }
}
