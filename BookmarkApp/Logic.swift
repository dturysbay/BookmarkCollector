//
//  Logic.swift
//  BookmarkApp
//
//  Created by Dinmukhambet Turysbay on 19.04.2023.
//

import Foundation
import SwiftUI

enum StorageStates: String{
    case isOnboardingSeen
    case main
    case arrayOfTitles
    case arrayOfLinks
}

let defaults = UserDefaults.standard
 
class Bookmark: Codable, Identifiable{
    var id: Int = 0
    let title: String
    let link: String
    
    init(title: String, link: String) {
        self.id += 1
        self.title = title
        self.link = link
    }
}



struct Bookmarks{
    @AppStorage(StorageStates.arrayOfTitles.rawValue) static var arrayOfTitles:[String] = []
    @AppStorage(StorageStates.arrayOfLinks.rawValue) static var arrayOfLinks:[String] = []
}


@propertyWrapper
struct AppDataStorage<T:Codable>{
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    
    var wrappedValue:T{
        get {
            guard let data = try? UserDefaults.standard.object(forKey: key) as? Data else{
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set{
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data,forKey: key)
        }
    }
    
}


extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

// task list
// 1. onboarding page should be included to user defaults ✅
// 2. array of bookmarks list inside of the user defaults ✅
// 3. empty view if list of bookmarks is empty ✅
// 4. bottom sheet should be implemented for adding tasks to the array of bookmarks ✅
// 5.delete of bookmark ✅
// 6. browser should be opened on click to the link ✅
