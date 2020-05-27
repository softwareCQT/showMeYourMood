//
//  TextView.swift
//  Note
//
//  Created by 峰 on 2020/5/20.
//  Copyright © 2020 峰. All rights reserved.
//

import SwiftUI

var CacheurlArray : Array<String> = []

struct TextView: UIViewRepresentable {
    typealias UIViewType = RZRichTextView
    var onEditBlock: () -> () = {}
   
    
    @Binding var text: String
    func updateUIView(_ uiView: RZRichTextView, context: Context) {
        
        
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeUIView(context: Context) -> RZRichTextView {
        let view = RZRichTextView(frame: .zero)
        view.rz_shouldInserImage = {
            image in
            if let data =  image?.pngData() {
                let imageName = image?.accessibilityIdentifier ?? "default"
                ImageStore.storeImage(data: data, imageName: imageName)
                
                CacheurlArray.append(URL(fileURLWithPath: ImageStore.imageURL(imageName: imageName)!).absoluteString)
                print(CacheurlArray)
            }
            return image
        }
    
        view.rz_didChangedText = {
            textView in
            self.text = textView.attributedText.rz_codingToHtml(withImagesURLSIfHad: CacheurlArray)
            print(CacheurlArray)
            print(self.text)
            self.onEditBlock()
        }
        DispatchQueue.global().async {
            let temp = NSAttributedString.htmlString(self.text)
            DispatchQueue.main.async {
                view.attributedText = temp
            }
        }
        //使用富文本加载
        
        return view
    }
}


struct TextView1: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView(frame: .zero)
        view.text = text
        view.font = UIFont.systemFont(ofSize: 17)
        view.delegate = context.coordinator
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView1
        
        init(_ parent: TextView1) {
            self.parent = parent
        }
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
