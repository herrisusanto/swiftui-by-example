//
//  HomeScrollToHideTabBarView.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import SwiftUI

struct HomeScrollToHideTabBarView: View {
    // MARK:  View properties
    @State private var tabState: Visibility = .visible
    
    var body: some View {
        TabView {
            NavigationStack{
                TabStateScrollView(axis: .vertical, showsIndicator: false,tabState: $tabState){
                    // MARK:  Any scroll content
                    VStack(spacing: 15) {
                        ForEach(TripCard.MOCK_TRIP_CARDS){card in
                            GeometryReader(content: { geometry in
                                let size = geometry.size
                                Image(card.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(.rect(cornerRadius: 12))
                            })
                            .frame(height: 180)
                        }
                    }
                    .padding(15)
                    
                }
                .navigationTitle("Home")
            }
            .toolbar(tabState, for: .tabBar)
            .animation(.easeInOut(duration: 0.3), value: tabState)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            // MARK:  Other sample tab's
            Text("Favorites")
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Favorite")
                }
            Text("Notifications")
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
            
            Text("Account")
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
    }
}

#Preview {
    HomeScrollToHideTabBarView()
}
