//
//  LoadingButton.swift
//  Note
//
//  Created by 峰 on 2020/5/12.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI
import Alamofire

struct LoadingButton: View {
    @Binding var success: Bool
    @Binding var error: Bool
    @Binding var isShowing: Bool
    @State var showMes = false
    // 网络请求
    var request : DataRequest?
    var preRequest : DataRequest?
    @State var message = ""
    var successMsg = "操作成功！"
    var title = "确认"
    var showSuccess = true
    
    var vertifyBlock: () -> (Bool, String?) = {
        return (true, nil)
    }
    var passBlock: () -> () = {}
    
    private func api(_ result: @escaping (Bool) -> ()) {
        guard let request = self.request else{
            return
        }
        
        guard let preRequest = self.preRequest else {
            
            request.responseJSON { response in
                var status = false
                // 登录模块
                if let dict = response.value as? Dictionary<String, Any> {
                    if let code = dict["code"] as? Int {
                        status = (code == 200)
                    }
                    self.message = dict["msg"] as! String
                    if let authorization = dict["data"] as? String {
                        Authorization = authorization
                    }
                }
                
                DispatchQueue.main.async {
                    if status {
                        result(true)
                    }
                    else {
                        result(false)
                    }
                }
            }
            return
        }
        
        preRequest.responseJSON { response in
            var status = false
            if let dict = response.value as? Dictionary<String, Any> {
                if let code = dict["code"] as? Int {
                    status = (code == 200)
                }
                if dict.keys.contains("msg") {
                    self.message = dict["msg"] as! String
                } else {
                    self.message = "操作失败！"
                }
            }

            if status {
                request.responseJSON { response in
                    var status = false
                    
                    if let dict = response.value as? Dictionary<String, Any> {
                        if let code = dict["code"] as? Int {
                            status = (code == 200)
                        }
                        self.message = dict["msg"] as! String
                    }
                    DispatchQueue.main.async {
                        if status {
                            result(true)
                        }
                        else {
                            result(false)
                        }
                    }
                }
            } else {
                result(false)
            }
        }
    }
    
    var body: some View {
        Button(title) {
            self.isShowing.toggle()
            let result = self.vertifyBlock()
            if result.0 {
                self.api {
                    self.isShowing.toggle()
                    if $0 {
                        self.success.toggle()
                        self.message = self.successMsg
                        self.passBlock()
                    }else {
                        self.error.toggle()
                    }
                    if self.showSuccess || self.error { self.showMes.toggle()
                        self.error = false
                        self.success = false
                    }
                }
            }else {
                self.isShowing.toggle()
                self.message = result.1 ?? "发生未知错误！"
                self.showMes.toggle()
            }
        }.alert(isPresented: self.$showMes, content: {
            Alert(title: Text(message))
        })
            .frame(width: 300, height: 42)
            .background(Color("lightBlueColor"))
            .foregroundColor(.white)
            .cornerRadius(4)
    }
}
