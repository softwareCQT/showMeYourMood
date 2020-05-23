//
//  FFUserDefault.swift
//  Note
//
//  Created by 峰 on 2020/5/23.
//  Copyright © 2020 峰. All rights reserved.
//

import Foundation
final class FFUserDefalut {
    static func saveValue(_ value: Any, forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(value, forKey: key)
        userDefault.synchronize()
    }

    static func value(forKey key: String) -> Any? {
        UserDefaults.standard.value(forKey: key)
    }

    static func removeObject(forKey key: String) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }
}
