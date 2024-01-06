//
//  WordsTextField.swift
//  WordsGame
//
//  Created by shirokiy on 09/09/2023.
//

import SwiftUI

struct WordsTextField: View {
    var placeholder: String
    @State var word: Binding<String>
    var body: some View {
        TextField("", text: word, prompt: Text(placeholder).foregroundColor(.gray))
            .foregroundColor(.black)
            .font(.title2)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
    }
    
    struct WordsTextField_Previews: PreviewProvider {
        static var previews: some View {
            WordsTextField(placeholder: "всё",word: Binding.constant("Введите что-нибудь"))
        }
    }
}
