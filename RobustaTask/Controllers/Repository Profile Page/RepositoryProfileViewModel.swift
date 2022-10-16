//
//  RepositoryProfileViewModel.swift
//  RobustaTask
//
//  Created by Assem on 16/10/2022.
//

import Foundation

class RepositoryProfileViewModel {

    var ownerRepo: Owner
    var service: RepositoryProfileServicing!
    var errorHandler: Variable<String?> = Variable(nil)
    var successHandler: Variable<RepositoryOwner?> = Variable(nil)

    // MARK: Pagination
    var isLoading = false
    var currentpage: Int = 1
    var lastpage: Int = 1
    var totalpages: Int = 1

    init (ownerRepo: Owner, service: RepositoryProfileServicing) {
        self.ownerRepo = ownerRepo
        self.service = service
    }


    func fetchRepoProfileInfo(currentPage: Int) {
        self.service.getOwnerRepositoryInfo(login: self.ownerRepo.login ?? "N/A") { [weak self] result in
            switch result {
            case.success(let response):
                //                self?.isLoading = false
                //                self?.totalpages = response.total_pages
                //                if self?.currentpage != 1 {
                //                    self?.titles.value += response.results
                //                } else {
                self?.successHandler.value = response
                //                }
            case .failure(let error):
                self?.errorHandler.value = error.localizedDescription
            }
        }
    }
}
