//
//  Horse.swift
//  PonyUp
//
//  Created by Ben Allgeier on 3/3/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation
//import UIKit // for UIColor

struct Horse {
    let polePosition: Int
//    var color: UIColor?
    
} // end struct Horse

// not sure if I need
extension Horse: Hashable {
    var hashValue: Int {
        return polePosition
    } // end hashValue
} // end extension Horse: Hashable

extension Horse: Equatable {
    static func == (lhs: Horse, rhs: Horse) -> Bool {
            return lhs.polePosition == rhs.polePosition
    } // end ==(lhs:rhs:)
} // end extension Horse: Equatable
