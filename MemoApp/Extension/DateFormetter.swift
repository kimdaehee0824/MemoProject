//
//  DateFormetter.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import Foundation

extension DateFormatter {
    static let memoDateFormetter : DateFormatter = {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "Ko_kr")
        return dateFormatter
    }()
}

extension DateFormatter : ObservableObject {
    
}
