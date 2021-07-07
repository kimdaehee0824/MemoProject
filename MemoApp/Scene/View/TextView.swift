//
//  TextView.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/05.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text : String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context : Context) -> UITextView {
        let MyTextView = UITextView()
        MyTextView.delegate = context.coordinator
        MyTextView.font = UIFont.preferredFont(forTextStyle: .title2)
        return MyTextView
        
    }
        
    func updateUIView( _ uiView : UITextView, context : Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var paeent : TextView
        
        init(_ uiTextView : TextView) {
            self.paeent = uiTextView
        }
        func textViewDidChange(_ textView: UITextView) {
            self.paeent.text = textView.text
        }
    }
}
