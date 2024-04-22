//
//  CheckoutViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import Foundation
import SwiftUI

class CheckoutViewModel: ObservableObject {
    @Published var originalItems = [
        ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso"], ["Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"], ["can’t", "do", "is", "ignore", "them", "because", "they", "change", "things", "they pp", "push"], ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso"], ["the", "ones", "who", "are", "crazy", "enough"]
    ]
    @Published var category = ["套餐", "主食", "副餐", "飲料", "甜點"]
    
    @Published var spacing: CGFloat = 8
    @Published var padding: CGFloat = 8
    @Published var wordCount: Int = 75
    @Published var alignmentIndex = 0
    
    
    let alignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    
    var alignment: HorizontalAlignment {
        alignments[alignmentIndex]
    }
    
    
}
