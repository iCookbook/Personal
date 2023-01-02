//
//  PersonalRouter.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//  

import UIKit

final class PersonalRouter {
    weak var presenter: PersonalRouterOutput?
    weak var viewController: UIViewController?
}

extension PersonalRouter: PersonalRouterInput {
}
