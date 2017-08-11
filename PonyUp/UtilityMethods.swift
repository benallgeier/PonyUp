//
//  UtilityMethods.swift
//  PonyUp
//
//  Created by Ben Allgeier on 4/24/17.
//  Copyright © 2017 ballgeier. All rights reserved.
//

import Foundation

func indexToKeepSorted<T: Comparable>(array xs: [T], for x: T) -> Int {
    var (low, high) = (0, xs.count)
    if xs.isEmpty { return 0 }
    // Assuming nonempty array
    // we start with low < high
    // In each case, we have low <= mid <= high
    // furthermore, only way low = mid or mid = high is if low = high - 1
    // in that case, it will be last time through loop
    // so we will always have low < mid < high in other cases
    // so if low is set to mid or high set to mid, we will preserve low < high
    // so low < high always
    // we just stop when low gets as big as it can (high - 1) or if x == xs[mid] before that
    while low < high - 1 {
        switch (low + high) / 2 {
        case let mid where x < xs[mid]: high = mid
        case let mid where x > xs[mid]: low = mid
        // so this returns the index that would put new element in front of "equal" element
        case let mid: return mid
        } // end switch
    } // end while
    // if we are here, then low = high - 1
    if x <= xs[low] { return low }
    else { return high }
} // end indexToKeep(array:for:)
