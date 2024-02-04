//
//  CategoryViewModel.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

enum CategoryProductLoadingState {
    case loading
    case success(products: [Product])
    case error(error: Error)
}

class CategoryViewModel: ObservableObject {
    @Published var state: CategoryProductLoadingState = .loading
    @Published var infoSheetShowing = false
    
    func getProducts(category: String) async {
        do {
            let products = try await ProductService.getProductsByCategory(category: category)
            state = .success(products: products)
            
        } catch {
            print("Error: \(error)")
            self.state = .error(error: error)
        }
    }
}
