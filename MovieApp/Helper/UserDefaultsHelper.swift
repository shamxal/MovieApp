//
//  UserDefaultsHelper.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 31.07.24.
//

import Foundation

class UserDefaultsHelper {
    enum UserDefault: String {
        case userId
        case premium
        case darkMode
        case isLoggedIn
        case introPassed
        case appOpenCount
        
        static let items: [UserDefault] = [.userId, .premium, .darkMode, .isLoggedIn, .introPassed, .appOpenCount]
    }
    
    static func save(value: String, key: UserDefault) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    static func get(key: UserDefault) -> String {
        UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    static func save(value: Bool, key: UserDefault) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    static func get(key: UserDefault) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func delete() {
        UserDefault.items.forEach { item in
            UserDefaults.standard.removeObject(forKey: item.rawValue)
        }
    }
    
    static func isPremium() -> Bool {
        if UserDefaultsHelper.get(key: .premium) == PremiumType.yes.rawValue {
            return true
        } else {
            return false
        }
    }
}
