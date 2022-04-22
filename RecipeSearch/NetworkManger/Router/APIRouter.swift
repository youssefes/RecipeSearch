//
//  APIRouter.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }
    var header : HTTPHeaders {get}

}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let url: String =  "\(NetworkConstants.baseUrl)\(path)"
        print(url)
        let request = try URLRequest(url: url, method: method, headers: header)
        return try encoding.encode(request, with: parameters)
    }
}

enum OpportunitiesError: Error {
    case URLNotValid
}
