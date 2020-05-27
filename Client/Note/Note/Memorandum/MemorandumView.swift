//
//  memorandumView.swift
//  Note
//
//  Created by 峰 on 2020/5/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct MemorandumView: View {
    @EnvironmentObject var memoStore: MemoStore
    @State var showProfile = false
    @State var showAdd = false
    @State var leave = false
    
    func delete(_ i: Int) {
        let id = self.memoStore.memos[i].id
        AF.request( baseURL + memoDeleteURL + String(id), method: .post, headers: ["Authorization": Authorization!]).responseJSON { response in
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
                self.memoStore.memos.remove(at: i)
                print("删除成功")
            }else {
                print("删除失败")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        memoStore.memos.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(memoStore.memos) { memo in
                        NavigationLink(destination:
                            MemoView(memo: memo, pushed: self.$leave)) {
                            VStack(alignment: .leading,  spacing: 8) {
                                
                                
                                Text(memo.content).lineLimit(1)
                                    .font(.title)
                                
                                HStack {
                                    Text("创建时间")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text(memo.createTime)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }.padding(.vertical)
                        }
                    }.onDelete { index in
                        for i in index {
                            self.delete(i)
                        }
                    }
                    .onMove(perform: move)
                }.navigationBarTitle("备忘录")
                    .navigationBarItems(
                        leading: Button(action: {
                            self.showProfile.toggle()
                        }) {
                            Image(systemName: "square.grid.2x2")
                                .renderingMode(.original)
                        },
                        trailing: EditButton()
                )
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
                            self.memoStore.load( { _ in
                                
                            })
                        }, content: {
                            AddMemoView(dismiss: self.$showAdd).environmentObject(self.memoStore)
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
        }.onAppear {
            self.memoStore.load({ _ in
                
            })
            
        }
    }
}
