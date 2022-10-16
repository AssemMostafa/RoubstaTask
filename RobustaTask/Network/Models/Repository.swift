//
//  Repository.swift
//  RobustaTask
//
//  Created by Assem on 14/10/2022.
//

import Foundation

//struct RepositoryResponse: Codable{
////    let results: [Title]
//    let total_pages: Int
//    let total_results: Int
//}

struct Repository: Codable {
    let id: Int
    let name: String?
    let owner: Owner?
}

struct Owner: Codable {
    let id: Int
    let login: String?
    let avatar_url: String?
}

struct RepositoryOwner: Codable {
    let id: Int
    let login: String?
    let avatar_url: String?
    let name: String?
    let company: String?
    let location: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let following: Int?
    let created_at: String?
}
