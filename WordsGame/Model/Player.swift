//
//  Plaeyr.swift
//  WordsGame
//
//  Created by shirokiy on 10/09/2023.
//

import Foundation

struct Player{
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int){
        self.score += score
    }
}

