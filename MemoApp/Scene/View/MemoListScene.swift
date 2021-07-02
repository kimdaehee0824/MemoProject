//
//  ContentView.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import SwiftUI

struct MemoListScene: View {
    @EnvironmentObject var store : MemoStore
    @EnvironmentObject var fommater : DateFormatter
   
    var body: some View {
        NavigationView {
            List(store.list) {
                memo in
                MemoCell(memo: memo)
            }
            .navigationTitle("나의 메모")
        }
        .padding()
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}

