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
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination{
            
        case .RecipeSearchVC:
            let recipeSearchViewModel = RecipeSearchViewModel()
            let RecipeSearchView = RecipeSearchVC(ViewModel: recipeSearchViewModel, coordinator: coordinator)
            return RecipeSearchView
        }
    }
    
    required init(coordintor: Coordinator) {
        self.coordinator = coordintor
    }
}
