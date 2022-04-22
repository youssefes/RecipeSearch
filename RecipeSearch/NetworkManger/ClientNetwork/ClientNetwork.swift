//
//  ClientNetwork.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation
import Alamofire
class NetworkClient {
    func performRequest<T : Decodable>(_ object: T.Type , router: APIRouter, completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(router).response{ (response) in
            if response.error != nil {
                completion(.failure(response.error!))
            }
            do {
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                let models = try decoder.decode(T.self, from: data)
                completion(.success(models))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
