//
//  ContentView.swift
//  Note
//
//  Created by 峰 on 2020/4/26.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var userpwd = ""
    @State var showAlert = false
    @State var showHud = false
    @State var loginSuccess = false
    
    // 网络请求
    private func loginApi(_ result: @escaping (Bool) -> ()) {
        
        #warning("TODO - 发起网络请求校验密码和用户名")
        DispatchQueue.global().async() {
            sleep(1)
            DispatchQueue.main.async {
                if self.username == "123456" && self.userpwd == "123456" {
                    result(true)
                }
                else {
                    result(false)
                }
            }
        }
        
    }
    
    var body: some View {
       
            ZStack {
                VStack(spacing: 37) {
                    VStack(spacing: 24) {
                        // 输入框
                        LoginTextField(loginInfo: $username, placeholder: "Username")
                        LoginTextField(loginInfo: $userpwd, placeholder: "Password")
                    }.frame(width: 300)
                    
                    Button("Login") {
                        self.showHud.toggle()
                        self.loginApi({
                            self.showHud.toggle()
                            if $0 {
                                #warning("TODO - 跳转")
                                self.loginSuccess = true
                                return
                            }
                            else {
                                self.showAlert.toggle()
                            }
                        })
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("登录失败，请检查用户名及密码！"))
                    })
                        .frame(width: 300, height: 42)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }.blur(radius: showHud ? 2 : 0)
                
                if showHud {
                    ActivityIndicator(style: .large)
                }
        }
    }
}

// 用户名输入框 用户密码输入框
struct LoginTextField: View {
    @Binding var loginInfo : String
    let placeholder : String
    var body: some View {
        HStack {
            TextField(placeholder, text:$loginInfo)
                .frame(height: 42)
        }.padding(.leading, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.949000001, green: 0.949000001, blue: 0.9689999819, alpha: 1)))
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

struct ActivityIndicator: UIViewRepresentable {
    
    var isAnimating = true
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

