//
//  ContentView.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var userMail = ""
    @State var userPwd = ""
    @State var isShowing = false
    @State var loginError = false
    @State var loginSuccess = false
    @State var pushLogon = false
    @State var pushForget = false
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        LoadingView(isShowing: $isShowing) {
            VStack {
                Image("LoginBg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                
                VStack(spacing: 64) {
                    VStack(alignment:.trailing, spacing: 21) {
                        // 输入框
                        UserTextField(loginInfo: self.$userMail, placeholder: "请输入邮箱")
                        UserTextField(loginInfo: self.$userPwd, placeholder: "请输入密码")
                        Button("忘记密码?") {
                            self.pushForget.toggle()
                        }.sheet(isPresented: self.$pushForget, content: {
                            ForgetView()
                        })
                    }.frame(width: 300)
                    
                    VStack(spacing: 21) {
                        LoadingButton(success: self.$loginSuccess, error: self.$loginError, isShowing: self.$isShowing, request: {
                        self.userMail == "123456" && self.userPwd == "123456" ? true : false
                        }, message: "邮箱或验证码不正确！", title: "登录")
                        
                        
                        Button("注册") {
                            self.pushLogon.toggle()
                        }.sheet(isPresented: self.$pushLogon, content: {
                            LogonView()
                        })
                            .frame(width: 300, height: 42)
                            .background(Color("lightGreenColor"))
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }
                }
            }
            
        }.offset(y: keyboardResponder.currentHeight == 0 ? 0 : -keyboardResponder.currentHeight + 169)
            .animation(.spring())
    }
}

// 用户名输入框 用户密码输入框
struct UserTextField: View {
    @Binding var loginInfo : String
    var height: CGFloat = 42
    let placeholder : String
    var body: some View {
        HStack {
            TextField(placeholder, text:$loginInfo)
                .frame(height: height)
        }.padding(.leading, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color("lineColor"))
        )
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
