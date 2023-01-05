# "Personal" module

Third tab bar module

## To set up

There is no need for special set up for this module.

This module is opened at the start of the application that is described in [AppCoordinator](https://github.com/iCookbook/Cookbook/blob/master/Cookbook/Application/AppCoordinator.swift) 

## Dependencies

This module has 4 dependencies:

- [CommonUI](https://github.com/iCookbook/CommonUI) for some reasons:
    * Identifiers of the cells
    * RecipeDetailsViewController requires to import it's ancestor
- [Resources](https://github.com/iCookbook/Resources) for access to resources of the application
- [Persistence](https://github.com/iCookbook/Persistence) to fetch, add and save favourites recipes
- [Logger](https://github.com/iCookbook/Logger) to log debug data
- [RecipeDetails](https://github.com/iCookbook/RecipeDetails) to open details module
- [RecipeForm](https://github.com/iCookbook/RecipeForm) to open details module

## Screenshots

| <img width=300 src="https://user-images.githubusercontent.com/60363270/210759369-b3be228f-ec45-419d-9770-900a27dad693.png"> | <img width=300 src="https://user-images.githubusercontent.com/60363270/210759393-32d3f9f2-26bf-4ff1-ae5e-8f042857deaa.png"> |
|---|---|

---

For more details, read [GitHub Wiki](https://github.com/iCookbook/Personal/wiki) documentation
