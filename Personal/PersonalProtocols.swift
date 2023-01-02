//
//  PersonalProtocols.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import Foundation

public protocol PersonalModuleInput {
    var moduleOutput: PersonalModuleOutput? { get }
}

public protocol PersonalModuleOutput: AnyObject {
}

protocol PersonalViewInput: AnyObject {
}

protocol PersonalViewOutput: AnyObject {
}

protocol PersonalInteractorInput: AnyObject {
}

protocol PersonalInteractorOutput: AnyObject {
}

protocol PersonalRouterInput: AnyObject {
}

protocol PersonalRouterOutput: AnyObject {
}
