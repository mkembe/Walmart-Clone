//
//  SearchViewModel.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

enum CategoryLoadingState {
    case loading
    case success(categories: [String])
    case error(error: Error)
}

@Observable
class SearchViewModel {
    var state: CategoryLoadingState = .loading
    
    func getCategories() async {
        do {
            let categories = try await ProductService.getCategories()
            state = .success(categories: categories)
            
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }
    }
}
