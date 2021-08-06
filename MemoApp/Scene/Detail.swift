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
    
    @ObservedObject var memo : MemoEnity
    
    @EnvironmentObject var store : CoreDataManager
    @EnvironmentObject var fommater : DateFormatter
    
    @State var showComposer : Bool = false
    @State private var showSheet = false
    @State private var alent = false
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(self.memo.contant ?? "")
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
                    Text("\(self.memo.insertDate ?? Date(), formatter: fommater)")
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
            Alert(title: Text("Confirm Delete"), message: Text("Are you sure you want to delete it?"),
                  primaryButton:  .cancel(Text("cancel"))
                  , secondaryButton: .destructive(Text("delete"), action: {
                    self.store.delete(memo: self.memo)
                    self.presentationMode.wrappedValue.dismiss()
                  })
            )
        })
        
        .navigationBarTitle( "Memo Content", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(UIColor.systemOrange))
            }), trailing:
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
        Detail(memo: MemoEnity(context:CoreDataManager.mainContext))
            .environmentObject(CoreDataManager.shared)
            .environmentObject(DateFormatter.memoDateFormetter)
    }
}
