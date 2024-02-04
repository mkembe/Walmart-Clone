//
//  CategoryView.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var vm = CategoryViewModel()
    var category: String
    
    var body: some View {
        NavigationStack {
            switch vm.state {
            case .loading:
                Text("Loading")
            case .success(let products):
                ScrollView {
                    HStack {
                        Text(category)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("(\(products.count)+)")
                            .foregroundStyle(Color.secondary)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Prices when purchased online")
                            .font(.subheadline)
                        Button {
                            vm.infoSheetShowing.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(Color.primary)
                        }
                        .sheet(isPresented: $vm.infoSheetShowing) {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("Pricing information")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Button {
                                        vm.infoSheetShowing.toggle()
                                    } label: {
                                        Image(systemName: "xmark")
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.primary)
                                    }
                                }
                                .padding(.bottom)
                                
                                Text("Prices, terms, and availability may vary online, in stores, and in-app. Items ordered online may be available for pick up at store, shipping, or delivery. Some items may be available from Marketplace Sellers, who set their own prices, and are not eligible for price match. Items sold online by Walmart may be eligible for price match.")
                                
                                Spacer()
                            }
                            .padding()
                            .presentationDetents([.fraction(0.25)])

                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ForEach(products, id: \.id) { product in
                        ProductSearchView(product: product)
                            .padding()
                    }

                }
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .onAppear {
            Task {
                await vm.getProducts(category: category)
            }
        }
    }
}

#Preview {
    CategoryView(category: "smartphones")
}
