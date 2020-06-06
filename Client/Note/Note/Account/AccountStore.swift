//
//  AccountStore.swift
//  Note
//
//  Created by 峰 on 2020/5/23.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

func PaytoString(pay: Bool) -> String {
    if pay { return "支出" }
    else { return "收入" }
}

class Account: NSObject, Identifiable, NSCoding {
    
    var id :Int = -1
    var money: NSNumber = 0
    var date: String = date2String1(Date())
    var remarks: String
    var pay: Bool = true
    var type: AccountType
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? Int ?? -1
        self.money = coder.decodeObject(forKey: "money") as! NSNumber
        self.date = coder.decodeObject(forKey: "date") as! String
        self.remarks = coder.decodeObject(forKey: "remarks") as! String
        self.pay = coder.decodeObject(forKey: "pay") as! Bool
        self.type = AccountType.string2AccountType(coder.decodeObject(forKey: "type") as? String) ?? .restaurant
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.money, forKey: "money")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.remarks, forKey: "remarks")
        coder.encode(self.pay, forKey: "pay")
        coder.encode(self.type.string(), forKey: "type")
    }
    
    override init() {
        remarks = ""
        type = .restaurant
    }
    
    init(_ dict: Dictionary<String, Any>) {
        id = dict["id"] as? Int ?? -1
        money = dict["money"] as? NSNumber ?? NSNumber(0)
        date = dict["date"] as? String ?? ""
        remarks = dict["remarks"] as? String ?? ""
        pay = dict["pay"] as? Bool ?? false
        type = AccountType.string2AccountType(dict["type"] as? String) ?? .restaurant
    }
    //
}

final class AccountStore: ObservableObject {
    var objectWillChange = PassthroughSubject<AccountStore, Never>()
    var accounts: [Account] = [] {
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
        AF.request(baseURL + accountGetURL, parameters: ["page": page, "size": size], headers: ["Authorization": Authorization!]).responseJSON { response in
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if status {
                    if let data = dict["data"] as? Dictionary<String, Any> {
                        if let list = data["list"] as? Array<Any> {
                            self.accounts.removeAll()
                            for itemDic in list {
                                self.accounts.append(Account(itemDic as! Dictionary<String, Any>))
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

enum AccountType: String, CaseIterable {
    case restaurant = "餐饮"
    case shop = "购物"
    case traffic = "交通"
    func string() -> String {
        switch self {
        case .restaurant:
            return "1"
        case .shop:
            return "2"
        case .traffic:
            return "3"
        }
    }
    static func string2AccountType(_ string: String?) -> AccountType? {
        switch string {
        case "餐饮":
            return .restaurant
        case "购物":
            return .shop
        case "交通":
            return .traffic
        default:
            return nil
        }
    }
}


final class AccountOutIn: ObservableObject {
    var objectWillChange = PassthroughSubject<AccountOutIn, Never>()
    var outcome: String = "0" {
        didSet {
            objectWillChange.send(self)
        }
    }
    var income: String = "0" {
        didSet {
            objectWillChange.send(self)
        }
    }
    var cost: String = "0" {
        didSet {
            objectWillChange.send(self)
        }
    }
    init() {
        load( {
            print($0)
        })
    }
    
    func load(_ result: @escaping (Bool) -> ()) {
        
        AF.request(baseURL + accountSumURL, headers: ["Authorization": Authorization!]).responseJSON { response in
            
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if status {
                    if let data = dict["data"] as? Dictionary<String, Any> {
                        let outcome = (data["outcome"] as! NSNumber).floatValue
                        let income = (data["income"] as! NSNumber).floatValue
                        self.outcome = String(format: "%.2f", outcome)
                        self.income = String(format: "%.2f", income)
                        self.cost = String(format: "%.2f", outcome - income)
                    }
                    result(true)
                } else {
                    result(false)
                }
            }
        }
    }
}
