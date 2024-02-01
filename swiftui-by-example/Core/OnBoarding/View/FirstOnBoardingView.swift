//
//  FirstOnboarding.swift
//  swiftui-by-example
//
//  Created by loratech on 01/02/24.
//

import SwiftUI

struct FirstOnBoardingView: View {
    
    @State var showLoginView: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("first-onboarding")
                .resizable()
                .frame(width: 350, height: 230)
                .aspectRatio(contentMode: .fit)
            
            HStack{
                Text("Money")
                    .foregroundStyle(.white)
                Text("Moora")
                    .foregroundStyle(Color("PrimaryPink"))
                
            }
            .font(.custom(CustomFont.bold, size: 36))
            .fontWeight(.bold)
            .padding(.vertical, 60)
            
            Text("A brand new experience\nof managing your business")
                .font(.custom(CustomFont.regular, size: 24))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button{
                withAnimation {
                    showLoginView.toggle()
                }
            }label: {
                Text("Get Started Now!")
                    .font(.custom(CustomFont.regular, size: 20))
                    .foregroundStyle(Color("PrimaryPink"))
                    .fontWeight(.bold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            }
            .padding(10)
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryBlue"))
        .overlay {
            Group {
                if showLoginView {
                    AuthView()
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    FirstOnBoardingView()
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
