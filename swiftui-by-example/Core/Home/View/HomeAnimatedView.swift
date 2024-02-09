//
//  HomeAnimatedView.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import SwiftUI

struct HomeAnimatedView: View {
    @State private var activeTab: Tab = .photos
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    // MARK:  Bound property
    @State private var bounceDown: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                NavigationStack {
                    VStack{
                        
                    }.navigationTitle(Tab.photos.title)
                }
                .setUpTab(.photos)
                
                NavigationStack {
                    VStack{
                        
                    }.navigationTitle(Tab.chat.title)
                }
                .setUpTab(.chat)
                
                NavigationStack {
                    VStack{
                        
                    }.navigationTitle(Tab.apps.title)
                }
                .setUpTab(.apps)
                
                NavigationStack {
                    VStack{
                        
                    }.navigationTitle(Tab.notifications.title)
                }
                .setUpTab(.notifications)
                
                NavigationStack {
                    VStack{
                        
                    }.navigationTitle(Tab.profile.title)
                }
                .setUpTab(.profile)
            }
        }
        
        Picker("", selection: $bounceDown) {
            Text("Bounce Down")
                .tag(true)
            
            Text("Bounce Up")
                .tag(false)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 15)
        .padding(.bottom, 20)
        
        CustomTabBar()
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach($allTabs){ $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(bounceDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
                
            }
        }
        .background(.bar)
    }
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
        
    }
}

#Preview {
    HomeAnimatedView()
}
