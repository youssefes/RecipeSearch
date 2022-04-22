//
//  RecipeRouter.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import Alamofire

enum RecipeRouter: APIRouter{
    
    case getRecipeSearch(param : Parameters)
    var method: HTTPMethod{
        switch self{
        case .getRecipeSearch:
            return .get
        }
    }
    
    var path: String{
        switch self{
        case .getRecipeSearch:
            return "recipes/v2"
        }
    }
    
    var parameters: Parameters?{
        switch self{
        case .getRecipeSearch(param: let params):
            return params
        }
    }
    
    var encoding: ParameterEncoding{
        switch self{
        case .getRecipeSearch:
            return URLEncoding.queryString
        }
    }
    
    var header: HTTPHeaders{
        switch self{
        case .getRecipeSearch:
            let header = HTTPHeaders([HTTPHeader(name: "Content-Type", value: "application/json")])
            return header
        }
    }
    
    
}
