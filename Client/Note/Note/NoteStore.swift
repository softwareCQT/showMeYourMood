//
//  NoteStore.swift
//  Note
//
//  Created by 峰 on 2020/5/14.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Combine

var notesa = [
    MyNote(date: "2019年4月5日", title: "笔记标题4", subtitle: "笔记副标题4"),
    MyNote(date: "2019年4月4日", title: "笔记标题3", subtitle: "笔记副标题3"),
    MyNote(date: "2019年4月3日", title: "笔记标题2", subtitle: "笔记副标题2"),
    MyNote(date: "2019年4月2日", title: "笔记标题1", subtitle: "笔记副标题1")
]
struct MyNote: Identifiable {
    var id = UUID()
    var date: String
    var title: String
    var subtitle: String
}


class NoteStore: ObservableObject {
    @Published var notes: [MyNote] = notesa
}
