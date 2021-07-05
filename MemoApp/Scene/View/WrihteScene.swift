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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $content)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("새 메모", displayMode: .inline)
            .navigationBarItems(leading: DissmissButton(show: $composer, content: $content ), trailing: SaveButton(show: $composer))
        }
        
    }
    
    fileprivate struct DissmissButton : View {
        @Binding var show : Bool
        @EnvironmentObject var store : MemoStore
        @Binding var content : String
        var body: some View {
            Button(action: {
                self.store.insert(memo: self.content)
                self.show = false
            }, label: {
                Text("취소")
            })
        }
    }
    fileprivate struct SaveButton : View {
        @Binding var show : Bool
        var body: some View {
            Button(action: {
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
