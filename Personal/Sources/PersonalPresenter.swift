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
    
    func viewDidLoad() {
        interactor.obtainUserName()
        interactor.obtainUserAvatar()
    }
    
    func fetchRecipes(for tab: Tabs) {
        switch tab {
        case .favourites:
            interactor.provideFavouritesRecipes()
        case .personal:
            interactor.providePersonalRecipes()
        }
    }
    
    func openRecipeFormModule() {
        router.openRecipeFormModule(for: nil)
    }
    
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
    
    func saveUserAvatar(_ data: Data) {
        interactor.saveUserAvatar(data)
    }
    
    func saveUserName(_ name: String) {
        interactor.saveUserName(name)
    }
}

extension PersonalPresenter: PersonalInteractorOutput {
    func provideUserAvatar(_ data: Data) {
        view?.showUserAvatar(data)
    }
    
    func provideUserName(_ name: String) {
        view?.showUserName(name)
    }
    
    func provideRecipes(_ entities: [RecipeEntity]) {
        view?.updateRecipes(entities)
    }
}

extension PersonalPresenter: PersonalRouterOutput {
}
