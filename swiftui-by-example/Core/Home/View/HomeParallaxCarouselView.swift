//
//  HomeParallaxCarouselView.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import SwiftUI

struct HomeParallaxCarouselView: View {
    // MARK:  View properties
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundStyle(.blue)
                    })
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search...", text: $searchText)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: .capsule)
                    
                }
                
                Text("Where do you want to \ntravel")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                // MARK:  Parallax carousel
                
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(TripCard.MOCK_TRIP_CARDS) { card in
                                // MARK:  In order to move the card in reverse direction (Parallax Effect)
                                GeometryReader(content: { proxy in
                                    let cardSize = proxy.size
                                    // MARK:  Simple parallax effect (1)
                                    // let minX = proxy.frame(in: .scrollView).minX
                                    let minX = min((proxy.frame(in: .scrollView).minX * 1.4), proxy.size.width * 1.4 )
                                    
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        // .scaleEffect(1.25)
                                        .offset(x: -minX)
                                        .frame(width: proxy.size.width * 2.5)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay{
                                            OverlayView(card)
                                        }
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                                })
                                .frame(width: size.width - 60, height: size.height - 50)
                                // MARK:  Scroll animation
                                .scrollTransition(.interactive, axis: .horizontal){ view, phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1 : 0.90)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                })
                .frame(height: 500)
                .padding(.horizontal, -15)
                .padding(.top, 10)
            }
            .padding(15)
        }
    }
    
    // MARK:  Overlay view
    @ViewBuilder
    func OverlayView(_ card: TripCard) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [
                .clear,
                .clear,
                .clear,
                .clear,
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.5),
                .black
            
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                Text(card.subtitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding(20)
        }
        
        
    }
    
}

#Preview {
    HomeParallaxCarouselView()
}
