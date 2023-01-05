//
//  RecipeEntity.swift
//  Personal
//
//  Created by Егор Бадмаев on 02.01.2023.
//

/// Entity representing recipe.
struct RecipeEntity {
    /// Title/name of the recipe.
    let title: String
    /// Subtitle for this recipe.
    let subtitle: String
    /// Recipe image raw data.
    let imageData: Data
    
    /// Original of the recipe. We need to save it to open details with definite model.
    var source: Any
}

extension RecipeEntity: Equatable {
    static func == (lhs: RecipeEntity, rhs: RecipeEntity) -> Bool {
        lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.imageData == rhs.imageData
    }
}
