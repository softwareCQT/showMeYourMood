//
//  AddNoteView.swift
//  Note
//
//  Created by 峰 on 2020/5/22.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct AddNoteView: View {
    @EnvironmentObject var noteStore: NoteStore
    @Binding var dismiss: Bool
    @State var note = MyNote()
    @State var isPushing = false
    func save() {
        AF.request(baseURL + noteSaveURL, method: .post, parameters: ["diaryName": note.diaryName, "content": note.content, "date": note.date, "emoji": note.emoji.emoji2String(), "weather": note.weather.weather2String()], encoder: JSONParameterEncoder.default, headers: ["Authorization": Authorization!]).responseJSON { response in
            // 上传中
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
            }
            self.isPushing.toggle()
            if status {
                // 上传成功
//                print(self.note.content, self.note.diaryName)
//                print("上传成功！")
//                self.noteStore.append(note: self.note)
                self.dismiss.toggle()
            }else {
                //上传失败
                print("上传失败！")
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
                        }).padding()
                            .padding(.trailing, 10)
                            .padding(.top, 10)
                        
                    }
                    HStack {
                        Text(self.note.date)
                            .font(.title)
                            .padding(.bottom, 10)
                        Spacer()
                    }.padding(.horizontal)
                    
                }.background(BlurView(style: .prominent))
                
                TextField("标题", text: self.$note.diaryName)
                    .font(.title).padding(.horizontal)
                
                Divider()
                TextView(text: self.$note.content)
                    .frame(numLines: 20).padding()
                
                Divider()
                VStack {
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
                        Text("天气")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    Picker(Weather.sunny.rawValue, selection: self.$note.weather) {
                        Text(Weather.sunny.rawValue).tag(Weather.sunny)
                        Text(Weather.rainy.rawValue).tag(Weather.rainy)
                        Text(Weather.snowy.rawValue).tag(Weather.snowy)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Spacer()
                }.padding()
                Spacer()
            }
        }
    }
}
