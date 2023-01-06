//
//  PersonalPresenterTests.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Personal
@testable import Persistence
@testable import Models

class PersonalPresenterTests: XCTestCase {
    
    let mockRouter = MockPersonalRouter()
    let mockInteractor = MockPersonalInteractor()
    var spyRouter: SpyPersonalRouter!
    var spyInteractor: SpyPersonalInteractor!
    /// SUT.
    var presenter: PersonalPresenter!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        spyRouter = nil
        spyInteractor = nil
    }
    
    func testCallingViewDidLoadMethod() throws {
        spyInteractor = SpyPersonalInteractor()
        presenter = PersonalPresenter(router: mockRouter, interactor: spyInteractor)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(spyInteractor.userAvatarDidObtained)
        XCTAssertTrue(spyInteractor.userNameDidObtained)
    }
    
    func testFetchingRecipesForPersonalTab() throws {
        spyInteractor = SpyPersonalInteractor()
        presenter = PersonalPresenter(router: mockRouter, interactor: spyInteractor)
        let expectation = expectation(description: "testProvidingRecipes")
        spyInteractor.expectation = expectation
        
        presenter.fetchRecipes(.personal)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(spyInteractor.personalRecipesDidProvided)
        XCTAssertFalse(spyInteractor.favouritesRecipesDidProvided)
    }
    
    func testFetchingRecipesForFavouritesTab() throws {
        spyInteractor = SpyPersonalInteractor()
        presenter = PersonalPresenter(router: mockRouter, interactor: spyInteractor)
        let expectation = expectation(description: "testProvidingRecipes")
        spyInteractor.expectation = expectation
        
        presenter.fetchRecipes(.favourites)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(spyInteractor.personalRecipesDidProvided)
        XCTAssertTrue(spyInteractor.favouritesRecipesDidProvided)
    }
    
    /// When user tries to add his own recipe.
    func testOpeningRecipeFormModuleFromView() throws {
        spyRouter = SpyPersonalRouter()
        presenter = PersonalPresenter(router: spyRouter, interactor: mockInteractor)
        
        presenter.openRecipeFormModule()
        
        XCTAssertNil(spyRouter.persistenceModel, "Provided model should equal nil")
    }
    
    func testSelectingRecipePersistence() throws {
        spyRouter = SpyPersonalRouter()
        presenter = PersonalPresenter(router: spyRouter, interactor: mockInteractor)
        let recipe = Persistence.Recipe()
        let entity = RecipeEntity(title: "", subtitle: "", imageData: Data(), source: recipe)
        
        presenter.didSelectRecipe(entity)
        
        XCTAssertIdentical(spyRouter.persistenceModel, recipe)
        XCTAssertNil(spyRouter.apiModel)
    }
    
    func testSelectingRecipeModels() throws {
        spyRouter = SpyPersonalRouter()
        presenter = PersonalPresenter(router: spyRouter, interactor: mockInteractor)
        let recipe = Models.Recipe(label: nil, image: nil, images: nil, source: nil, url: nil, ingredients: nil, calories: nil, totalWeight: nil, yield: nil, totalTime: nil, dietLabels: nil, cuisineType: nil, mealType: nil, dishType: nil, digest: nil)
        let entity = RecipeEntity(title: "", subtitle: "", imageData: Data(), source: recipe)
        
        presenter.didSelectRecipe(entity)
        
        XCTAssertIdentical(spyRouter.apiModel, recipe)
        XCTAssertNil(spyRouter.persistenceModel)
    }
    
    func testSelectingRecipeUnknown() throws {
        presenter = PersonalPresenter(router: mockRouter, interactor: mockInteractor)
        let entity = RecipeEntity(title: "", subtitle: "", imageData: Data(), source: Data())
        
        XCTAssertNoThrow(presenter.didSelectRecipe(entity))
    }
    
    func testProvidingAvatarDataToInteractor() throws {
        spyInteractor = SpyPersonalInteractor()
        presenter = PersonalPresenter(router: mockRouter, interactor: spyInteractor)
        let dataToProvide = Data([1, 2, 3])
        
        presenter.saveUserAvatar(dataToProvide)
        
        XCTAssertNotNil(spyInteractor.userAvatarDataToBeSaved)
        XCTAssertEqual(spyInteractor.userAvatarDataToBeSaved, dataToProvide)
    }
    
    func testProvidingNameToInteractor() throws {
        spyInteractor = SpyPersonalInteractor()
        presenter = PersonalPresenter(router: mockRouter, interactor: spyInteractor)
        let nameToProvide = "Taylor Swift"
        
        presenter.saveUserName(nameToProvide)
        
        XCTAssertNotNil(spyInteractor.userNameToBeSaved)
        XCTAssertEqual(spyInteractor.userNameToBeSaved, nameToProvide)
    }
    
    func testProvidingUserAvatar() throws {
        let spyView = SpyPersonalView()
        presenter = PersonalPresenter(router: mockRouter, interactor: mockInteractor)
        presenter.view = spyView
        let dataToProvide = Data([1, 2, 3])
        
        presenter.provideUserAvatar(dataToProvide)
        
        XCTAssertNotNil(spyView.dataToShow)
        XCTAssertEqual(spyView.dataToShow, dataToProvide)
    }
    
    func testProvidingUserName() throws {
        let spyView = SpyPersonalView()
        presenter = PersonalPresenter(router: mockRouter, interactor: mockInteractor)
        presenter.view = spyView
        let nameToProvide = "Taylor Swift"
        
        presenter.provideUserName(nameToProvide)
        
        XCTAssertNotNil(spyView.nameToShow)
        XCTAssertEqual(spyView.nameToShow, nameToProvide)
    }
    
    func testProvidingRecipes() throws {
        let spyView = SpyPersonalView()
        let expectation = expectation(description: "testProvidingRecipes")
        spyView.expectation = expectation
        presenter = PersonalPresenter(router: mockRouter, interactor: mockInteractor)
        presenter.view = spyView
        let entitiesToProvide = [RecipeEntity(title: "1", subtitle: "1", imageData: Data(), source: "1"),
                                 RecipeEntity(title: "2", subtitle: "2", imageData: Data(), source: "2"),
                                 RecipeEntity(title: "3", subtitle: "3", imageData: Data(), source: "3")]
        
        presenter.provideRecipes(entitiesToProvide)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(spyView.entitiesToBeUpdated)
        XCTAssertEqual(spyView.entitiesToBeUpdated, entitiesToProvide)
    }
}
