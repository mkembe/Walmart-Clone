//
//  SearchView.swift
//  Walmart
//
//  Created by Millie Kembe on 2/4/24.
//

import SwiftUI


struct SearchView: View {
    var vm = SearchViewModel()
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.blue
                    .frame(height: 120)
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Button {
                        } label: {
                            Text("Search Walmart")
                                .foregroundStyle(.black)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
                .padding(.top, 50)
            }
            .ignoresSafeArea()
            .padding(.bottom, -70)

            VStack {
                VStack(alignment: .leading) {
                    switch vm.state {
                    case .loading:
                        Text("loading")
                    case .success(let categories):
                        List {
                            HStack {
                                Text("All Departments")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.vertical)
                            ForEach(categories, id: \.self) { cat in
                                NavigationLink(destination: CategoryView(category: cat)) {
                                    HStack {
                                        Image(systemName: "building.columns.fill")
                                            .padding(.trailing)
                                        Text(cat)
                                    }
                                    .padding(.vertical)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())


                    case .error(let error):
                        Text(error.localizedDescription)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await vm.getCategories()
            }
        }
    }
}

#Preview {
    SearchView()
}
