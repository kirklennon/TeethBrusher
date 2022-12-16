//
//  ContentView.swift
//  TeethBrusher
//
//  Created by Kirk Lennon on 12/3/22.
//

import SwiftUI

struct ContentView: View {
    @State var score: Double = 0.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func calculateUpgradeMultiplier() -> Double {
        var totalMultiplier: Double = 1.0
        for upgrade in enabledUpgrades {
            totalMultiplier = totalMultiplier * upgrade.multiplier
        }
        return totalMultiplier
    }
    
    func manuallyBrush() {
        score += 1 * calculateUpgradeMultiplier()
    }
    
    func calculateScore() {
        if enabledUpgrades.isEmpty {
            score += hygienists.scorePerTock
            score += dentists.scorePerTock
        } else {
            for upgrade in enabledUpgrades {
                score += hygienists.scorePerTock * upgrade.multiplier
                score += dentists.scorePerTock * upgrade.multiplier
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
    
    let hygienists = Worker(title: "Dental Hygienist", brushRate: 1, cost: 100.0, numberOfWorkers: 0)
    let dentists = Worker(title: "Dentist", brushRate: 10, cost: 1000.0, numberOfWorkers: 0)
    
    
    class Upgrade {
        let name: String
        let multiplier: Double
        var cost: Double
        
        init(name: String, multiplier: Double, cost: Double) {
            self.name = name
            self.multiplier = multiplier
            self.cost = cost
        }
    }
    
    let fluoride = Upgrade(name: "Fluoride", multiplier: 1.25, cost: 100)
    let electricToothbrushes = Upgrade(name: "Electric Toothbrushes", multiplier: 1.5, cost: 500)
    
    @State var enabledUpgrades: [Upgrade] = []
    
    var body: some View {
        VStack {
            VStack {
                Text("Teeth brushed:")
                Text("\(Int(score))")
                    .onReceive(timer) { _ in
                        calculateScore()
                }
                    .font(.largeTitle)
            }
            .padding(.vertical, 50.0)
            
            VStack {
                Text("Workers:")
                HStack {
                    Button("Hire Dental Hygienist") {
                        score = score - hygienists.cost
                        hygienists.numberOfWorkers += 1
                    }
                    .disabled(hygienists.cost > score)
                    
                    Button("Hire Dentist") {
                        score = score - dentists.cost
                        dentists.numberOfWorkers += 1
                    }
                    .disabled(dentists.cost > score)
                }
            }
            .padding(.vertical)
            
            
            // Upgrades needs functionality to disable buying the same one twice
            VStack {
                Text("Buy Upgrades:")
                HStack {
                    Button("Enable Fluoride") {
                        score = score - fluoride.cost
                        enabledUpgrades.append(fluoride)
                    }
                    .disabled(fluoride.cost > score)
                    Button("Enable Electric Toothbrushes") {
                        score = score - electricToothbrushes.cost
                        enabledUpgrades.append(electricToothbrushes)
                    }
                    .disabled(electricToothbrushes.cost > score)
                }
            }
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
