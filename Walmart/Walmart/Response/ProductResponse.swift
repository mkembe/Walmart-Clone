//
//  ProductResponse.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
