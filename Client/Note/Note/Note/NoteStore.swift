//
//  NoteStore.swift
//  Note
//
//  Created by 峰 on 2020/5/14.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

struct MyNote: Identifiable {
    var id: Int
    var date: String
    var content: String
    var diaryName: String
    var emoji: Emoji
    var weather: Weather
    
    // 待定
    var userId: String
    
    init() {
        id = -1
        date = date2String(Date()) 
        content = ""
        diaryName = ""
        emoji = Emoji.happy
        weather = Weather.sunny
        userId = ""
    }
    init(_ dict: Dictionary<String, Any>) {
        id = dict["id"] as? Int ?? -1
        date = dict["date"] as? String ?? ""
        content = dict["content"] as? String ?? ""
        diaryName = dict["diaryName"] as? String ?? ""
        emoji = Emoji.string2emoji(dict["emoji"] as? String) ?? Emoji.happy
        weather = Weather.string2weather(dict["weather"] as? String) ?? Weather.sunny
        userId = dict["userId"] as? String ?? ""
    }
    
}

enum Emoji: String, CaseIterable {
    case happy = "😊"
    case sad = "😭"
    case angry = "😠"
    func emoji2String() -> String {
        switch self {
        case .happy:
            return "1"
        case .sad:
            return "2"
        case .angry:
            return "3"
        }
    }
    static func string2emoji(_ string: String?) -> Emoji? {
        switch string {
        case "1":
            return .happy
        case "2":
            return .sad
        case "3":
            return .angry
        default:
            return nil
        }
    }
}
enum Weather: String, CaseIterable {
    case sunny = "☀️"
    case snowy = "❄️"
    case rainy = "☔️"
    func weather2String() -> String {
        switch self {
        case .sunny:
            return "1"
        case .snowy:
            return "2"
        case .rainy:
            return "3"
        }
    }
    static func string2weather(_ string: String?) -> Weather? {
        switch string {
        case "1":
            return .sunny
        case "2":
            return .snowy
        case "3":
            return .rainy
        default:
            return nil
        }
    }
}

final class NoteStore: ObservableObject {
    var objectWillChange = PassthroughSubject<NoteStore, Never>()
    var notes: [MyNote] = [] {
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
        AF.request(baseURL + noteGetURL, parameters: ["page": page, "size": size], headers: ["Authorization": Authorization!]).responseJSON { response in
            
            
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if status {
                    if let data = dict["data"] as? Dictionary<String, Any> {
                        if let list = data["list"] as? Array<Any> {
                            self.notes.removeAll()
                            for itemDic in list {
                                self.notes.append(MyNote(itemDic as! Dictionary<String, Any>)) 
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

func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "zh_CN")
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: date)
    return date
}
