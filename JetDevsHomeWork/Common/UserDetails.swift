//
//  UserDefaults.swift
//  JetDevsHomeWork
//
//  Created by MOB-051119-002 on 17/07/23.
//

import Foundation
import UIKit

public class UserDetails {
    
    static let shared = UserDetails()
    
    func storeUserData(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: "userDetails")
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func getUserDetails() -> User? {
        do {
            if let data = UserDefaults.standard.data(forKey: "userDetails") {
                return try JSONDecoder().decode(User.self, from: data)
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func removeUserData() {
        UserDefaults.standard.removeObject(forKey: "userDetails")
    }
}
