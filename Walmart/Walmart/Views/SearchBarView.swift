//
//  SearchBarView.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject var vm = SearchBarViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .frame(height: 120)
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Button {
                                vm.state = .idle
                            } label: {
                                TextField("Search", text: $vm.search)
                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                        .onSubmit {
                                            Task {
                                                await vm.getProduct()

                                            }
                                        }
                            }

                            Image(systemName: "barcode.viewfinder")
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                    .padding()
                        VStack() {
                            Image(systemName: "cart.badge.plus")
                                .foregroundColor(Color.white)
                                .padding(.trailing)
                            Text("$0.00")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .padding(.trailing)
                        }

                    }
                    
                }
                .padding(.top, 50)

            }
            .ignoresSafeArea()
            .padding(.bottom, -50)
            VStack {
                switch vm.state {
                case .idle:
                    VStack {
                        HStack {
                            Text("Your recent searches")
                                .fontWeight(.bold)
                                .font(.caption)
                            Spacer()
                        }
                        .padding(.horizontal)
                        // TODO: Recent searches
                        List {
                            ForEach(vm.searches, id: \.self) {recent in
                                Button {
                                    Task {
                                        await vm.getRecentProducts(term: recent)
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "clock.arrow.circlepath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                        Text(recent)
                                            .font(.subheadline)
                                        Spacer()
                                        Button {
                                            vm.removeSearch(search: recent)
                                        } label: {
                                            Text("X")
                                                .font(.subheadline)
                                                .foregroundStyle(Color.primary)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                case .loading:
                    VStack {
                        Text("Away we go! Stay tuned...")
                    }
                case .success(let products):
                    ScrollView {
                        HStack {
                            Text("Results for '\(vm.search)'")
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
        }
    }
}

#Preview {
    SearchBarView()
}
