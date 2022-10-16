//
//  RepositoriesService.swift
//  RobustaTask
//
//  Created by Assem on 15/10/2022.
//

import Foundation
protocol RepositoriesServicing {
    func getRepositoriesInfo(completion: @escaping (Result<[Repository], Error>) -> Void)
}

class RepositoriesService: RepositoriesServicing {

    // MARK: Get Repositories
    func getRepositoriesInfo(completion: @escaping (Result<[Repository], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)repositories") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                guard let dataString = String(data: data, encoding: .utf8) else {return}

                let results = try JSONDecoder().decode([Repository].self, from: Data(dataString.utf8))
                completion(.success(results))
            } catch {
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
}

