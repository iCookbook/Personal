//
//  PersonalAssembly.swift
//  Personal
//
//  Created by Егор Бадмаев on 27.10.2022.
//  
//

import UIKit

public final class PersonalAssembly {
    
    // MARK: - Public Properties
    
    public let input: PersonalModuleInput
    public let viewController: UIViewController
    
    // MARK: - Private Properties
    
    private(set) weak var router: PersonalRouterInput!
    
    // MARK: - Public Methods
    
    public static func assemble(with context: PersonalContext) -> PersonalAssembly {
        let router = PersonalRouter()
        let interactor = PersonalInteractor()
        let presenter = PersonalPresenter(router: router, interactor: interactor)
        let viewController = PersonalViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return PersonalAssembly(view: viewController, input: presenter, router: router)
    }
    
    // MARK: - Init
    
    private init(view: UIViewController, input: PersonalModuleInput, router: PersonalRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

public struct PersonalContext {
    weak var moduleOutput: PersonalModuleOutput?
    
    public init(moduleOutput: PersonalModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
}
