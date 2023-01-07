//
//  Upgrade.swift
//  TeethBrusher
//
//  Created by Kirk Lennon on 12/19/22.
//

import SwiftUI

class Upgrade: Identifiable {
    
    let id: String
    let multiplier: Double
    var cost: Double
    
    init(id: String, multiplier: Double, cost: Double) {
        self.id = id
        self.multiplier = multiplier
        self.cost = cost
    }
}
