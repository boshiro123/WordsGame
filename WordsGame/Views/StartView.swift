//
//  ContentView.swift
//  WordsGame
//
//  Created by shirokiy on 08/09/2023.
//

import SwiftUI

struct StartView: View {
    
    @State private var bigWord: String = ""
    @State private var player1: String = ""
    @State private var player2: String = ""
    @State private var isAlertPresented = false
    
    @State var isShowedGame = false

    
    var body: some View {
        VStack{
        
            TitleText(text: "Words game")
            
            WordsTextField(placeholder: "Введите большое слово", word: $bigWord)
                .cornerRadius(20)
                .padding(20)
                .padding(.top, 32)

            
            WordsTextField(placeholder: "Игрок 1", word: $player1)
                .foregroundColor(.black)
                .cornerRadius(20)
                .padding(.horizontal,20)
                .padding(.vertical,10)

            WordsTextField(placeholder: "Игрок 2", word: $player2)
                .foregroundColor(.black)
                .cornerRadius(20)
                .padding(.horizontal, 20)
            
            Button {
            print("Start button Tapped")
                
                if bigWord.count > 7{
                    isShowedGame.toggle()
                }
                else{
                    isAlertPresented.toggle()
                }
                
            } label: {
                Text("Старт!")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 40)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(50)
                    .padding(.top)

            }

            
        }.background(Image("background2"))
            .alert("Длинное слово слишком короткое!", isPresented: $isAlertPresented, actions: {
                Text("ОК!")
            })
            .fullScreenCover(isPresented: $isShowedGame) {
                
                let name1 = player1 == "" ? "Игрок 1" : player1
                let name2 = player2 == "" ? "Игрок 2" : player2
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                
                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)

                GameView(viewModel: gameViewModel)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
