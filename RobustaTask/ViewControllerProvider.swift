//
//  ViewControllerProvider.swift
//  RobustaTask
//
//  Created by Assem on 15/10/2022.
//

import Foundation

struct ViewControllerProvider {
    private init() {}


    static var repositoriesViewController: RepositoriesViewController {
        let repositoriesService = RepositoriesService()
        let viewModel = RepositoriesViewModel(service: repositoriesService)
        let vc = RepositoriesViewController()
        vc.viewModel = viewModel
        return vc
    }

     static func navigateToRepoProfileVC(with repoOwner: Owner) ->  RepositoryProfileViewController {
         let repositoryProfileService = RepositoryProfileService()
        let vc = RepositoryProfileViewController()
        let repositoryProfileViewModel = RepositoryProfileViewModel(ownerRepo: repoOwner, service: repositoryProfileService)
        vc.viewModel = repositoryProfileViewModel
        return vc
    }


}
