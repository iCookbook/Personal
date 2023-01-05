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
    /// Defines selected tab.
    private var selectedTab = Tabs.personal
    
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
    func fetchRecipes(_ tab: Tabs?) {
        /// Save selected tab, if provided tab is not `nil`.
        selectedTab = tab ?? selectedTab
        /// Ask interactor to provide proper data for tab.
        DispatchQueue.global(qos: .userInitiated).async {
            switch tab ?? self.selectedTab {
            case .favourites:
                self.interactor.provideFavouritesRecipes()
            case .personal:
                self.interactor.providePersonalRecipes()
            }
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
            Logger.log("\(type(of: entity.source)) is unsupported for this method", logType: .error)
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
        DispatchQueue.main.async {
            self.view?.updateRecipes(for: self.selectedTab, entities)
        }
    }
}

extension PersonalPresenter: PersonalRouterOutput {
}
