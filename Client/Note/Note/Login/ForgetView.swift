//
//  ForgetView.swift
//  Note
//
//  Created by 峰 on 2020/5/11.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct ForgetView: View {
    @State var userMail = ""
    @State var verifyCode = ""
    @State var isShowing = false
    @State var isSending = false
    @State var findError = false
    @State var findSuccess = false
    
    @State var waitingTime = 60
    
    var body: some View {
        
        LoadingView(isShowing: $isShowing) {
            VStack(spacing: 70) {
                Text("找回密码")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                VStack(spacing: 95) {
                    VStack {
                        HStack {
                            Text("邮箱")
                            UserTextField(loginInfo: self.$userMail,
                                          height: 40,placeholder: "请输入注册时使用的邮箱号")
                        }
                        
                        SendVerifyCodeView(verifyCode: self.$verifyCode, isSending: self.$isSending, waitingTime: self.$waitingTime)
                        
                    }
                    LoadingButton(success: self.$findSuccess, error: self.$findError, isShowing: self.$isShowing, request: {
                        self.userMail == "123456" && self.verifyCode == "123456" ? true : false
                        }, message: "邮箱或验证码不正确！")
                        
                }
                Spacer()
            }.padding()
        }
    }
}

struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView()
    }
}

