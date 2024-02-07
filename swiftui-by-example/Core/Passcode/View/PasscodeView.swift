//
//  PasscodeView.swift
//  swiftui-by-example
//
//  Created by loratech on 07/02/24.
//

import SwiftUI

struct PasscodeView: View {
    
    @State private var passcode = ""
    @Binding var isAuthenticate: Bool
    
    var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 24) {
                Text("Enter Passcode")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Please enter 4-digits pin to securely access your account.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            .padding(.top)
            
            PasscodeIndicatorView(passcode: $passcode)
            
            Spacer()
            
            NumberPadView(passcode: $passcode)
        }
        .onChange(of: passcode) { oldValue, newValue in
            verifyPasscode()
        }
    }
    
    private func verifyPasscode(){
        guard passcode.count == 4 else { return }
        
        Task {
            try? await Task.sleep(nanoseconds: 125_000_000)
            isAuthenticate = passcode == "1111"
            passcode = ""
        }
    }
    
    
}

#Preview {
    PasscodeView(isAuthenticate: .constant(false))
}
