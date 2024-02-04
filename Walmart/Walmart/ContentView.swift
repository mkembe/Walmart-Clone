//
//  ContentView.swift
//  Walmart
//
//  Created by Millie Kembe on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var search = ""
    var body: some View {
        NavigationStack {
            TabView() {
                SearchBarView()
                    .tabItem {
                        Label("Shop", systemImage: "building.columns.fill")
                    }
                ItemsView()
                    .tabItem {
                        Label("My Items", systemImage: "heart")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ServicesView()
                    .tabItem {
                        Label("Services", systemImage: "circle.grid.2x2")
                    }
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person.circle")
                    }
            }

        }

    }
}

#Preview {
    ContentView()
}
