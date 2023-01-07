//
//  ContentView.swift
//  TeethBrusher
//
//  Created by Kirk Lennon on 12/3/22.
//

import SwiftUI

struct ContentView: View {

    // for some reason I have to declare the upgrades here and in the init for GameSettings, but only the GameSettings init one actually does anything. Still trying to figured out.
    @StateObject var settings = GameSettings(score: 0.0, unpurchasedUpgrades: [Upgrade(id: "Fluoride", multiplier: 1.25, cost: 10), Upgrade(id: "Electric Toothbrushes", multiplier: 1.5, cost: 50)])
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func calculateUpgradeMultiplier() -> Double {
        var totalMultiplier: Double = 1.0
        for upgrade in settings.purchasedUpgrades {
            totalMultiplier = totalMultiplier * upgrade.multiplier
        }
        return totalMultiplier
    }
    
    func manuallyBrush() {
        settings.score += 1 * calculateUpgradeMultiplier()
    }
    
    func calculateScore() {
        if settings.purchasedUpgrades.isEmpty {
            settings.score += hygienists.scorePerTock
            settings.score += dentists.scorePerTock
        } else {
            for upgrade in settings.purchasedUpgrades {
                settings.score += hygienists.scorePerTock * upgrade.multiplier
                settings.score += dentists.scorePerTock * upgrade.multiplier
            }
        }
    }
    
    class Worker {
        let title: String
        var brushRate: Int
        var multiplier: Double
        var cost: Double
        var numberOfWorkers: Int
        var scorePerTock: Double {
            Double(brushRate) * multiplier * Double(numberOfWorkers)
        }
        
        init(title: String, brushRate: Int = 0, multiplier: Double = 1.0, cost: Double = 0.0, numberOfWorkers: Int = 0) {
            self.title = title
            self.brushRate = brushRate
            self.multiplier = multiplier
            self.cost = cost
            self.numberOfWorkers = numberOfWorkers
        }
    }
    
    // need to create workers like upgrades
    let hygienists = Worker(title: "Dental Hygienist", brushRate: 1, cost: 100.0, numberOfWorkers: 0)
    let dentists = Worker(title: "Dentist", brushRate: 10, cost: 1000.0, numberOfWorkers: 0)
    
    
    var body: some View {

        VStack {
            VStack {
                Text("Teeth brushed:")
                Text("\(Int(settings.score))")
                    .onReceive(timer) { _ in
                        calculateScore()
                }
                    .font(.largeTitle)
            }
            .padding(.vertical, 50.0)
            
            
            // need to replace this manual system with an array and views similar to upgrades, except they stay in one array
            VStack {
                Text("Workers:")
                HStack {
                    Button("Hire Dental Hygienist") {
                        settings.score = settings.score - hygienists.cost
                        hygienists.numberOfWorkers += 1
                    }
                    .disabled(hygienists.cost > settings.score)
                    
                    Button("Hire Dentist") {
                        settings.score = settings.score - dentists.cost
                        dentists.numberOfWorkers += 1
                    }
                    .disabled(dentists.cost > settings.score)
                }
            }
            .padding(.vertical)
            
           
    
            VStack {
                Text("Buy Upgrades:")
                HStack {
                    ForEach(settings.unpurchasedUpgrades) { upgrade in
                        PurchaseableUpgradeView(upgrade: upgrade)
                    }
                }
                
                Text("Purchased Upgrades:")
                HStack {
                    ForEach(settings.purchasedUpgrades) { upgrade in
                        Text(upgrade.id)
                    }
                }
            }
            .environmentObject(settings)
            .padding(.vertical)
            
            
            Spacer()
            
            
            Button("Brush!", action: manuallyBrush)
                .padding(.bottom, 100.0)
                .font(.title)
                .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
