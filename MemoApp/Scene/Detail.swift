//
//  Detail.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/06.
//

import SwiftUI
import CoreData

struct Detail: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject var memo : Memo
    
    @EnvironmentObject var store : MemoStore
    @EnvironmentObject var fommater : DateFormatter
    
    @State var showComposer : Bool = false
    @State private var showSheet = false
    @State private var alent = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(self.memo.content)
                            .font(.title2)
                            .onTapGesture {
                                self.showSheet.toggle()
                            }
                            .onLongPressGesture {
                                self.alent.toggle()
                            }

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
        .fullScreenCover(isPresented: $showSheet, content: {
            WrihteScene(composer: self.$showSheet, memo : self.memo)
                .environmentObject(self.store)
        })
        .alert(isPresented: $alent, content: {
            Alert(title: Text("삭제 확인"), message: Text("삭제하시겠습니까?"),
                  primaryButton: .destructive(Text("삭제"), action: {
                self.store.delete(memo: self.memo)
                self.presentationMode.wrappedValue.dismiss()
            }), secondaryButton: .cancel())
        })

        .navigationBarTitle( "메모 내용", displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack {
                                    Button(action: {
                                        self.alent.toggle()
                                    }, label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(Color(UIColor.systemRed))
                                    })
                                    Button(action: {
                                        self.showSheet.toggle()
                                    }, label: {
                                        Image(systemName: "square.and.pencil")
                                            .foregroundColor(Color(UIColor.systemOrange))
                                    })
                                    
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
