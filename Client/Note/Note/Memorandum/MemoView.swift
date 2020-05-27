//
//  MemoView.swift
//  Note
//
//  Created by 峰 on 2020/5/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct MemoView: View {
    @State var memo: Memoran
    @EnvironmentObject var memoStore: MemoStore
    @Binding var pushed: Bool
    @State var showAlert = false
    @State var message = ""
    @State var showDraw = false
    
    func noteIndex() -> Int? {
        memoStore.memos.firstIndex(where: {
            $0.id == memo.id
        })
    }
    
    func save() {
        let dict: Dictionary<String, Any> = ["id": memo.id, "content": memo.content]

        var request = URLRequest(url: URL(string: baseURL + memoUpdateURL)! )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        
        request.headers = ["Authorization":Authorization!]
        AF.request(request).responseJSON { (response) in
            var status = false

            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
            }

            if status {
                self.memoStore.memos[self.noteIndex()!].content = self.memo.content
                self.message = "保存成功"
            } else {
                self.message = "保存失败"
            }
            self.showAlert.toggle()
        }
    }
    
    var body: some View {
        List {
                TextView1(text: $memo.content).frame(numLines: 25)
                

        }.navigationBarTitle(memo.createTime)
            .navigationBarItems(
                
                trailing: Button(action: {
                    self.save()
                }, label: { Text("保存") }).alert(isPresented: self.$showAlert, content: { () -> Alert in
                     Alert(title: Text(message))
                })
        ).onDisappear(perform: {
                self.pushed.toggle()
            })
            .onAppear {
                self.pushed.toggle()
        }
    }
}
