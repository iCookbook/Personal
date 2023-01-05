//
//  Tabs.swift
//  Personal
//
//  Created by Егор Бадмаев on 02.01.2023.
//

import Resources
import UIKit

enum Tabs: Int {
    case personal
    case favourites
}

extension Tabs {
    var emptyDataDescription: String {
        switch self {
        case .personal:
            return Texts.Personal.emptyPersonalRecipes
        case .favourites:
            return Texts.Personal.emptyFavouriteRecipes
        }
    }
    
    var emptyDataImage: UIImage? {
        switch self {
        case .personal:
            return Images.Discover.bookFilled
        case .favourites:
            return Images.Personal.favourites
        }
    }
}
