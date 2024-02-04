//
//  ProductSearchViewModel.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

class ProductSearchViewModel: Observable {
    func calculateCurrentPrice(originalPrice: Double, discountPercentage: Double) -> Double {
        guard originalPrice >= 0 && discountPercentage >= 0 && discountPercentage <= 100 else {
            return -1
        }

        let discountMultiplier = 1 - (discountPercentage / 100)
        let currentPrice = originalPrice * discountMultiplier

        return currentPrice
    }
}
