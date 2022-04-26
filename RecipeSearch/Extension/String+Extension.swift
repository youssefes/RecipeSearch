//
//  URL+Extension.swift
//  RecipeSearch
//
//  Created by LapStore on 22/04/2022.
//

import Foundation

extension String{
    func getQueryStringParameter(param: String) -> String? {
      guard let url = URLComponents(string: self) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
