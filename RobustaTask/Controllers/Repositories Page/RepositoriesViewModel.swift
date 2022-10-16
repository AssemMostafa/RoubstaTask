//
//  RepositoriesViewModel.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import Foundation

class RepositoriesViewModel {

    var repositories: [Repository] = []
    var errorHandler: Variable<String?> = Variable(nil)
    var successHandler: Variable<Bool> = Variable(false)
    var service: RepositoriesServicing!

        init(service: RepositoriesServicing) {
            self.service = service
        }
    // MARK: Pagination
    var isLoading = false
    var currentpage: Int = 1
    var lastpage: Int = 1
    var totalpages: Int = 1


    func fetchRepositories(currentPage: Int) {
        self.service.getRepositoriesInfo() { [weak self] result in
            switch result {
            case.success(let response):
                //                self?.isLoading = false
                //                self?.totalpages = response.total_pages
                //                if self?.currentpage != 1 {
                //                    self?.titles.value += response.results
                //                } else {
                self?.repositories = response
                self?.successHandler.value = true
                //                }
            case .failure(let error):
                self?.errorHandler.value = error.localizedDescription
            }
        }
    }

    func searchRepositories(with name: String) -> [Repository] {
        print(repositories.count)
        if name == "" {
            fetchRepositories(currentPage: 1)
            return repositories
        }
        return repositories.filter { model in
            return model.name!.localizedCaseInsensitiveContains(name)
        }

    }

}
