//
//  AddMemoView.swift
//  Note
//
//  Created by 峰 on 2020/5/27.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct AddMemoView: View {
    @State var date = Date()
    @State var memo = Memoran()
    @EnvironmentObject var memoStore: MemoStore
    @Binding var dismiss: Bool
    @State var isPushing = false
    @State var error: Bool = false
    @State var leave = false
    
    func save() {
        let date = date2String1(self.date)
        print(date)
        let dict: Dictionary<String, Any> = ["memorandum": ["content": memo.content, "createTime": memo.createTime], "date": date ]
        
        var request = URLRequest(url: URL(string: baseURL + memoSaveURL)! )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        
        request.headers = ["Authorization":Authorization!]
        AF.request(request).responseJSON { (response) in
            // 上传中
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
            }
            print(response.error.debugDescription)
            self.isPushing.toggle()
            if status {
                self.dismiss.toggle()
            }else {
                //上传失败
                self.error.toggle()
            }

        }
    }
    
    var body: some View {
        LoadingView(isShowing: $isPushing) {
            
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // 上传
                            self.isPushing.toggle()
                            self.save()
                        }, label: {
                            Text("保存")
                        }).alert(isPresented: self.$error, content: {
                            Alert(title: Text("上传失败！"))
                        }).padding()
                            .padding(.trailing, 10)
                            .padding(.top, 10)
                        
                    }
                    
                }.background(BlurView(style: .prominent))
                
                VStack {
                    TextView1(text: self.$memo.content).frame(numLines: 25)
                    
                    
                    DatePicker(selection: .constant(Date()), label: { Text("提醒日期") })
                }
                
                Divider()
                
            }
        }
    }
}
