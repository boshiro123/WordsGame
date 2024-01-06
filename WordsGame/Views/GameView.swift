//
//  GameView.swift
//  WordsGame
//
//  Created by shirokiy on 09/09/2023.
//

import SwiftUI

struct GameView: View {
    @State private var word: String = ""
    @State var сonfirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    @State private var isListShowed = screen.height/3.39
    
    @Environment (\.dismiss) var dismiss
    
    var viewModel: GameViewModel
    
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    print("Quit")
                    сonfirmPresent=true
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal, 16)
                        .background(Color("Color1"))
                        .cornerRadius(15)
                        .padding(6)
                        .foregroundColor(Color.white)
                        .font(.custom("AvenirNext-Bold", size: 20))
                }
                //                Spacer(minLength: screen.width/10)
                Spacer()
                
            }
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(Color.white)
                .padding()
            
            
            HStack(spacing: 12){
                VStack{
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(Color.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 30))
                        .foregroundColor(Color.white)
                }.padding(20)
                    .frame(width: screen.width/2.2, height: screen.width/2.2)
                    .background(Color("Color1"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? Color.green : Color.clear, radius: 15, x: 0, y: 0)
                VStack{
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(Color.white)
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvenirNext-Bold", size: 30))
                        .foregroundColor(Color.white)
                }.padding(20)
                    .frame(width: screen.width/2.2, height: screen.width/2.2)
                    .background(Color("Color2"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? Color.clear : Color.blue , radius: 15, x: 0, y: 0)
                
            }
            WordsTextField(placeholder: "Ваше слово...", word: $word)
                .padding()
                .foregroundColor(.black)
            
            Button {
                var score = 0
                do{
                    try score = viewModel.check(word: word)
                }catch WordError.beforeWord{
                    alertText = "Прояви фантазия, придумай новое слово!!!"
                    isAlertPresent.toggle()
                }catch WordError.littleWord{
                    alertText = "Слишком короткое слово"
                    isAlertPresent.toggle()
                }catch WordError.theSameWord{
                    alertText = "Думаешь самый умный? Составленное слово не должно быть исходным словом"
                    isAlertPresent.toggle()
                }catch WordError.wrongWord{
                    alertText = "Такое слово не может быть составленно"
                    isAlertPresent.toggle()
                }catch{
                    alertText = "Прояви фантазия, придумай новое слово!!!"
                    isAlertPresent.toggle()
                }
                
                if score > 1{
                    self.word=""
                }
                
                isListShowed = 0
                
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .cornerRadius(26)
                    .padding(.horizontal)
            }
            
            List{
                ForEach(0..<self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .foregroundColor(Color.white)
                        .listRowInsets(EdgeInsets())
                        .background(item % 2 == 0 ? Color("Color1") : Color("Color2") )
                    
                }
            }.listStyle(.plain)
                .listStyle(.grouped)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer(minLength: isListShowed)
            
            
            
            
        }.background(Image("background2"))
            .confirmationDialog("Вы уверены, что хотите завершить игру?", isPresented: $сonfirmPresent, titleVisibility: .visible) {
                Button(role: .destructive) {//Красная снопка
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                Button(role: .cancel) { } label: {
                    Text("Нет")
                }
                
            }
            .alert(alertText, isPresented: $isAlertPresent) {
                Text("Ок, понял...")
            }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Вася"), player2: Player(name: "Петя"), word: "Рекогносцировка"))
    }
}
