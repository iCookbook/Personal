//
//  PersonalRouter.swift
//  Personal
//
//  Created by Егор Бадмаев on 27.10.2022.
//  
//

import UIKit

final class PersonalRouter {
    weak var output: PersonalRouterOutput?
    weak var viewController: UIViewController?
}

extension PersonalRouter: PersonalRouterInput {
}
