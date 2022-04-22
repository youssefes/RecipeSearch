//
//  RecipeSearchViewModel.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import RxSwift
import RxSwift

class RecipeSearchViewModel{
    
    let  recipeRepository = RecipeRepository()
    
    func getRecipeSearch(quary : String)  -> Observable<RecipeSearchModel> {
        let param :  [String : Any] = [
            "q": quary,
            "app_id": NetworkConstants.appId,
            "app_key": NetworkConstants.appKey,
            "type": "public"
        ]
        return recipeRepository.getRecipeSearch(param: param)
    }
    
}
