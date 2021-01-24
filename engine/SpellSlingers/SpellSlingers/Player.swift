//
//  File.swift
//  SpellSlingers
//
//  Created by Shreyas Ramanujam on 1/24/21.
//  Copyright © 2021 Skyyler Siejko. All rights reserved.
//

import Foundation
import SwiftUI

struct Player {
    @State var hand: Pile = Pile()
    @Binding var deck: Pile
    @State var queue: Pile = Pile()
    @State var willPower: Int = 25
    @State var isActive: Bool = false
    var card_name = ["cancel", "resolve", "resource", "recycle","spell"]
    var card_amount = [4,4,4,4,4]
    var card_power = [10,30,20,4,4]
    
    init(deck: Binding<Pile>) {
        _deck = deck
    }
    func drawFromDeck() {
        let draw_card = self.deck.pop()
        if(draw_card != nil) {
            self.hand.push(draw_card!)
        }
    }
    
    func createDeck(){
//        var tempPile = Pile()
        for cardIndex in 0..<card_name.count {
            for i in 0..<card_amount.count {
                for _ in 0...card_amount[i] {
                    self.deck.push(Card(name: card_name[cardIndex], power: card_power[cardIndex], owner: "_blue" ))
                }
            }
        }
//        self.deck.push(Card(name: "cancel",power:10,owner:"_blue"))
        print(self.deck.items.count)
//        self.deck = tempPile
//        print(self.deck.items.count)
//        return(tempPile)
    }
    
//    func setDeck() {
//        self.deck.items = self.createDeck()
//        print(self.deck.items.count)
//    }
    
//    func doSomething(then: { [weak card] in
//        guard let strongSelf = self { else return }
//        strongSelf.createDeck()
//    )
    
    mutating func shuffleDeck() {
        var newDeck:Pile = Pile()
        while(self.deck.items.count > 0){
            let i = Int.random(in: 0..<self.deck.items.count)
            let card = self.deck.items[i]
            newDeck.push(card)
            self.deck.remove(index: i )
        }
        
        self.deck = newDeck
//        print(self.deck.items.count)
    }
    // Draw from Deck
    // Shuffle Deck 
}

