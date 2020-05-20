//
//  LogonView.swift
//  Note
//
//  Created by 峰 on 2020/5/11.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

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
                            UserSecureField(loginInfo: self.$userPwd,height: 40, placeholder: "请输入密码")
                        }
                        
                        SendVerifyCodeView(verifyCode: self.$verifyCode, isSending: self.$isSending, waitingTime: self.$waitingTime, userMail: self.userMail, request: AF.request(baseURL + registerCodeURL, parameters: ["email" : self.userMail]))
                        
                        HStack {
                            Text("确认密码")
                            UserSecureField(loginInfo: self.$rePwd, height: 40, placeholder: "请再次输入密码")
                        }
                    }
                }.padding()
                
                LoadingButton(success: self.$logonSuccess,
                              error: self.$logonError,
                              isShowing: self.$isShowing,
                              
                              request:
                    AF.request(baseURL + logonURL,
                               method: .post,
                               parameters: ["email": self.userMail, "password": self.userPwd],
                               encoder: JSONParameterEncoder.default),
                              
                              preRequest: AF.request(baseURL + validURL, parameters: ["email": self.userMail, "code": self.verifyCode]),
                              successMsg: "注册成功！",
                              title: "注册",
                              vertifyBlock: {
                                if self.verifyCode == "" { return (false, "验证码不可为空！")}
                                if self.rePwd == "" || self.userPwd == "" || self.userMail == "" { return (false, "输入不可为空！")}
                                if self.rePwd != self.userPwd {return (false, "两次密码输入不同！")}
                                // 验证验证码
                                return (true, nil)
                })
                
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
    var userMail: String
    @State var message: String = ""
    @State var showMes = false
    var request: DataRequest
    
    // 这里可以改善
    @State private var timer: DispatchSourceTimer?
    
    var body: some View {
        HStack {
            Text("验证码")
            UserTextField(loginInfo: self.$verifyCode, height: 40, placeholder: "请输入验证码")
            Button(isSending ? "等待\(waitingTime)秒":"发送验证码") {
                guard self.userMail != "" else {
                    self.showMes.toggle()
                    self.message = "邮箱不可为空！"
                    return
                }
                
                // 发送验证码
                self.request.responseJSON { response in
                    
                    var status = false
                    
                    if let dict = response.value as? Dictionary<String, Any> {
                        if let code = dict["code"] as? Int {
                            status = (code == 200)
                        }
                    }
                    
                    if status {
                        self.isSending.toggle()
                        self.message = "发送成功，请注意邮箱！"
                        self.showMes.toggle()
                        // 倒数计时
                        self.timer = DispatchSource.makeTimerSource()
                        self.timer!.schedule(deadline: DispatchTime.now(), repeating: 1)
                        
                        self.timer!.setEventHandler {
                            
                            self.waitingTime -= 1
                            if self.waitingTime == 0 {
                                self.timer!.cancel()
                                self.waitingTime = 60
                                self.isSending.toggle()
                            }
                        }
                        self.timer!.resume()
                    }else {
                        self.showMes.toggle()
                        self.message = "发送失败，请检查邮箱格式！"
                    }
                }
            }.disabled(isSending)
            .alert(isPresented: self.$showMes, content: {
                return Alert(title: Text(message))
            })
        }
    }
}
