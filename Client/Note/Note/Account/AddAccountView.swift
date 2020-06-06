//
//  AddAccountView.swift
//  Note
//
//  Created by 峰 on 2020/5/28.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct AddAccountView: View {
    @State var account = Account()
    @State var date = Date()
    @EnvironmentObject var accountStore: AccountStore
    @Binding var dismiss: Bool
    @State var isPushing = false
    @State var error: Bool = false
    @State var leave = false
    @State var moneyString = ""
    @State var message : String = "上传失败"
    
    func save() {
        let date = date2String1(self.date)
        guard let money = Float(moneyString) else {
            print(moneyString)
             message = "输入金额有误"
             self.error.toggle()
            return
        }
        let dict: Dictionary<String, Any> = ["money":money, "remarks": account.remarks, "date": date, "pay": account.pay, "type": account.type.string() ]
        
                var request = URLRequest(url: URL(string: baseURL + accountSaveURL)! )
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        
                request.headers = ["Authorization":Authorization!]
                AF.request(request).responseJSON { (response) in
                    print(response)
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
        //        LoadingView(isShowing: $isPushing) {
        
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
                        Alert(title: Text(message))
                    }).padding()
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                    
                }
                
            }.background(BlurView(style: .prominent))
            
            VStack {
                HStack() {
                    Text("金额:")
                        .foregroundColor(.secondary)
                    TextField("请输入金额", text: self.$moneyString)
                        .keyboardType(.decimalPad)
                }.frame(height: 50)
                VStack {
                    Divider()
                    HStack {
                        Text("是否为支出金额:")
                            .foregroundColor(.secondary)
                        Spacer()
                        Switch(isOn: self.$account.pay)
                    }
                }
                
                VStack {
                    Divider()
                    HStack {
                        Text("收支类型:")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    Picker(selection: self.$account.type, label: Text(AccountType.restaurant.rawValue), content: {
                        Text(AccountType.restaurant.rawValue).tag(AccountType.restaurant)
                        Text(AccountType.shop.rawValue).tag(AccountType.shop)
                        Text(AccountType.traffic.rawValue).tag(AccountType.traffic)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                VStack {
                    Divider()
                    HStack() {
                        Text("备注:")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    TextView1(text: self.$account.remarks).frame(numLines: 7)
                    Divider()
                }
                DatePicker(selection: self.$date, label: { Text("日期:") })
            }.padding()
            Spacer()
        }
    }
    //    }
}
