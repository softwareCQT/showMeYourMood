//
//  Switch.swift
//  Note
//
//  Created by 峰 on 2020/5/28.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI


struct Switch: UIViewRepresentable {
    typealias UIViewType = FFSwitch
    let view = FFSwitch()
    @Binding var isOn: Bool
    
    func updateUIView(_ uiView: FFSwitch, context: Context) {
    }
    
    
    func makeUIView(context: Context) -> FFSwitch {
        
        view.isOn = isOn
        view.delegate = context.coordinator
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FFSwitchDelegate {
        var parent: Switch
        
        init(_ parent: Switch) {
            self.parent = parent
        }
        func switchStateDidChange() {
            parent.isOn.toggle()
        }
    }
    
}
protocol FFSwitchDelegate: NSObject {
    func switchStateDidChange()
}

class FFSwitch: UISwitch {
    weak var delegate: FFSwitchDelegate?
    init() {
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(stateDidChange), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func stateDidChange()  {
        delegate?.switchStateDidChange()
    }
    
}
