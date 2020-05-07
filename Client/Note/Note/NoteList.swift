//
//  NoteList.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct NoteList: View {
    var body: some View {
        // 这里字体看着改
        NavigationView {

            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("2019年4月5日")
                        Text("笔记标题")
                            .font(.system(size: 25))
                        
                        Text("笔记副标题")
                            .font(.subheadline).foregroundColor(.secondary)
                    }
                
            }.navigationBarTitle("我的日记")
            
        }
        
        
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
