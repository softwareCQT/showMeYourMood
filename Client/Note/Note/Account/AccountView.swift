//
//  AccountView.swift
//  Note
//
//  Created by 峰 on 2020/5/23.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct AccountView: View {
    @State var account: Account
    @EnvironmentObject var accountStore: AccountStore
    @EnvironmentObject var accountOutIn:  AccountOutIn
    @Binding var pushed: Bool
    @State var showAlert = false
    @State var message = ""
    @State var showDraw = false
    @State var moneyString = ""
    @State var date = Date()
    
    func noteIndex() -> Int? {
        accountStore.accounts.firstIndex(where: {
            $0.id == account.id
        })
    }
    
    func save() {
        let date = date2String1(self.date)
        guard let money = Float(moneyString) else {
            print(moneyString)
             message = "输入金额有误"
             self.showAlert.toggle()
            return
        }
        print(money)
        account.money = NSNumber(value: money)
        let dict: Dictionary<String, Any> = ["id": account.id, "money":money, "remarks": account.remarks, "date": date, "pay": account.pay, "type": account.type.string() ]

        var request = URLRequest(url: URL(string: baseURL + accountUpdateURL)! )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)

        request.headers = ["Authorization":Authorization!]
        AF.request(request).responseJSON { (response) in
            var status = false
            print(response)
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
            }

            if status {
                self.accountStore.accounts[self.noteIndex()!] = self.account
                self.accountOutIn.load { _ in }
                self.message = "保存成功"
            } else {
                self.message = "保存失败"
            }
            self.showAlert.toggle()
        }
    }
    
    var body: some View {
        List {
            
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
                        Text("是否为收入金额:")
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
        }
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
