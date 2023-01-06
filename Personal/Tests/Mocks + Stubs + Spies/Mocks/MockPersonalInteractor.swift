//
//  MockPersonalInteractor.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

@testable import Personal
@testable import Persistence

class MockPersonalInteractor: PersonalInteractorInput {
    
    func obtainUserAvatar() {
    }
    
    func obtainUserName() {
    }
    
    func saveUserAvatar(_ data: Data) {
    }
    
    func saveUserName(_ name: String) {
    }
    
    func provideFavouritesRecipes() {
    }
    
    func providePersonalRecipes() {
    }
    
    func provideCoreDataManager(with recipe: Recipe?) {
    }
}
