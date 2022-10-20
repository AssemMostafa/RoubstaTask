//
//  RobustaTaskTests.swift
//  RobustaTaskTests
//
//  Created by Assem on 20/10/2022.
//

import XCTest
@testable import RobustaTask

class RobustaTaskTests: XCTestCase {

      let reposVC = ViewControllerProvider.repositoriesViewController
     let owner = Owner(id: 1, login: "newLogin", avatar_url: nil)

    func testReposVCDenpendencyInjection() {
        XCTAssertNotNil(reposVC.viewModel)

    }

    func testRepoProfileVCDenpendencyInjection() {
        let repoProfile = ViewControllerProvider.navigateToRepoProfileVC(with: self.owner)
        XCTAssertNotNil(repoProfile)

    }

    func testReposVCServiceDenpendencyInjection() {
        switch appConfiguration {
        case .live:
            XCTAssert(reposVC.viewModel.service is RepositoriesService)
        case .mock:
            XCTAssert(reposVC.viewModel.service is MockRepositoriesService)
        }
    }

    func testReposViewModel() {
        let mockService = MockRepositoriesService()
        let viewModel = RepositoriesViewModel(service: mockService)
        viewModel.fetchRepositories(currentPage: 1)
        XCTAssertEqual(viewModel.repositories.count, 3)
    }

    func testGetReposViewModelNumberOfCall() {
        let mockService = MockRepositoriesService()
        let viewModel = RepositoriesViewModel(service: mockService)
        viewModel.fetchRepositories(currentPage: 1)
        XCTAssertEqual(mockService.getReposCounter, 1)
    }

    func testRepoProfileViewModel() {
        let mockService = MockRepositoryProfileService()
        let viewModel = RepositoryProfileViewModel(ownerRepo: self.owner, service: mockService)
        viewModel.fetchRepoProfileInfo(currentPage: 1)
        XCTAssertEqual(mockService.getProfileCounter, 1)

    }

}
