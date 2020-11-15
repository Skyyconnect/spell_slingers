//
//  Game.swift
//  SpellSlingers
//
//  Created by Shreyas Ramanujam on 11/8/20.
//  Copyright © 2020 Skyyler Siejko. All rights reserved.
//

import Foundation
import SwiftUI
import QuartzCore
    
struct Game: View{
    @State var stack:Array<Card> = []
    @State var discard:Array<Card> = []
  
    
    @State var player_IsActive = false
    @State var opponent_IsActive = false
    @State var GameState:Int = 2
     var player: Player! = nil
    var opponent: Opponent! = nil
  
    
    init(){
        player = Player(isActive: $player_IsActive)
        opponent = Opponent(isActive:$opponent_IsActive)
    }
  
    
    func start() {
      
        self.GameState = 2
        GameLoop(doSomething: self.gameLoop)
        print("started Loop")
       
    }
    
    
    func gameLoop(){
        self.update()
    }
    
    func switchPriority(){
        if(self.opponent_IsActive){
            self.opponent_IsActive = false
            self.player_IsActive = true
        }else if(self.player_IsActive){
            self.player_IsActive = false
            self.opponent_IsActive = true
        }else{
            self.player_IsActive = false
            self.opponent_IsActive = false
        }
        self.GameState += 1
    }
    
    func update(){
        switch self.GameState{
            case 0: // start
                self.start()
            case 1:// switch priority
                self.switchPriority()
            case 2: // update stack
                if(self.opponent_IsActive) {
                    Stack(stack: $stack,
                          items:opponent.$hand,
                          blue_points: player.$points,
                          red_points: opponent.$points).update()
                } else {
                    Stack(stack: $stack,
                          items: player.$hand,
                          blue_points: player.$points,
                          red_points:opponent.$points).update()
                }
                self.GameState += 1
            case 3: //resolve stack 
                Stack(stack: $stack,
                      items: player.$hand,
                      blue_points: player.$points,
                      red_points: opponent.$points).resolve()
            default:
                self.start()
            
                
        }
    }
    
   var body: some View {
        VStack {
            opponent
            HStack {
            Stack(stack: $stack,
                  items: player.$hand,
                  blue_points:player.$points,
                  red_points: opponent.$points)
            Discard(discard: $discard, items: $stack)
            }
            player
           
            
    }
       
    }
}
