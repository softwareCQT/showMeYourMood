//
//  AccountStore.swift
//  Note
//
//  Created by 峰 on 2020/5/23.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Combine

class Account: NSObject, Identifiable, NSCoding {
    
    var id = UUID()
    var sort: String
    var more: String
    var cost: Int = 0

    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? UUID ?? UUID()
        self.sort = coder.decodeObject(forKey: "sort") as! String
        self.more = coder.decodeObject(forKey: "more") as! String
        self.cost = coder.decodeObject(forKey: "cost") as! Int
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.sort, forKey: "sort")
        coder.encode(self.more, forKey: "more")
        coder.encode(self.cost, forKey: "cost")
    }
    
    override init() {
        sort = "购物"
        more = ""
    }
    
//    init(_ dict: Dictionary<String, Any>) {
//        id = dict["id"] as? Int ?? -1
//        date = dict["date"] as? String ?? ""
//        content = dict["content"] as? String ?? ""
//        diaryName = dict["diaryName"] as? String ?? ""
//        emoji = Emoji.string2emoji(dict["emoji"] as? String) ?? Emoji.happy
//        weather = Weather.string2weather(dict["weather"] as? String) ?? Weather.sunny
//        userId = dict["userId"] as? String ?? ""
//    }
//
}
final class AccountStore: ObservableObject {
    var objectWillChange = PassthroughSubject<AccountStore, Never>()
    var notes: [Account] = [] {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init() {
        load( {
            print($0)
        })
    }
    
    func load(_ result: @escaping (Bool) -> (), page: Int = 1, size: Int = 100) {
        
        
        
        
//        AF.request(baseURL + noteGetURL, parameters: ["page": page, "size": size], headers: ["Authorization": Authorization!]).responseJSON { response in
//
//
//            var status = false
//            if let dict = response.value as? Dictionary<String, Any> {
//                if let code = dict["code"] as? Int {
//                    status = (code == 200)
//                }
//                if status {
//                    if let data = dict["data"] as? Dictionary<String, Any> {
//                        if let list = data["list"] as? Array<Any> {
//                            self.notes.removeAll()
//                            for itemDic in list {
//                                self.notes.append(MyNote(itemDic as! Dictionary<String, Any>))
//                            }
//                        }
//
//                    }
//                    result(true)
//                } else {
//                    result(false)
//                }
//            }
//        }
    }
}
