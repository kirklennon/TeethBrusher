//
//  GameSettings.swift
//  TeethBrusher
//
//  Created by Kirk Lennon on 12/24/22.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var score: Double = 0
    
    @Published var unpurchasedUpgrades: [Upgrade] = []
    
    @Published var purchasedUpgrades: [Upgrade] = []
    init(score: Double, unpurchasedUpgrades: [Upgrade]) {
        self.score = score
        self.unpurchasedUpgrades = [Upgrade(id: "Fluoride", multiplier: 1.25, cost: 100), Upgrade(id: "Electric Toothbrushes", multiplier: 1.5, cost: 500)]
        self.purchasedUpgrades = []
    }
}
