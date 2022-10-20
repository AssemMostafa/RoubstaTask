//
//  ViewControllerProvider.swift
//  RobustaTask
//
//  Created by Assem on 15/10/2022.
//

import Foundation

enum AppConfiguration {
    case live
    case mock
}
#if MOCK
let appConfiguration: AppConfiguration = .mock
#else
let appConfiguration: AppConfiguration = .live
#endif

struct ViewControllerProvider {
    private init() {}

    static var repositoriesViewController: RepositoriesViewController {
        let repositoriesService: RepositoriesServicing
        switch appConfiguration {
        case .live:
            repositoriesService = RepositoriesService()
        case .mock:
            repositoriesService = MockRepositoriesService()
        }
        let vc = RepositoriesViewController()
        let viewModel = RepositoriesViewModel(service: repositoriesService)
        vc.viewModel = viewModel
        return vc
    }

     static func navigateToRepoProfileVC(with repoOwner: Owner) ->  RepositoryProfileViewController {
         let repositoryProfileService: RepositoryProfileServicing
         switch appConfiguration {
         case .live:
             repositoryProfileService = RepositoryProfileService()
         case .mock:
             repositoryProfileService = MockRepositoryProfileService()
         }
        let vc = RepositoryProfileViewController()
        let repositoryProfileViewModel = RepositoryProfileViewModel(ownerRepo: repoOwner, service: repositoryProfileService)
        vc.viewModel = repositoryProfileViewModel
        return vc
    }


}
