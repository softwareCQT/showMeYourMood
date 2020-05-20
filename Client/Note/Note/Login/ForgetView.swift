//
//  ForgetView.swift
//  Note
//
//  Created by 峰 on 2020/5/11.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct ForgetView: View {
    @State var userMail = ""
    @State var userPwd = ""
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
                        
                        HStack {
                            Text("密码")
                            UserSecureField(loginInfo: self.$userPwd,height: 40, placeholder: "请输入密码")
                        }
                        
                        SendVerifyCodeView(verifyCode: self.$verifyCode, isSending: self.$isSending, waitingTime: self.$waitingTime, userMail: self.userMail, request: AF.request(baseURL + passwordCodeURL, parameters: ["email" : self.userMail]))
                    }
                    
                    LoadingButton(success: self.$findSuccess,
                                  error: self.$findError,
                                  isShowing: self.$isShowing,
                                  
                                  request: AF.request(baseURL + updatePasswordURL,
                                   method: .post,
                                   parameters: ["email": self.userMail, "password": self.userPwd],
                                   encoder: JSONParameterEncoder.default),
                                  
                                  preRequest: AF.request(baseURL + validURL, parameters: ["email": self.userMail, "code": self.verifyCode]),
                                  successMsg: "注册成功！",
                                  title: "注册",
                                  vertifyBlock: {
                                    if self.verifyCode == "" { return (false, "验证码不可为空！")}
                                    if  self.userPwd == "" || self.userMail == "" { return (false, "输入不可为空！")}
                                    // 验证验证码
                                    return (true, nil)
                    })
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

