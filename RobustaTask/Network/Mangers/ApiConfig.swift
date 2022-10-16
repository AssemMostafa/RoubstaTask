//
//  ApiConfig.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.github.com/"
}

enum APIError: Error {
    case faildToGetData
}
