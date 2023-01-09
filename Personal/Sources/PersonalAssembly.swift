//
//  PersonalAssembly.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import UIKit

public final class PersonalAssembly {
    
    // MARK: - Public Properties
    
    public let input: PersonalModuleInput
    public let viewController: UIViewController
    
    // MARK: - Private Properties
    
    private(set) weak var router: PersonalRouterInput!
    
    // MARK: - Public Methods
    
    public static func assemble(with context: PersonalDependenciesProtocol) -> PersonalAssembly {
        let router = PersonalRouter()
        let interactor = PersonalInteractor(coreDataManager: context.coreDataManager)
        let presenter = PersonalPresenter(router: router, interactor: interactor)
        let viewController = PersonalViewController(presenter: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.presenter = presenter
        router.viewController = viewController
        router.presenter = presenter
        
        return PersonalAssembly(view: viewController, input: presenter, router: router)
    }
    
    // MARK: - Init
    
    private init(view: UIViewController, input: PersonalModuleInput, router: PersonalRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}
