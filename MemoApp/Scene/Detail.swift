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
    
    @State var showComposer : Bool = false
    @State private var showSheet = false
    
    
    
    var body: some View {
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
                
            }
        }
        .navigationBarTitle( "메모 내용", displayMode: .inline)

        .navigationBarItems(trailing:
                                HStack {
            disButton(memo: memo)
            fixButton(memo: memo)
        })
        
    }
}

fileprivate struct fixButton : View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    @State private var showSheet = false
    var body: some View {
        Button(action: {
            self.showSheet.toggle()
        }, label: {
            Image(systemName: "square.and.pencil")
        })
//            .padding()
            .fullScreenCover(isPresented: $showSheet, content: {
                WrihteScene(composer: self.$showSheet, memo : self.memo)
                    .environmentObject(self.store)
            })
    }
}
fileprivate struct disButton : View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    
    @State private var showSheet = false
    @State private var alent = false
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            
            self.alent.toggle()
        }, label: {
            Image(systemName: "trash")
                .foregroundColor(Color(UIColor.systemRed))
        })
//            .padding()
            .alert(isPresented: $alent, content: {
                Alert(title: Text("삭제 확인"), message: Text("삭제하시겠습니까?"),
                      primaryButton: .destructive(Text("삭제"), action: {
                    self.store.delete(memo: self.memo)
                    self.presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .cancel())
            })
    }
}

struct Detail_Previews: PreviewProvider { 
    static var previews: some View {
        Detail(memo: Memo(content: "Swift"))
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}
