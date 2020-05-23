//
//  MunuView.swift
//  Note
//
//  Created by 峰 on 2020/5/14.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack() {
            Spacer()
            MenuRow(title: "我的日记", icon: "person.circle", btnClickBlock: {
                AppWindow!.rootViewController = UIHostingController(rootView: NoteListView().environmentObject(NoteStore()))
            })
            MenuRow(title: "账本管理", icon: "cart", btnClickBlock: {
                AppWindow!.rootViewController = UIHostingController(rootView: AccountView())
            })
            Divider()
            MenuRow(title: "退出登录", icon: "arrowshape.turn.up.right", btnClickBlock: {
                FFUserDefalut.removeObject(forKey: "Authorization")
                AppWindow!.rootViewController = UIHostingController(rootView: LoginView())
            })
            Spacer()
        }.padding()
            .frame(maxWidth: 300)
            .frame(height: 250)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .offset(y: -30)
    }
}


struct MunuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    
    var btnClickBlock: () -> () = {
        
    }
    
    var body: some View {
        Button(action: {
            self.btnClickBlock()
        }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .light))
                    .imageScale(.medium)
                    .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
            }
        }.foregroundColor(.black)
    }
}
