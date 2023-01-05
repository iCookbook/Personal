//
//  PersonalRouter.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//  

import UIKit
import Models
import Persistence
import RecipeDetails
import RecipeForm

final class PersonalRouter {
    weak var presenter: PersonalRouterOutput?
    weak var viewController: UIViewController?
}

extension PersonalRouter: PersonalRouterInput {
    
    /// Opens _RecipeDetails_ module.
    ///
    /// - Parameter recipe: recipe to open details with.
    func openRecipeDetailsModule(for recipe: Models.Recipe) {
        let context = RecipeDetailsContext(moduleOutput: nil, recipe: recipe)
        let assembly = RecipeDetailsAssembly.assemble(with: context)
        viewController?.navigationController?.pushViewController(assembly.viewController, animated: true)
    }
    
    /// Opens _RecipeForm_ module.
    ///
    /// - Parameter recipe: **optional** recipe to open RecipeForm with.
    func openRecipeFormModule(for recipe: Persistence.Recipe?) {
        let context = RecipeFormContext(moduleOutput: self, recipe: recipe)
        let assembly = RecipeFormAssembly.assemble(with: context)
        let destination = assembly.viewController
        destination.modalPresentationStyle = .fullScreen
        viewController?.present(destination, animated: true)
    }
}

extension PersonalRouter: RecipeFormModuleOutput {
    
    /// Handles finishing _RecipeForm_ module.
    func recipeFormModuleDidFinish() {
        viewController?.presentedViewController?.dismiss(animated: true)
    }
}
