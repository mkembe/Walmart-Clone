//
//  ProductService.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

struct ProductService {
    private static let session = URLSession.shared
    private static let decoder = JSONDecoder()
    
    private static let url = "https://dummyjson.com/products"
    
    public static func findProducts(searchTerm: String) async throws -> [Product] {
        var components = URLComponents(string: "\(url)/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\(searchTerm)")
        ]
        
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await session.data(for: request)
        
        let decoded = try decoder.decode(ProductResponse.self, from: data)
        
        return decoded.products
    }
    
    public static func getCategories() async throws -> [String] {
        let components = URLComponents(string: "\(url)/categories")
        
        guard let url = components?.url else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await session.data(for: request)
        
        print(data)
        
        let decoded = try decoder.decode([String].self, from: data)
        
        return decoded
    }
    
    public static func getProductsByCategory(category: String) async throws -> [Product] {
        let components = URLComponents(string: "\(url)/category/\(category)")

        guard let url = components?.url else { fatalError("Invalid URL") }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await session.data(for: request)
        
        print(data)
        
        let decoded = try decoder.decode(ProductResponse.self, from: data)
        
        return decoded.products
    }
}
