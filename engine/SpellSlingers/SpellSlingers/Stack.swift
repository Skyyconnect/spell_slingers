//
//  Stack.swift
//  SpellSlingers
//
//  Created by Skyyler Siejko on 11/9/20.
//  Copyright © 2020 Skyyler Siejko. All rights reserved.
//

import Foundation
import Foundation

import SwiftUI

//Card : ID, name, power, owner
struct Stack: View{

    @Binding var stack:Array<Card>
    @Binding var items: Array<Card>
    @Binding var blue_points: Int
    @Binding var red_points: Int
    


    func update(){
        for i in 0...self.items.count{
            if(self.items[i].isCasted && self.items.contains(self.items[i])){
                self.stack.insert(self.items[i], at: 0 )
                self.items.remove(at:i)
            }
        }
    }
    
    func resolve(){
        while self.stack.count > 0{
            let card = self.stack.removeFirst()
            if (card.owner == "_blue" && card.name != "resource" ){
                switch card.name{
                    case "spell":
                            red_points -= card.power
                    case "cancel":
                        self.stack.removeFirst()
                    default:
                        break
                    
                }
            
            } else if (card.owner == "_red" && card.name != "resource")  { // we could use else, but i use for exit case
                switch card.name{
                   case "spell":
                           blue_points -= card.power
                   case "cancel":
                       self.stack.removeFirst()
                   default:
                       break
                }
                
            }else{
                print("No cards were resolved. Something went wrong...")
                break
            }
            
        } //end loop
    }
    
    
    
    
    var body: some View {
        Group{
            if(self.stack.count > 0){
                ZStack{
                    ForEach(self.stack, id: \.self) { card in
                       Card(_id: card._id, name: card.name,power:card.power, owner:card.owner )
                    }
                }
            }
        }
    }

}
