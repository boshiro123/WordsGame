//
//  WordSell.swift
//  WordsGame
//
//  Created by shirokiy on 11/09/2023.
//

import SwiftUI

struct WordCell: View {
    let word: String
    
    var body: some View {
        HStack{
            Text(word)
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom("AvenirNext-Bold", size: 22))
//                .foregroundColor(Color.white)
            Text("\(word.count)")
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom("AvenirNext-Bold", size: 22))
//                .foregroundColor(Color.white)
        }
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Магнит")
    }
}
