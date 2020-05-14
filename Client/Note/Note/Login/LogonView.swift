//
//  LogonView.swift
//  Note
//
//  Created by 峰 on 2020/5/11.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct LogonView: View {
    @State var userMail = ""
    @State var userPwd = ""
    @State var verifyCode = ""
    @State var rePwd = ""
    
    @State var isShowing = false
    @State var logonError = false
    @State var logonSuccess = false
    @State var isSending = false
    @State var waitingTime = 60
    
    var body: some View {
        LoadingView(isShowing: $isShowing) {
            VStack(spacing: 70) {
                VStack(spacing: 95) {
                    Text("注册")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    VStack {
                        HStack {
                            Text("邮箱")
                            UserTextField(loginInfo: self.$userMail,
                                          height: 40,placeholder: "请输入您的邮箱号")
                            
                        }
                        
                        HStack {
                            Text("密码")
                            UserTextField(loginInfo: self.$userPwd,height: 40, placeholder: "请输入密码")
                        }
                        
                        SendVerifyCodeView(verifyCode: self.$verifyCode, isSending: self.$isSending, waitingTime: self.$waitingTime)
                        
                        HStack {
                            Text("确认密码")
                            UserTextField(loginInfo: self.$rePwd, height: 40, placeholder: "请再次输入密码")
                        }
                    }
                }.padding()
                
                LoadingButton(success: self.$logonSuccess, error: self.$logonError, isShowing: self.$isShowing, request: {
                    self.userMail == "123456" && self.userPwd == "123456" ? true : false
                }, message: "注册失败！", title: "注册")
                
                
                Spacer()
            }.padding()
        }
    }
}

struct LogonView_Previews: PreviewProvider {
    static var previews: some View {
        LogonView()
    }
}


struct SendVerifyCodeView: View {
    @Binding var verifyCode: String
    @Binding var isSending: Bool
    @Binding var waitingTime: Int
    // 这里可以改善
    @State private var timer  = DispatchSource.makeTimerSource()
    
    var body: some View {
        HStack {
            Text("验证码")
            UserTextField(loginInfo: self.$verifyCode, height: 40, placeholder: "请输入验证码")
            Button(isSending ? "等待\(waitingTime)秒":"发送验证码") {
                
                self.isSending.toggle()
                
                // 倒数计时
                self.timer = DispatchSource.makeTimerSource()
                self.timer.schedule(deadline: DispatchTime.now(), repeating: 1)
                
                self.timer.setEventHandler {
                   
                   self.waitingTime -= 1
                    if self.waitingTime == 0 {
                        self.timer.cancel()
                        self.waitingTime = 60
                        self.isSending.toggle()
                    }
                }
                self.timer.resume()
            }.disabled(isSending)
        }
    }
}
