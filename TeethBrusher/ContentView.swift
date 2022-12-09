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
    
    func manuallyBrush() {
        score += 1
    }
    
    func calculateScore() {
        score += hygienists.scorePerTock
        score += dentists.scorePerTock
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
    
    let hygienists = Worker(title: "Dental Hygienist", brushRate: 10, cost: 100.0, numberOfWorkers: 0)
    let dentists = Worker(title: "Dentist", brushRate: 100, cost: 1000.0, numberOfWorkers: 0)
    
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
            
            
            VStack {
                Text("Buy Upgrades:")
                HStack {
                    Text("Upgrade 1")
                    
                    Text("Upgrade 2")
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
