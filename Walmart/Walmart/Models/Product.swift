//
//  Product.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    
    let thumbnail: String
    let images: [String]
}
