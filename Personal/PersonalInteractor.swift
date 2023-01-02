//
//  PersonalInteractor.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//  

import Foundation

final class PersonalInteractor {
    weak var presenter: PersonalInteractorOutput?
}

extension PersonalInteractor: PersonalInteractorInput {
}
