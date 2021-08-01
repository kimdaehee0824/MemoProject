//
//  ContentView.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import SwiftUI
import CoreData


struct MemoListScene: View {
    @EnvironmentObject var store : MemoStore
    @EnvironmentObject var fommater : DateFormatter
    @State var showComposer : Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (store.list) { memo in
                    NavigationLink(
                        destination: Detail(memo: memo),
                        label: {
                            MemoCell(memo: memo)
                        })
                }
                .onDelete(perform: store.delete)
                
            }
            .navigationTitle("나의 메모")
            .navigationBarItems(trailing: Modal(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                WrihteScene(composer: self.$showComposer)
                    .environmentObject( self.store)
        })
        }
    }
}
fileprivate struct Modal : View {
    @Binding var show : Bool
    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(Color(UIColor.systemOrange))
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
