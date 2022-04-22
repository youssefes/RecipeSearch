//
//  RecipeRepository.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class RecipeRepository {
    
    let networkClient : NetworkClient
    let disPage = DisposeBag()
    init(networkClient : NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getRecipeSearch(param : Parameters) -> Observable<RecipeSearchModel>{
        Observable<RecipeSearchModel>.create { [weak self] (items) -> Disposable in
            self?.networkClient.performRequest(RecipeSearchModel.self, router: RecipeRouter.getRecipeSearch(param: param) ){ (resulte) in
                switch resulte{
                case .success(let data):
                    items.onNext(data)
                    items.onCompleted()
                case .failure(let error):
                    items.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
