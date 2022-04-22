//
//  RecipeSearchVC.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import UIKit

class RecipeSearchVC: BaseWireFrame<RecipeSearchViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func bind(ViewModel: RecipeSearchViewModel) {
        setUpView()
        ViewModel.getRecipeSearch(quary: "dh").subscribe(onNext: { resulte in
            print(resulte.hits?.count)
            print(resulte._links?.next?.href?.getQueryStringParameter(param: "_cont"))
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposePag)
    }
    
    func setUpView(){
        title = "Recipe search"
    }

}
