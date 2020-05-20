//
//  NoteList.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI


struct NoteListView: View {
    @ObservedObject var noteStore = NoteStore()
    @State var showProfile = true
    
    func move(from source: IndexSet, to destination: Int) {
        noteStore.notes.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(noteStore.notes) { note in
                        NavigationLink(destination:
                        Text("dasda")) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.system(size: 25))
                                Text(note.date)
                                Text(note.subtitle)
                                    .font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }.onDelete { index in
                        for i in index {
                            self.noteStore.notes.remove(at: i)
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
            BlurView(style: .regular)
                .offset(x: 0, y: showProfile ? 0 : UIScreen.main.bounds.height)
                .onTapGesture {
                    self.showProfile.toggle()
            }
            MenuView()
                .offset(x: 0, y: showProfile ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}
struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
