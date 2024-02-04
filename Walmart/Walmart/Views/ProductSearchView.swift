//
//  ProductSearchView.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import SwiftUI

struct ProductSearchView: View {
    var product: Product
    var vm = ProductSearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        AsyncImage(url: URL(string: product.thumbnail)) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width / 3, height: 150)
                    }
                    
                    VStack {
                        HStack {
                            Text(String(format: "Now $%.2f", vm.calculateCurrentPrice(originalPrice: Double(product.price), discountPercentage: product.discountPercentage)))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.green)
                            Text("$\(product.price)")
                                .font(.subheadline)
                                .foregroundStyle(Color.secondary)
                                .strikethrough(true, color: .secondary)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(product.title)
                            Spacer()

                        }
                        .padding(.bottom, 6)
                        
                        HStack(spacing: 0.25) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= Int(product.rating) ? "star.fill" : "star")
                                    .foregroundColor(Color.yellow)
                                    .font(.caption)
                            }
                                                    
                            Spacer()
                        }
                        .padding(.bottom, 6)

                        HStack {
                            Text("Save with W+")
                                .foregroundStyle(Color.blue)
                                .fontWeight(.bold)
                                .font(.caption2)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Free shipping, arrives **in 2 days**")
                                .font(.caption)
                            Spacer()
                        }
                        
                        ZStack {

                            Rectangle().frame(height: 30)
                                .foregroundStyle(Color.blue)
                                .cornerRadius(25)
                            Text("Add to cart")
                                .fontWeight(.bold)
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                        }
                        .padding(.trailing)
                        

                    }
                }
            }
        }
    }
}

#Preview {
    ProductSearchView(product: Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]))
}
