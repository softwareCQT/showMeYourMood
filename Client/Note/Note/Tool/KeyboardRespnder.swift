//
//  KeyboardRespnder.swift
//  Note
//
//  Created by 峰 on 2020/5/11.
//  Copyright © 2020 峰. All rights reserved.
//
import Combine
import SwiftUI

final class KeyboardResponder: ObservableObject {
    let id = UUID()
    
    let didChange = PassthroughSubject<CGFloat, Never>()

    private var _center: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0 {
        didSet {
            didChange.send(currentHeight)
        }
    }

    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        _center.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
