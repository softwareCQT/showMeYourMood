//
//  LoadingButton.swift
//  Note
//
//  Created by 峰 on 2020/5/12.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

struct LoadingButton: View {
    @Binding var success: Bool
    @Binding var error: Bool
    @Binding var isShowing: Bool
    // 网络请求
    var request : (() -> (Bool))?
    var message = "输入不正确！"
    var title = "确认"
    
    private func api(_ result: @escaping (Bool) -> ()) {
        DispatchQueue.global().async() {
            #warning("TODO - 发起网络请求校验")
            guard let request = self.request else{
                return
            }
            let status = request()   // 发网络请求
            sleep(1)
            DispatchQueue.main.async {
                if status {
                    result(true)
                }
                else {
                    result(false)
                }
            }
        }
    }
    
    var body: some View {
        Button(title) {
            #warning("TODO - 找回密码")
            self.isShowing.toggle()
            
            self.api {
                self.isShowing.toggle()
                if $0 {
                    self.success.toggle()
                }else {
                    self.error.toggle()
                }
            }
        }.alert(isPresented: self.$error, content: {
            Alert(title: Text(message))
        })
            .frame(width: 300, height: 42)
            .background(Color("lightBlueColor"))
            .foregroundColor(.white)
            .cornerRadius(4)
    }
}
