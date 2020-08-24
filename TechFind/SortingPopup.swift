//
//  SortingPopup.swift
//  TechFind
//
//  Created by Matis Luzi on 8/24/20.
//  Copyright © 2020 Matis Luzi. All rights reserved.
//

import SwiftUI
import SwiftUIX

// sorting popup view
struct SortingPopup: View {
    @Binding var viewOffset: CGSize
    @Binding var showingSortView: Bool
    @Binding var sortBy: String

    var body: some View {
        ZStack {
            BlurEffectView(style: .systemThinMaterial)
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
                .hidden(self.showingSortView == true ? false : true) // show only when showing sort view
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.showingSortView.toggle()
                    }
                }

            if showingSortView {
                SortingPopupView(showingSortView: self.$showingSortView, sortBy: self.$sortBy)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
                    .offset(y: viewOffset.height)
                    .onTapGesture {} // needed so picker doesnt bug when dragging
                    // drag gesture
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.height > 0 {
                                    self.viewOffset.height = gesture.translation.height * 0.3
                                }
                            }
                            .onEnded { _ in
                                if self.viewOffset.height > 30 {
                                    withAnimation {
                                        self.showingSortView.toggle()
                                    }
                                }
                                else {
                                    self.viewOffset = .zero
                                }
                            }
                    )
            }
        }
    }
}
