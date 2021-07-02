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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $content)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("새 메모", displayMode: .inline)
            .navigationBarItems(leading: DissmissButton(), trailing: SaveButton())
        }
        
    }
    
    fileprivate struct DissmissButton : View {
        var body: some View {
            Button(action: {}, label: {
                Text("취소")
            })
        }
    }
    fileprivate struct SaveButton : View {
        var body: some View {
            Button(action: {}, label: {
                Text("저장")
            })
        }
    }

    struct WrihteScene_Previews: PreviewProvider {
        static var previews: some View {
            WrihteScene()
        }
    }
}
