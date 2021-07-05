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
    @State var showComposer : Bool = false
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                MemoCell(memo: memo)
            }
            .navigationTitle("나의 메모")
            .navigationBarItems(trailing: Modal(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                WrihteScene(composer: self.$showComposer)
                    .environmentObject( self.store)
            })
        }
        .padding()
    }
}
fileprivate struct Modal : View {
    @Binding var show : Bool
    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Image(systemName: "plus")
        })
    }
    
}
struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}

