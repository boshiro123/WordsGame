//
//  GameViewModel.swift
//  WordsGame
//
//  Created by shirokiy on 10/09/2023.
//

import Foundation

enum WordError:Error{
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
    case undefinedError
}


class GameViewModel: ObservableObject{
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    let word: String
    var isFirst = true
    
    init(player1: Player, player2: Player,  word: String) {
        self.player1 = player1
        self.player2 = player2
        self.word = word.uppercased()
    }
    
    func validate(word: String)->Bool{
        let word = word.uppercased()
        guard word != self.word else {
            print("Думаешь самый умный? Составленное слово не должно быть исходным словом")
            return false
        }
        guard !(words.contains(word)) else{
            print("Прояви фантазия, придумай новое слово!!!")
            return false
        }
        
        guard word.count>1 else{
            print("Слишком короткое слово")
            return false
        }
        
        
        return true
    }
    func validate2(word: String)throws{
        let word = word.uppercased()
        guard word != self.word else {
            print("Думаешь самый умный? Составленное слово не должно быть исходным словом")
            throw WordError.theSameWord
        }
        guard !(words.contains(word)) else{
            print("Прояви фантазия, придумай новое слово!!!")
            throw WordError.beforeWord        }
        
        guard word.count>1 else{
            print("Слишком короткое слово")
            throw WordError.littleWord
        }
        
    }
    
    func wordToChars(word: String)->[Character]{
        var chars = [Character]()
        for char in word.uppercased(){
            chars.append(char)
        }
        return chars
    }
    
    func check(word: String) throws -> Int {
        do{
            try self.validate2(word: word)
        }catch{
            throw error
        }
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var result = ""
        for char in smallWordArray{
            if bigWordArray.contains(char){
                result.append(char)
                var i = 0
                while bigWordArray[i] != char{
                    i += 1
                }
                bigWordArray.remove(at: i)
            }
            else{
                throw WordError.wrongWord
                return 0
            }
        }
        guard result == word.uppercased() else{
            print("Неизвестная ошибка")
            return 0
        }
        words.append(result)
        
        if isFirst{
            player1.add(score: result.count)
        }
        else{
            player2.add(score: result.count)
        }
        
        isFirst.toggle()
        
        return result.count
    }
}
