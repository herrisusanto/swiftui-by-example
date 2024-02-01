//
//  CustomeTextField.swift
//  swiftui-by-example
//
//  Created by loratech on 01/02/24.
//

import SwiftUI

struct CustomTextField: View {
    
    var icon: String
    var title: String
    var hint: String
    
    @Binding var value: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(CustomFont.regular, size: 14))
            }icon: {
                Image(systemName: icon)
            }
            .foregroundStyle(.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword {
                SecureField(hint, text: $value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: $value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(.black.opacity(0.4))
        }
        .padding(.top, 25)
        .overlay (
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.toggle()
                    }, label: {
                        Text(showPassword ? "Hide" : "Show")
                            .foregroundStyle(Color("PrimaryBlue"))
                    })
                    .offset(y: 20)
                }
            },
            alignment: .trailing
        )
        
    }
}

#Preview {
    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: .constant("12345"), showPassword: .constant(true))
}
