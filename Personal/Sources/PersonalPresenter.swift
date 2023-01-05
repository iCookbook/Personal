//
//  PersonalPresenter.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import Models
import Persistence
import Logger

final class PersonalPresenter {
    weak var view: PersonalViewInput?
    weak var moduleOutput: PersonalModuleOutput?
    
    // MARK: - Private Properties
    
    private let router: PersonalRouterInput
    private let interactor: PersonalInteractorInput
    
    // MARK: - Init
    
    init(router: PersonalRouterInput, interactor: PersonalInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PersonalPresenter: PersonalModuleInput {
}

extension PersonalPresenter: PersonalViewOutput {
    
    /// Handles calling `viewDidLoad` method from view.
    func viewDidLoad() {
        interactor.obtainUserName()
        interactor.obtainUserAvatar()
    }
    
    /// Fetches recipes according to the selected tab.
    ///
    /// - Parameter tab: selected tab from view.
    func fetchRecipes(for tab: Tabs) {
        switch tab {
        case .favourites:
            interactor.provideFavouritesRecipes()
        case .personal:
            interactor.providePersonalRecipes()
        }
    }
    
    /// Opens _RecipeForm_ module without provided recipe (new recipe).
    func openRecipeFormModule() {
        router.openRecipeFormModule(for: nil)
    }
    
    /// Handles tapping on recipe.
    ///
    /// - Parameter entity: recipe entity.
    func didSelectRecipe(_ entity: RecipeEntity) {
        switch entity.source {
        case let recipe as Models.Recipe:
            router.openRecipeDetailsModule(for: recipe)
        case let recipe as Persistence.Recipe:
            router.openRecipeFormModule(for: recipe)
        default:
            Logger.log("Unhandled case.", logType: .warning)
            break
        }
    }
    
    /// Saves avatar data and provides it to Interactor.
    ///
    /// - Parameter data: avatar's image data.
    func saveUserAvatar(_ data: Data) {
        interactor.saveUserAvatar(data)
    }
    
    /// Saves username and provides it to Interactor.
    ///
    /// - Parameter name: username from text field.
    func saveUserName(_ name: String) {
        interactor.saveUserName(name)
    }
}

extension PersonalPresenter: PersonalInteractorOutput {
    
    /// Provides user avatar data from Interactor.
    ///
    /// - Parameter data: avatar's image data.
    func provideUserAvatar(_ data: Data) {
        view?.showUserAvatar(data)
    }
    
    /// Provides username from Interactor.
    ///
    /// - Parameter name: username from UserDefaults.
    func provideUserName(_ name: String) {
        view?.showUserName(name)
    }
    
    /// Provides recipe entities to view.
    ///
    /// - Parameter entities: recipe entities to be displayed in view.
    func provideRecipes(_ entities: [RecipeEntity]) {
        view?.updateRecipes(entities)
    }
}

extension PersonalPresenter: PersonalRouterOutput {
}
