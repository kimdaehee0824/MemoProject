//
//  ContentView.swift
//  MemoApp
//
//  Created by 김대희 on 2021/06/30.
//

import SwiftUI
import CoreData


struct MemoListScene: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    
    @EnvironmentObject var store : CoreDataManager
    @EnvironmentObject var fommater : DateFormatter
    
    @State var showComposer : Bool = false
    @State var filterString : String = ""
    
    
    @FetchRequest (entity: MemoEnity.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \MemoEnity.insertDate,ascending: false)])
    var memoList : FetchedResults<MemoEnity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach (memoList) { memo in
                    NavigationLink(
                        destination: Detail(memo: memo),
                        label: {
                            MemoCell(memo: memo)
                        })
                }
                .onDelete(perform: delete)
            }
            
            .add(self.searchBar)
            .navigationBarTitle("All Memo")
            .font(Font.custom("FACEBOLF", size: 40))
            .navigationBarItems(trailing: Modal(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                WrihteScene(composer: self.$showComposer)
                    .environmentObject( self.store)
            })
        }
        
    }
    func delete(set : IndexSet) {
        for index in set {
            store.delete(memo: memoList[index])
        }
    }
}

fileprivate struct Modal : View {
    @Binding var show : Bool
    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Image(systemName: "square.and.pencil")
                .foregroundColor(Color(UIColor.systemOrange))
        })
    }
    
}
struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(CoreDataManager.shared)
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}
