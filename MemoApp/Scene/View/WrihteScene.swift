//
//  WrihteScene.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/02.
//

import SwiftUI

struct WrihteScene: View {
    @EnvironmentObject var store : CoreDataManager
    @State private var content : String = ""
    @Binding var composer : Bool
    
    var memo: MemoEnity? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $content)
                    .frame( maxWidth: .infinity, maxHeight: .infinity)
            }.padding()
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(memo != nil ? "Edit Memo" : "New Memo", displayMode: .inline)
            .font(Font.custom("FACEBOLF", size: 20))
            .navigationBarItems(leading: DissmissButton(show: $composer), trailing: SaveButton(show: $composer, content: $content, memo: memo))
        }
        .onAppear {
            self.content = self.memo?.contant ?? ""
        }
    }
    
    fileprivate struct DissmissButton : View {
        @Binding var show : Bool

        var body: some View {
            Button(action: {
                self.show = false
            }, label: {
                Text("cancel")
                    .foregroundColor(Color(UIColor.systemOrange))
            })
        }
    }
    fileprivate struct SaveButton : View {
        @Binding var show : Bool
        @EnvironmentObject var store : CoreDataManager
        @Binding var content : String
        var memo: MemoEnity? = nil
        var body: some View {
            Button(action: {
                if let memo = self.memo {
                    self.store.upDate(memo: memo, contant: self.content)
                } else {
                    self.store.AddMemo (content: self.content)
                }
                self.show = false
            }, label: {
                Text("save")
                    .foregroundColor(Color(UIColor.systemOrange))
            })
        }
    }
    
    struct WrihteScene_Previews: PreviewProvider {
        static var previews: some View {
            WrihteScene(composer: .constant(false))
                .environmentObject(CoreDataManager.shared)
        }
    }
}
