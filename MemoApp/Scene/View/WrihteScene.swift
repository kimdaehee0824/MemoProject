//
//  WrihteScene.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/02.
//

import SwiftUI

struct WrihteScene: View {
    @EnvironmentObject var store : MemoStore
    @State private var content : String = ""
    @Binding var composer : Bool
    
    var memo: Memo? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $content)
                    .frame( maxWidth: .infinity, maxHeight: .infinity)
                                }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode: .inline)
            .navigationBarItems(leading: DissmissButton(show: $composer), trailing: SaveButton(show: $composer, content: $content, memo: memo))
        }
        .onAppear {
            self.content = self.memo?.content ?? ""
        }
    }
    
    fileprivate struct DissmissButton : View {
        @Binding var show : Bool

        var body: some View {
            Button(action: {
                self.show = false
            }, label: {
                Text("취소")
            })
        }
    }
    fileprivate struct SaveButton : View {
        @Binding var show : Bool
        @EnvironmentObject var store : MemoStore
        @Binding var content : String
        var memo: Memo? = nil
        var body: some View {
            Button(action: {
                if let memo = self.memo {
                    self.store.upDate(memo: memo, content: self.content)
                } else {
                    self.store.insert(memo: self.content)
                }
                self.show = false
            }, label: {
                Text("저장")
            })
        }
    }
    
    struct WrihteScene_Previews: PreviewProvider {
        static var previews: some View {
            WrihteScene(composer: .constant(false))
                .environmentObject(MemoStore())
        }
    }
}
