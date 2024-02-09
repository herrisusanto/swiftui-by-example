//
//  HomeAnimatedScrollView.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import SwiftUI

struct HomeAnimatedScrollView: View {
    // MARK:  View properties
    @State private var allExpenses: [Expense] = []
    @State private var activeCard: UUID?
    // MARK:  Environment values
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Hello Jennie")
                        .font(.largeTitle.bold())
                        .frame(height: 45)
                        .padding(.horizontal, 15)
                    
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = rect.minY.rounded()
                        
                        // MARK:  Card view
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(Card.MOCK_CARDS){ card in
                                    ZStack {
                                        if minY == 75.0 {
                                            // MARK:  Not scrolled
                                            CardView(card)
                                        } else {
                                            // MARK:  Scrolled and Showing only selected card
                                            
                                            if activeCard == card.id {
                                                CardView(card)
                                                    
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                            }
                                        }
                                        
                                    }
                                    .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollPosition(id: $activeCard)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                        .scrollIndicators(.hidden)
                        .scrollDisabled(minY != 75.0)
                    }
                    .frame(height: 125)
                }
                
                LazyVStack(spacing: 15) {
                    Menu {
                        
                    }label: {
                        HStack(spacing: 4) {
                            Text("Filter By")
                            Image(systemName: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(allExpenses){ expense in
                        ExpenseCardView(expense)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .padding(15)
                .mask {
                    Rectangle()
                        .visualEffect { content, proxy in
                            content
                                .offset(y: backgroundLimitOffset(proxy))
                        }
                }
                .background {
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = min(rect.minY - 125, 0)
                        let progress = max(min(-minY / 25, 1), 0)
                        
                        RoundedRectangle(cornerRadius: 30 * progress, style: .continuous)
                            .fill(scheme == .dark ? .black : .white)
                            // MARK:  Limiting background scroll below the header
                            .visualEffect { content, proxy in
                                content
                                    .offset(y: backgroundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .scrollTargetBehavior(CustomScrollBehavior())
        .scrollIndicators(.hidden)
        .onAppear{
            if activeCard == nil {
                activeCard = Card.MOCK_CARDS.first?.id
            }
        }
        .onChange(of: activeCard, { oldValue, newValue in
            withAnimation(.snappy) {
                allExpenses = Expense.MOCK_EXPENSES.shuffled()
            }
        })
    }
    
    // MARK:  Background limit offset
    func backgroundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        
        return minY < 100 ? -minY + 100 : 0
    }
    
    // MARK:  Card view
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY
            let topValue: CGFloat = 75.0
            
            let offset = min(minY - 75, 0)
            let progress = max(min(-offset / topValue, 1),0)
            let scale: CGFloat = 1 + progress
            
            ZStack {
                Rectangle()
                    .fill(card.bgColor)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(card.bgColor)
                            .overlay {
                                Circle()
                                    .fill(.white.opacity(0.2))
                            }
                            .scaleEffect(2, anchor: .topLeading)
                            .offset(x: -50, y: -40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaleEffect(scale, anchor: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    Text("Current Balance")
                        .font(.callout)
                    
                    Text(card.balance)
                        .font(.title.bold())
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                .offset(y: progress * -25)
            }
            .offset(y: -offset)
            .offset(y: progress * -topValue)
        }
        .padding(.horizontal, 15)
    }
    // MARK:  Expense card view
    @ViewBuilder
    func ExpenseCardView(_ expense: Expense) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer(minLength: 0)
            
            Text(expense.amountSpent)
                .fontWeight(.bold)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 6)
    }
}

struct CustomScrollBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 75 {
            target.rect = .zero
        }
    }
}

#Preview {
    HomeAnimatedScrollView()
}
