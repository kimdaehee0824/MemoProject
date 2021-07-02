//
//  MemoCell.swift
//  MemoApp
//
//  Created by 김대희 on 2021/07/02.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var fommater : DateFormatter
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: nil, content: {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)
            Text("\(memo.inserteDate, formatter: self.fommater)")
                .font(.caption)
                .foregroundColor(.gray)
        })
    }
}
