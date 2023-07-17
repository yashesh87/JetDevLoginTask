//
//  LoginResponse.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//
import Foundation

struct LoginResponse: Codable {
    var result: Int?
    var errorMessage: String?
    var data: UserData?

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
        case data
    }
}

struct UserData: Codable {
    var user: User?
}

struct User: Codable {
    var userID: Int?
    var userName: String?
    var userProfileURL: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userProfileURL = "user_profile_url"
        case createdAt = "created_at"
    }
}
