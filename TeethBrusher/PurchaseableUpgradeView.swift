//
//  PurchaseableUpgradeView.swift
//  TeethBrusher
//
//  Created by Kirk Lennon on 12/19/22.
//

import SwiftUI

struct PurchaseableUpgradeView: View {
    
    @EnvironmentObject var settings: GameSettings
    
//    var settings: GameSettings
    
    let upgrade: Upgrade
 
    var body: some View {

        Button("Enable \(upgrade.id)") {
            settings.score = settings.score - upgrade.cost
            print(upgrade.cost)
            settings.purchasedUpgrades.append(upgrade)
            if let index = settings.unpurchasedUpgrades.firstIndex(where: {$0.id == upgrade.id}) {
                settings.unpurchasedUpgrades.remove(at: index)
            }
        }
        .disabled(upgrade.cost > settings.score)

    }
}

// need to create a static example so the preview can work again

//struct PurchaseableUpgradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchaseableUpgradeView().environmentObject(GameSettings)
//    }
//}
