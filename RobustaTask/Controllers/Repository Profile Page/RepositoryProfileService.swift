//
//  RepositoryProfileService.swift
//  RobustaTask
//
//  Created by Assem on 16/10/2022.
//

import Foundation

import Foundation
protocol RepositoryProfileServicing {
    func getOwnerRepositoryInfo(login: String, completion: @escaping (Result<RepositoryOwner, Error>) -> Void)
}

class RepositoryProfileService: RepositoryProfileServicing {

    // MARK: Get Repository Details
    func getOwnerRepositoryInfo(login: String, completion: @escaping (Result<RepositoryOwner, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)users/\(login)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(RepositoryOwner.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }



}


