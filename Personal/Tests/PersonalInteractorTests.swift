//
//  PersonalInteractorTests.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Personal

class PersonalInteractorTests: XCTestCase {
    
    let mockCoreDataManager = MockCoreDataManager()
    var presenter: SpyPersonalPresenter!
    /// SUT.
    var interactor: PersonalInteractor!
    
    override func setUpWithError() throws {
        interactor = PersonalInteractor(coreDataManager: mockCoreDataManager)
        presenter = SpyPersonalPresenter()
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
    }
    
    func testObtainUserAvatar() throws {
        UserDefaults.userAvatar = Data()
        
        interactor.obtainUserAvatar()
        
        XCTAssertNotNil(presenter.userAvatarData)
        XCTAssertTrue(presenter.provideUserAvatarWasCalled)
    }
    
    func testFailObtainUserAvatar() throws {
        UserDefaults.userAvatar = nil
        
        interactor.obtainUserAvatar()
        
        XCTAssertNil(presenter.userAvatarData)
        XCTAssertFalse(presenter.provideUserAvatarWasCalled)
    }
    
    func testObtainUserName() throws {
        UserDefaults.userName = "Taylor"
        
        interactor.obtainUserName()
        
        XCTAssertNotNil(presenter.userName)
        XCTAssertTrue(presenter.provideUserNameWasCalled)
    }
    
    func testFailObtainUserName() throws {
        UserDefaults.userName = nil
        
        interactor.obtainUserName()
        
        XCTAssertNil(presenter.userName)
        XCTAssertFalse(presenter.provideUserNameWasCalled)
    }
    
    func testSaveUserAvatar() throws {
        let dataToSave = Data([1, 2, 3])
        
        interactor.saveUserAvatar(dataToSave)
        
        XCTAssertEqual(dataToSave, UserDefaults.userAvatar)
    }
    
    func testSaveUserName() throws {
        let nameToSave = "Swift"
        
        interactor.saveUserName(nameToSave)
        
        XCTAssertEqual(nameToSave, UserDefaults.userName)
    }
    
    func testProvideFavouritesRecipes() throws {
        interactor.provideFavouritesRecipes()
        
        XCTAssertEqual(presenter.entities.count, UserDefaults.favouriteRecipes.count)
    }
    
    func testProvidePersonalRecipes() throws {
        interactor.providePersonalRecipes()
        
        /// Because stub always returns `nil`, we will have empty array of entities.
        XCTAssertEqual(presenter.entities, [RecipeEntity]())
    }
}
