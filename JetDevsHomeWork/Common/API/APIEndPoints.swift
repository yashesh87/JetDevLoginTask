//
//  APIEndPoints.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import Foundation
import Alamofire

enum APIEndPoints {
    
    case login([String: Any])
    
    func getUrl() -> String {
        switch self {
        case .login:
            return "https://3d02g.mocklab.io/login"
        }
    }
    
    func getMethodType() -> HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    func getRequestParams() -> Parameters {
        switch self {
        case .login(let request):
            return request
        }
    }
}
