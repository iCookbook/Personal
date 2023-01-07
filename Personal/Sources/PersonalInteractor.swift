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
    
    /// Obtains user avatar from UserDefaults and provides it to presenter.
    func obtainUserAvatar() {
        guard let data = UserDefaults.userAvatar else { return } // do nothing
        presenter?.provideUserAvatar(data)
    }
    
    /// Obtains username from UserDefaults and provides it to presenter.
    func obtainUserName() {
        guard let name = UserDefaults.userName else { return } // do nothing
        presenter?.provideUserName(name)
    }
    
    /// Saves user avatar to UserDefaults.
    ///
    /// - Parameter data: avatar image's raw data.
    func saveUserAvatar(_ data: Data) {
        UserDefaults.userAvatar = data
    }
    
    /// Saves username to UserDefaults.
    ///
    /// - Parameter name: username to save
    func saveUserName(_ name: String) {
        UserDefaults.userName = name
    }
    
    /// Provides favourite recipes from UserDefaults and converts it in `[RecipeEntity]`.
    func provideFavouritesRecipes() {
        let entities = UserDefaults.favouriteRecipes.map {
            RecipeEntity(title: $0.label ?? "", subtitle: $0.description ?? "", imageData: $0.imageData ?? Images.sampleRecipeImage.pngData()!, source: $0)
        }
        presenter?.provideRecipes(entities)
    }
    
    /// Provides personal recipes from Core Data and converts it in `[RecipeEntity]`.
    func providePersonalRecipes() {
        let recipes = coreDataManager.fetchRecipes() ?? []
        let entities = recipes.map {
            RecipeEntity(title: $0.name,
                         subtitle: $0.comment ?? "\(Texts.Discover.cookingTime): \($0.cookingTime) \(Texts.RecipeDetails.minutes(count: Int($0.cookingTime))), \(Texts.Discover.servingsCount.lowercased()): \($0.numberOfServings)",
                         imageData: $0.imageData ?? Images.sampleRecipeImage.pngData()!,
                         source: $0)
        }
        presenter?.provideRecipes(entities)
    }
    
    func provideCoreDataManager(with recipe: Recipe?) {
        presenter?.didProvideCoreDataManager(coreDataManager, recipe: recipe)
    }
}
