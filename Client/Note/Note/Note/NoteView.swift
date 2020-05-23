//
//  NoteView.swift
//  Note
//
//  Created by 峰 on 2020/5/20.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct NoteView: View {
    @State var note: MyNote
    @EnvironmentObject var noteStore: NoteStore
    @Binding var pushed: Bool
    @State var showAlert = false
    @State var message = ""
    
    func noteIndex() -> Int? {
        noteStore.notes.firstIndex(where: {
            $0.id == note.id
        })
    }
    
    func save() {
        let dict: Dictionary<String, Any> = ["id": note.id, "content": note.content, "date": note.date, "emoji": note.emoji.emoji2String(), "weather": note.weather.weather2String()]
        
        var request = URLRequest(url: URL(string: baseURL + noteUpdateURL)! )
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
                self.noteStore.notes[self.noteIndex()!].content = self.note.content
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
                
                TextView(text: $note.content).frame(numLines: 25)
                
                Divider()
                
                HStack {
                    Text("心情")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
                Picker(selection: self.$note.emoji, label: Text(Emoji.happy.rawValue), content: {
                    Text(Emoji.happy.rawValue).tag(Emoji.happy)
                    Text(Emoji.sad.rawValue).tag(Emoji.sad)
                    Text(Emoji.angry.rawValue).tag(Emoji.angry)
                })
                    .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Text("天气：" + note.weather.rawValue )
                        .font(.footnote)
                        .foregroundColor(.secondary).padding(.vertical)
                    
                    Spacer()
                }
            }
        }.navigationBarTitle(note.date)
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
