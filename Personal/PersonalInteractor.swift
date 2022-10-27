//
//  PersonalInteractor.swift
//  Personal
//
//  Created by Егор Бадмаев on 27.10.2022.
//  
//

import Foundation

final class PersonalInteractor {
    weak var output: PersonalInteractorOutput?
}

extension PersonalInteractor: PersonalInteractorInput {
}
