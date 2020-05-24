//
//  TextView.swift
//  Note
//
//  Created by 峰 on 2020/5/20.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI


struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    var onEditBlock: () -> () = { }
    @Binding var text: String
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView(frame: .zero)
        view.text = text
        view.font = UIFont.systemFont(ofSize: 17)
        view.textContainer.lineFragmentPadding = 0
        view.textContainerInset = .zero
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.onEditBlock()
        }

    }
}
