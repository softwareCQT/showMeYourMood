//
//  AccountListView.swift
//  Note
//
//  Created by 峰 on 2020/5/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct AccountListView: View {
    @EnvironmentObject var accountStore: AccountStore
    @State var showProfile = false
    @State var showAdd = false
    @State var leave = false
    @EnvironmentObject var accountOutIn:  AccountOutIn
    func delete(_ i: Int) {
        let id = self.accountStore.accounts[i].id
        AF.request( baseURL + accountDeleteURL + String(id), method: .post, headers: ["Authorization": Authorization!]).responseJSON { response in
            var status = false
            // 登录模块
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if let authorization = dict["data"] as? String {
                    Authorization = authorization
                }
            }
            if status {
                self.accountStore.accounts.remove(at: i)
                print("删除成功")
                self.accountOutIn.load { _ in
                    
                }
            }else {
                print("删除失败")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        accountStore.accounts.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        ZStack {
            
            NavigationView {
                VStack{
                    
                    VStack(spacing: 2){
                        Text("净支出为 ¥" + accountOutIn.cost)
                        
                        HStack {
                            Text("总收入为¥" + accountOutIn.income)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("总支出为¥" + accountOutIn.outcome)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    Divider()
                    List {
                        ForEach(accountStore.accounts) { account in
                            NavigationLink(destination:
                            AccountView(account: account, pushed: self.$leave, moneyString: String(format: "%.2f", account.money.floatValue))) {
                                //                            Text("hello")
                                HStack {
                                    //
                                    VStack(alignment: .leading,  spacing: 4) {
                                        Text("分类：" + account.type.rawValue).lineLimit(1)
                                            .font(.subheadline)
                                        //
                                        Text("备注：" + account.remarks).lineLimit(1)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        
                                        Text( account.date).lineLimit(1)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text("¥" + String(format: "%.2f", account.money.floatValue) ).lineLimit(1)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text(PaytoString(pay: account.pay))
                                        .lineLimit(1)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                }.padding(.vertical)
                            }
                        }.onDelete { index in
                            for i in index {
                                self.delete(i)
                            }
                        }
                        .onMove(perform: move)
                    }
                }.navigationBarTitle("账本")
                    .navigationBarItems(
                        leading: Button(action: {
                            self.showProfile.toggle()
                        }) {
                            Image(systemName: "square.grid.2x2")
                                .renderingMode(.original)
                        },
                        trailing: EditButton()
                )
            }.onAppear {
                test()
                self.accountStore.load( { _ in })
                self.accountOutIn.load { _ in }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            self.showAdd.toggle()
                        }) {
                            ZStack {
                                BlurView(style: .regular).frame(width: 50, height: 50)
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }.sheet( isPresented: $showAdd, onDismiss: {
                            self.accountStore.load( { _ in })
                            self.accountOutIn.load { _ in }
                        }, content: {
                            AddAccountView(dismiss: self.$showAdd).environmentObject(self.accountStore)
                        })
                    }
                }
            }.padding()
                .offset(x: leave ? 100 : 0, y: 0)
                .animation(.spring())
            
            BlurView(style: .regular)
                .frame(width: showProfile ? UIScreen.main.bounds.width : 0, height: showProfile ? UIScreen.main.bounds.height : 0)
                .onTapGesture {
                    self.showProfile.toggle()
            }
            
            MenuView()
                .offset(x: 0, y: showProfile ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}
func test() {
    print("ddd")
}
