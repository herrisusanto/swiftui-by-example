//
//  AuthView.swift
//  swiftui-by-example
//
//  Created by loratech on 01/02/24.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome\nBack")
                    .font(.custom(CustomFont.regular, size: 55).bold()) 
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        ZStack {
                            LinearGradient(colors: [
                                Color("PrimaryPink"),
                                Color("PrimaryPink")
                                    .opacity(0.8),
                                Color("PrimaryBlue")
                            ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading, 30)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 50, height: 50)
                                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                            
                        }
                    )
            }
            .frame(height: getRect().height / 3.5)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15) {
                    Text("Login")
                        .font(.custom(CustomFont.regular, size: 24).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    CustomTextField(icon: "envelope", title: "Email", hint: "lissa@blackpink.com", value: $viewModel.email, showPassword: .constant(false))
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $viewModel.password, showPassword: $viewModel.showPassword)
                    
                    if viewModel.isRegisterUser {
                        withAnimation {
                            CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "12345", value: $viewModel.reEnterPassword, showPassword: $viewModel.showReEnterPassword)
                        }
                    }
                    
                    Button{
                        
                    }label: {
                        Text("Forgot password?")
                            .font(.custom(CustomFont.regular, size: 16).bold())
                            .foregroundStyle(Color("PrimaryBlue"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Button{
                        
                    }label: {
                        Text(viewModel.isRegisterUser ? "Register":"Login")
                            .font(.custom(CustomFont.regular, size: 16).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(Color("PrimaryBlue"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                        
                        
                    }
                    .padding(.top, 30)
                    
                    Button{
                        withAnimation {
                            viewModel.isRegisterUser.toggle()
                        }
                    }label: {
                        Text(!viewModel.isRegisterUser ? "Create account" : "Have an account?")
                            .font(.custom(CustomFont.regular, size: 16).bold())
                            .foregroundStyle(Color("PrimaryBlue"))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.white).clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25)).ignoresSafeArea())
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryBlue"))
        .onChange(of: viewModel.isRegisterUser) { oldValue, newValue in
            viewModel.email = ""
            viewModel.password = ""
            viewModel.showPassword = false
            viewModel.reEnterPassword = ""
            viewModel.showReEnterPassword = false
        }
    }
}

#Preview {
    AuthView()
}
