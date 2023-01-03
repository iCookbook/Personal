//
//  RecipeEntity.swift
//  Personal
//
//  Created by Егор Бадмаев on 02.01.2023.
//

struct RecipeEntity {
    let title: String
    let subtitle: String
    let imageData: Data
    
    var source: Any
}

extension RecipeEntity: Equatable {
    static func == (lhs: RecipeEntity, rhs: RecipeEntity) -> Bool {
        lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
    }
}
