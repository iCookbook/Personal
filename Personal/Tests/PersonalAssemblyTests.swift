//
//  PersonalAssemblyTests.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 27.10.2022.
//

import XCTest
@testable import Personal
@testable import Persistence

struct PersonalContext: PersonalDependenciesProtocol {
    weak var moduleOutput: PersonalModuleOutput?
    let coreDataManager: CoreDataManagerProtocol
}

class PersonalAssemblyTests: XCTestCase {
    
    let mockCoreDataManager = MockCoreDataManager()
    /// SUT.
    var assembly: PersonalAssembly!
    var context: PersonalContext!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        context = nil
    }
    
    /**
     In the next tests we will check that the module consists of the correct parts and all dependencies are filled in.
     The tests will differ by creating different contexts
     */
    
    func testAssemblingWithModuleOutput() throws {
        let moduleOutput = MockPersonalPresenter()
        context = PersonalContext(moduleOutput: moduleOutput, coreDataManager: mockCoreDataManager)
        assembly = PersonalAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router, "Module router should not be nil")
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? PersonalViewController,
              let presenter = assembly.input as? PersonalPresenter,
              let _ = assembly.router as? PersonalRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
        /// Unfortunately, it is impossible to access Core Data manager, that is why it is impossible to test its' injecting. DI was tested in `Cookbook/ServiceLocatorTests.swift`.
    }
    
    func testAssemblingWithoutModuleOutput() throws {
        context = PersonalContext(moduleOutput: nil, coreDataManager: mockCoreDataManager)
        assembly = PersonalAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router)
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? PersonalViewController,
              let presenter = assembly.input as? PersonalPresenter,
              let _ = assembly.router as? PersonalRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
