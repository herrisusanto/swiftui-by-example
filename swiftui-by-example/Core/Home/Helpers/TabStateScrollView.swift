//
//  TabStateScrollView.swift
//  swiftui-by-example
//
//  Created by loratech on 09/02/24.
//

import SwiftUI
// MARK:  Custom view
struct TabStateScrollView<Content: View>: View {
    
    var axis: Axis.Set
    var showsIndicator: Bool
    @Binding var tabState: Visibility
    var content: Content
    
    init(axis: Axis.Set, showsIndicator: Bool, tabState: Binding<Visibility>, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.showsIndicator = showsIndicator
        self._tabState = tabState
        self.content = content()
    }
    
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        // MARK:  This project supports iOS 16 and iOS 17
        if #available(iOS 17, *){
            ScrollView(axis){
                content
            }
            .scrollIndicators(showsIndicator ? .visible : .hidden)
            .background {
                CustomGesture {
                    handleTabState($0)
                }
            } 
        } else {
            ScrollView(axis, showsIndicators: showsIndicator) {
                content
            }
            .background {
                CustomGesture {
                    handleTabState($0)
                }
            }
        }
        
    }
    // MARK:  Handling tab state on swipe
    func handleTabState(_ gesture: UIPanGestureRecognizer) {
        _ = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            // MARK:  Swiping Up
            if -(velocityY / 5) > 60 && tabState == .visible {
                tabState = .hidden
            }
        } else {
            // MARK:  Swiping Down
            if (velocityY / 5) > 40 && tabState == .hidden {
                tabState = .visible
            }
        }
        
    }
}

// MARK:  Adding a custom simultaneous UIPan Gesture to know about what direction did the user is swiping
fileprivate struct CustomGesture: UIViewRepresentable {
    var onChange: (UIPanGestureRecognizer) ->()
    // MARK:  Gesture ID
    private let gestureID = UUID().uuidString
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onChange: onChange)
    }
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // MARK:  Verifying if there is already any gesture is Added
        DispatchQueue.main.async {
            if let superView = uiView.superview?.superview, !(superView.gestureRecognizers?.contains(where: { $0.name == gestureID}) ?? false) {
                let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.gestureChange(gesture:)))
                gesture.name = gestureID
                gesture.delegate = context.coordinator
                // MARK:  Adding gesture to the superview
                superView.addGestureRecognizer(gesture)
            }
        }
    }
    
    // MARK:  Selector class
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onChange: (UIPanGestureRecognizer) -> ()
        init(onChange: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onChange = onChange
        }
        
        @objc
        func gestureChange(gesture: UIPanGestureRecognizer){
            // MARK:  Simply calling the onChange callback
            onChange(gesture)
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        
    }
}

#Preview {
    HomeScrollToHideTabBarView()
}
