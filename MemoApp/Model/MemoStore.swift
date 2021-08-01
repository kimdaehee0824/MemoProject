//
//  MemoStore.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import SwiftUI
import Foundation
import CoreData




class MemoStore : ObservableObject {
    @Published var list : [Memo]
    init() {
        list = [
            Memo(content: "Hello Daehee"),
            Memo(content: "Hello Daehee2"),
            Memo(content: "Hello Daehee3")
        ]
    }
    func insert(memo : String) {
        list.insert(Memo(content: memo), at: 0)
    }
    func upDate(memo : Memo?, content : String) {
        guard let memo = memo else {
            return
        }
        memo.content = content
    }
    func delete(memo : Memo) {
        self.list.removeAll {
            $0 == memo
        }
    }
    func delete(set : IndexSet) {
        for index in set {
            self.list.remove(at: index)
        }
    }
}
