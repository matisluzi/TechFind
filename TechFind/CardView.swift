//
//  CardView.swift
//  TechFind
//
//  Created by Matis Luzi on 8/21/20.
//  Copyright © 2020 Matis Luzi. All rights reserved.
//

import SafariServices
import SwiftUI
import SwiftUIX

struct CardView: View {
    var products: [Product]
    var index: Int
    @Binding var showingExpandedView: Bool
    @State var showingSafariView = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    // company name text
                    Text(self.products[index].company.uppercased())
                        .font(.subheadline).fontWeight(.heavy)
                        .foregroundColor(.white)
                    // product name text
                    Text(self.products[index].name)
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineBreakMode(.byWordWrapping)
                        .frame(minWidth: 120, maxWidth: 220, maxHeight: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }.drawingGroup() // drawingGroup() supposedly improves performance
                
                Spacer()
                
                // price text
                Text("Starting at $" + String(format: "%g", self.products[index].price))
                    .font(.body).bold()
                    .foregroundColor(.white)
                    .drawingGroup()
                
                // more info button
                // opens product page in a safari view
                Button(action: {
                    self.showingSafariView.toggle() // show safari view
                }) {
                    Text("More Info")
                        .font(.system(size: 16), weight: .semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 20).padding(.vertical, 10)
                        .background(BlurEffectView(style: .extraLight))
                        .cornerRadius(10)
                }
            }.padding(10)
                .padding(.trailing, 60)
        }
        .frame(maxWidth: 400, minHeight: 200, idealHeight: 200, maxHeight: .infinity, alignment: .leading)
        .background(randomImageView())
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .sheet(isPresented: self.$showingSafariView) {
            SafariWebView(
                url: self.products[self.index].link
            )
        }
    }
}

// gives the background image with a random hue, to prevent using the same colors in each card, without using multiple images (thus uses less space on disk)
struct randomImageView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("bgImage")
                .resizable()
                .fill()
                .brightness(-0.1)
                .hueRotation(.degrees(Int.random(in: 0 ... 36) * 10))
                .drawingGroup()
            
            BlurEffectView(style: .regular).frame(height: 90)
        }
    }
}
