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
    //MARK: - properties
    private let  recipeRepository = RecipeRepository()
    private let disposePag = DisposeBag()
    var recipeResulteOfSearch : PublishSubject<[Hits]> = .init()
    var healthOptions : BehaviorSubject = .init(value: ["All","alcohol-free",     "immuno-supportive", "celery-free","crustacean-free","dairy-free", "egg-free" , "fish-free","fodmap-free", "gluten-free","alcohol-cocktail" , "DASH", "keto-friendly", "kidney-friendly" , "kosher", "low-potassium", "low-sugar", "lupine-free", "Mediterranean", "mollusk-free" , "mustard-free" , "No-oil-added" , "paleo", "peanut-free" , "pecatarian" , "pork-free", "red-meat-free", "sesame-free", "shellfish-free", "soy-free" , "sugar-conscious", "sulfite-free", "tree-nut-free", "vegan", "vegetarian", "wheat-free"])
    //MARK: - get Recipe Search
    func getRecipeSearch(quary : String , health : [String]){
        var param :  [String : Any] = [
            "q": quary,
            "app_id": NetworkConstants.appId,
            "app_key": NetworkConstants.appKey,
            "type": "public"
        ]
        if !health.isEmpty {
            param["health"] = health
        }
        
        recipeRepository.getRecipeSearch(param: param).subscribe(onNext: { [weak self] resulte in
            if let hits = resulte.hits {
                self?.recipeResulteOfSearch.onNext(hits)
            }else{
                self?.recipeResulteOfSearch.onNext([])
            }
        }, onError: { [weak self] error in
            self?.recipeResulteOfSearch.onError(error)
            print(error.localizedDescription)
        }).disposed(by: disposePag)
        
        return
    }
    
    //MARK: - save Least Resulte
    func saveLeastResulte(arrayOfRecipt : [Hits]){
        let userDefaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let dataDefode = try encoder.encode(arrayOfRecipt)
            userDefaults.set(dataDefode, forKey: "saveRecipts")
        
        } catch {
            print("Unable to Encode Note (\(error))")
        }
        userDefaults.synchronize()
    }
    //MARK: - get Least Resulte
    func getLeastResulteSave(){
        if let objects = UserDefaults.standard.value(forKey: "saveRecipts") as? Data {
            let decoder = JSONDecoder()
            if let lastSavedDate = try? decoder.decode(Array.self, from: objects) as [Hits] {
                self.recipeResulteOfSearch.onNext(lastSavedDate)
            }
        }
    }
}
