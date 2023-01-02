//
//  Tabs.swift
//  Personal
//
//  Created by Егор Бадмаев on 02.01.2023.
//

import Resources

enum Tabs {
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
    
    var emptyDataImage: Data? {
        switch self {
        case .personal:
            return Images.Discover.bookFilled?.pngData()
        case .favourites:
            return Images.Personal.favouritesSelected?.pngData()
        }
    }
}
