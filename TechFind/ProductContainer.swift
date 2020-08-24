//
//  productContainer.swift
//  TechFind
//
//  Created by Matis Luzi on 8/15/20.
//

import SwiftIcons
import SwiftUI
import SwiftUIX

struct ProductContainer: View {
    @Environment(\.colorScheme) var colorScheme

    var productType: ProductType
    var productIcon: IcofontType
    var products: [Product]

    // controls expanded view
    @State public var showingExpandedView: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                // product icon image
                Image(
                    uiImage: UIImage(
                        icon: .icofont(self.productIcon),
                        size: CGSize(width: 50, height: 30),
                        textColor: self.colorScheme == .dark ? .white : .black
                    )
                )
                // product type title
                Text(self.productType.name)
                    .font(.title)
                    .bold()
                    .frame(height: 50)
                Spacer()
                // button that shows expanded view
                Button(action: {
                    self.showingExpandedView.toggle()
                }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                }
            }.padding(.bottom, 0).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0 ..< self.products.count) { index in
                        CardView(
                            products: self.products,
                            index: index,
                            showingExpandedView: self.$showingExpandedView
                        )
                    }
                }
            }
        }.padding(.bottom, 20)
            .sheet(isPresented: self.$showingExpandedView) {
                // expanded view
                ExpandedView(productType: self.productType, products: self.products, showingExpandedView: self.$showingExpandedView)
            }
    }
}
