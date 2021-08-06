//
//  MemoCell.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/02.
//

import SwiftUI
import CoreData

struct MemoCell: View {
    @ObservedObject var memo : MemoEnity
    @EnvironmentObject var fommater : DateFormatter
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: nil, content: {
            Text(memo.contant ?? "")
                .font(.body)
                .lineLimit(1)
            Text("\(memo.insertDate ?? Date(), formatter: self.fommater)")
                .font(.caption)
                .foregroundColor(.gray)
        })
    }
}
