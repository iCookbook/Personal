//
//  MockPersonalPresenter.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal

class MockPersonalPresenter {
}

extension MockPersonalPresenter: PersonalRouterOutput {
    
    func refreshDataOnDisplay() {
    }
}

extension MockPersonalPresenter: PersonalModuleOutput {
}
