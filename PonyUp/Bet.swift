//
//  Bet.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/2/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

//// should this be in its own file or nested type?
enum BetType {
    case win
    case place
    case show
    case exacta
    case trifecta
    case superfecta
//// should boxes be types? For example: exactaBox...
} // end enum BetType



class Bet {
    
    typealias HorsePicks = [String: Set<Horse>]
    
    unowned let bettor: Bettor
    unowned let race: Race
    let wagerAmount: Double
    let betType: BetType
    let horsePicks: HorsePicks
    let timeStamp: Date
    
    init(bettor: Bettor, race: Race, wagerAmount: Double, betType: BetType, horsePicks: HorsePicks) {
        self.bettor = bettor
        self.race = race
        self.wagerAmount = wagerAmount
        self.betType = betType
        self.horsePicks = horsePicks
        self.timeStamp = Date()
    } // end init
    
} // end class Bet
