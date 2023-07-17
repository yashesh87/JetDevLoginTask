//
//  APIService.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import Foundation
import Alamofire

final class APIService {
    
    static let sharedInstance = APIService()
    
    lazy private var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 120
        return Session(configuration: configuration, eventMonitors: [AFLogger()])
    }()
    
    func wsCall <T: Codable>(apiEndPoint: APIEndPoints, model: T.Type, isSilentCall: Bool = false, success: @escaping (T) -> Void, failure: @escaping (AFError) -> Void) {
        
        session.request(
            apiEndPoint.getUrl(),
            method: apiEndPoint.getMethodType(),
            parameters: apiEndPoint.getRequestParams(),
            encoding: apiEndPoint.getMethodType() == .post ? JSONEncoding.default: URLEncoding.default,
            headers: nil
        )
        .validate(contentType: ["application/json"])
        .response { response in
            switch response.result {
            case .success(let data) :
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        success(response)
                    } catch let exception {
                        let strDefaultResponse = "{message:\(exception.localizedDescription),success: false}"
                        
                        if let data = strDefaultResponse.data(using: String.Encoding.utf8) {
                            if let response = try? JSONDecoder().decode(model, from: data) {
                                success(response)
                            }
                        }
                    }
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
