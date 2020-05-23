//
//  NoteList.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct NoteListView: View {
    @EnvironmentObject var noteStore: NoteStore
    @State var showProfile = false
    @State var showAdd = false
    @State var leave = false
    
    func delete(_ i: Int) {
        let id = self.noteStore.notes[i].id
        AF.request( baseURL + noteDeleteURL + String(id), method: .post, headers: ["Authorization": Authorization!]).responseJSON { response in
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
                self.noteStore.notes.remove(at: i)
                print("删除成功")
            }else {
                print("删除失败")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        noteStore.notes.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(noteStore.notes) { note in
                        NavigationLink(destination:
                        NoteView(note: note, pushed: self.$leave)) {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                    
                                Text(note.diaryName).lineLimit(1)
                                    .font(.system(size: 20))
                                Text(note.content).lineLimit(1)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                Text(note.date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }.onDelete { index in
                        for i in index {
                            self.delete(i)
                        }
                    }
                    .onMove(perform: move)
                }.navigationBarTitle("我的日记")
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
                    Button(action: {
                        self.showAdd.toggle()
                    }) {
                        ZStack {
                            BlurView(style: .regular).frame(width: 50, height: 50)
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("background2"), lineWidth: 2))
                        }
                    }.sheet( isPresented: $showAdd, onDismiss: {
                        self.noteStore.load( { _ in 
                            
                        })
                        }, content: {
                        AddNoteView(dismiss: self.$showAdd).environmentObject(self.noteStore)
                    })
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
            self.noteStore.load({ _ in
                
            })
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView().environmentObject(NoteStore())
    }
}
