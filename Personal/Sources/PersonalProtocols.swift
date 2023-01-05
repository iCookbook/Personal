//
//  PersonalProtocols.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import Models
import Persistence

public protocol PersonalModuleInput {
    var moduleOutput: PersonalModuleOutput? { get }
}

public protocol PersonalModuleOutput: AnyObject {
}

protocol PersonalViewInput: AnyObject {
    func showUserAvatar(_ data: Data)
    func showUserName(_ name: String)
    
    func updateRecipes(for selectedTab: Tabs, _ entities: [RecipeEntity])
}

protocol PersonalViewOutput: AnyObject {
    func viewDidLoad()
    func fetchRecipes(_ tab: Tabs?)
    func openRecipeFormModule()
    func didSelectRecipe(_ entity: RecipeEntity)
    
    func saveUserAvatar(_ data: Data)
    func saveUserName(_ name: String)
}

protocol PersonalInteractorInput: AnyObject {
    func obtainUserAvatar()
    func obtainUserName()
    func saveUserAvatar(_ data: Data)
    func saveUserName(_ name: String)
    
    func provideFavouritesRecipes()
    func providePersonalRecipes()
}

protocol PersonalInteractorOutput: AnyObject {
    func provideUserAvatar(_ data: Data)
    func provideUserName(_ name: String)
    
    func provideRecipes(_ entities: [RecipeEntity])
}

protocol PersonalRouterInput: AnyObject {
    func openRecipeDetailsModule(for recipe: Models.Recipe)
    func openRecipeFormModule(for recipe: Persistence.Recipe?)
}

protocol PersonalRouterOutput: AnyObject {
}
