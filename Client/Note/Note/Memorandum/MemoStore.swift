//
//  MemoStore.swift
//  Note
//
//  Created by 峰 on 2020/5/26.
//  Copyright © 2020 峰. All rights reserved.
//


import SwiftUI
import Combine
import Alamofire

class Memoran: NSObject, Identifiable, NSCoding {
   
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? Int ?? -1
        self.createTime = coder.decodeObject(forKey: "createTime") as! String
        self.content = coder.decodeObject(forKey: "content") as! String
        self.date = coder.decodeObject(forKey: "date") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.content, forKey: "content")
        coder.encode(self.createTime, forKey: "createTime")
    }
    
    var id: Int
    var date: String
    var content: String
    var createTime: String
    
    override init() {
        id = -1
        createTime = date2String(Date())
        date = date2String1(Date())
        content = ""
    }
    init(_ dict: Dictionary<String, Any>) {
        id = dict["id"] as? Int ?? -1
        date = dict["date"] as? String ?? ""
        content = dict["content"] as? String ?? ""
        createTime = dict["createTime"] as? String ?? ""
    }
    
}

final class MemoStore: ObservableObject {
    var objectWillChange = PassthroughSubject<MemoStore, Never>()
    var memos: [Memoran] = [] {
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
        AF.request(baseURL + memoGetURL, parameters: ["page": page, "size": size], headers: ["Authorization": Authorization!]).responseJSON { response in


            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if status {
                    if let data = dict["data"] as? Dictionary<String, Any> {
                        if let list = data["list"] as? Array<Any> {
                            self.memos.removeAll()
                            for itemDic in list {
                                self.memos.append(Memoran(itemDic as! Dictionary<String, Any>))
                            }
                        }

                    }
                    result(true)
                } else {
                    result(false)
                }
            }
        }
    }
}
