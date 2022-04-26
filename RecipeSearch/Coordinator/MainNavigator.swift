//
//  MainNavigator.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import UIKit

class MainNavigator : Navigator {
   

    var coordinator: Coordinator

    enum Destination {
        case RecipeSearchVC
        case RecipeDetailesVC(recipt : Recipe)
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
            
        case .RecipeSearchVC:
            let recipeSearchViewModel = RecipeSearchViewModel()
            let recipeSearchView = RecipeSearchVC(ViewModel: recipeSearchViewModel, coordinator: coordinator)
            return recipeSearchView
        case .RecipeDetailesVC(recipt: let recipt ):
            let recipeDetailesModel = RecipeDetailesViewModel(recipt: recipt)
            let recipeDetailesView = RecipeDetailesVC(ViewModel: recipeDetailesModel, coordinator: coordinator)
            return recipeDetailesView
        }
    }
    
    required init(coordintor: Coordinator) {
        self.coordinator = coordintor
    }
}
