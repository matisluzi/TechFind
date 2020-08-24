//
//  ExpandedView.swift
//  TechFind
//
//  Created by Matis Luzi on 8/20/20.
//  Copyright © 2020 Matis Luzi. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct ExpandedView: View {
    // sorting popup view
    @State public var showingSortView = false // controls the sorting popup
    @State public var sortBy = "Brand" // controls sorting, default sorting is by brand
    @State var viewOffset = CGSize.zero // in charge of moving the sorting view when dragged down

    var productType: ProductType
    var products: [Product]
    @Binding var showingExpandedView: Bool

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(productType.name)
                            .font(.largeTitle, weight: .bold)
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                self.showingSortView.toggle()
                                self.viewOffset = CGSize.zero
                            }
                        }) {
                            Image(systemName: "list.bullet").font(.system(size: 20, weight: .bold)).padding(.trailing, 10)
                        }
                        Divider()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                self.showingExpandedView = false
                            }
                        }) {
                            Image(systemName: "xmark.circle").font(.system(size: 20, weight: .bold)).padding(.leading, 10)
                        }
                    }.padding(.horizontal, 20)

                    Divider()
                        .padding(.horizontal, 20)

                    // brand sorting
                    if sortBy == "Brand" {
                        ForEach(0 ..< self.products.count) { index in
                            CardView(
                                products: self.products.sorted(by: { $0.company < $1.company }),
                                index: index,
                                showingExpandedView: self.$showingExpandedView
                            )
                        }
                    }
                    // name sorting
                    else if sortBy == "Name" {
                        ForEach(0 ..< self.products.count) { index in
                            CardView(
                                products: self.products.sorted(by: { $0.name < $1.name }),
                                index: index,
                                showingExpandedView: self.$showingExpandedView
                            )
                        }
                    }
                    // price desc sorting
                    else if sortBy == "Price Descending" {
                        ForEach(0 ..< self.products.count) { index in
                            CardView(
                                products: self.products.sorted(by: { $0.price > $1.price }),
                                index: index,
                                showingExpandedView: self.$showingExpandedView
                            )
                        }
                    }
                    // price asc sorting
                    else if sortBy == "Price Ascending" {
                        ForEach(0 ..< self.products.count) { index in
                            CardView(
                                products: self.products.sorted(by: { $0.price < $1.price }),
                                index: index,
                                showingExpandedView: self.$showingExpandedView
                            )
                        }
                    }
                }.padding(.vertical, 20)
            }
            // sorting popup view
            SortingPopup(viewOffset: $viewOffset, showingSortView: $showingSortView, sortBy: $sortBy)
        }.accentColor(.systemIndigo)
    }
}
