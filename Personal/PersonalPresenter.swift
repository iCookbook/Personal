//
//  PersonalPresenter.swift
//  Personal
//
//  Created by Егор Бадмаев on 27.10.2022.
//  
//

import Foundation

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
}

extension PersonalPresenter: PersonalInteractorOutput {
}
