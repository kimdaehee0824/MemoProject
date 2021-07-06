//
//  KeboredSet.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/05.
//

import UIKit
import Combine

class KeboredSet: ObservableObject {
    struct Context {
        let amimation : TimeInterval
        let height : CGFloat
        static let hide = Self(amimation: 0.25, height: 0)
        
    }
    
    @Published var context = Context.hide
    private var cancel = Set<AnyCancellable>()

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willeHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        willShow.merge(with: willeHide)
            .compactMap(parse)
            .assign(to: \.context, on: self)
            .store(in: &cancel )
    }
    
    func parse(ntification : Notification) -> Context? {
        guard let userTnfo = ntification.userInfo  else { return nil }
        
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        let animationDuration = (userTnfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        
        var heaght : CGFloat = 0
        
        if let value = userTnfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            
            if frame.origin.y < UIScreen.main.bounds.height {
                heaght = frame.height - (safeAreaInsets?.bottom ?? 0)
            }
        }
        return Context(amimation: animationDuration, height: heaght)
    }
}


