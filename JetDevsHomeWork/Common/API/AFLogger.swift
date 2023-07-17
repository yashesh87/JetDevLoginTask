//
//  AFLogger.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import Foundation
import Alamofire

final class AFLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "com.jetDevs.xhr.AFLogger")
    
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⌛️ Request Started: \(request)
        ⌛️ Body Data: \(body)
        """
        print(message)
    }
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let data = response.data else {
            return
        }
        print("⚡️ Response Received: \(data)")
        print(response.debugDescription)
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
    func asArray() throws -> [[String: Any]] {
      let data = try JSONEncoder().encode(self)
      guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else {
        throw NSError()
      }
      return dictionary
    }
    /// Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> String {
        let data = try encoder.encode(self)
        let result = String(decoding: data, as: UTF8.self)
        return result
    }
}
