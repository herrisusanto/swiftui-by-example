//
//  HomeView.swift
//  swiftui-by-example
//
//  Created by loratech on 07/02/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showMenu: Bool = false
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                
                SideMenuView(selectedTab: $selectedTab, isShowing: $showMenu)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        showMenu.toggle()
                    }label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    }
                }
            } 
        }
    }
}

#Preview {
    HomeView()
}
