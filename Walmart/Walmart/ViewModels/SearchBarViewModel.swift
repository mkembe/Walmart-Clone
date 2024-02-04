//
//  SearchBarViewModel.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import Foundation

enum SearchBarState {
    case idle
    case loading
    case success(products: [Product])
    case error(error: Error)
}

class SearchBarViewModel: ObservableObject {
    @Published var state: SearchBarState = .idle
    @Published var search = ""
    @Published var goIdle = false
    @Published var searches: [String] = []
    @Published var infoSheetShowing = false
    
    func getProduct() async {
        do {
            state = .loading
            let products = try await ProductService.findProducts(searchTerm: search)
            searches.append(search)
            state = .success(products: products)
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }
    }
    
    func getRecentProducts(term: String) async {
        do {
            state = .loading
            let products = try await ProductService.findProducts(searchTerm: term)
            state = .success(products: products)
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }    }
        
    func removeSearch(search: String) {
        if let index = searches.firstIndex(of: search) {
            searches.remove(at: index)
        }
    }
}
