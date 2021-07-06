//
//  Detail.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/06.
//

import SwiftUI

struct Detail: View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    @EnvironmentObject var fommater : DateFormatter
    
    @State private var showSheet = false
    
    var body: some View {
        
        NavigationView {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(self.memo.content)
                            .padding()
                        Spacer()
                    }
                    Text("\(self.memo.inserteDate, formatter: fommater)")
                        .padding()
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                
                HStack {
                    Button (action: {
                        self.showSheet.toggle()
                    }, label: {
                        Image(systemName: "square.and.pencil")
                    })
                    .padding()
                    .fullScreenCover(isPresented: $showSheet, content: {
                        WrihteScene(composer: self.$showSheet, memo : self.memo)
                            .environmentObject(self.store)
                    })
                }
            }
        }
        .navigationBarTitle( "메모 내용", displayMode: .inline)
        }
    }
}

struct Detail_Previews: PreviewProvider { 
    static var previews: some View {
        Detail(memo: Memo(content: "Swift"))
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}
