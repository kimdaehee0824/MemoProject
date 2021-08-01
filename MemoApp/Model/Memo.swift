//
//  Memo.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import SwiftUI
import CoreData



class Memo: Identifiable, ObservableObject {
    
    let id : UUID
    @Published var content : String
    let inserteDate : Date
    
    init(id : UUID = UUID(),  content : String, inserteDate : Date = Date())
    {
        self.id = id
        self.content = content
        self.inserteDate = inserteDate
    }
    
    
}


extension Memo: Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
    
}

