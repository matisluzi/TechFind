//
//  ContentView.swift
//  TechFind
//
//  Created by Matis Luzi on 8/15/20.
//

import SwiftUI
import SwiftUIX

struct ContentView: View {
    // sorting popup view
    @State public var showingSortView = false // controls the sorting popup
    @State public var sortBy = "Brand" // controls sorting, default sorting is by brand
    @State var viewOffset = CGSize.zero // in charge of moving the sorting view when dragged down

    // array that stores all product types' "name" value
    // helpful when showing ProductContainers later
    var productTypeNames: [String] = (productDB.map { $0.productTypeName }).removingDuplicates()

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        // brand sorting
                        if sortBy == "Brand" {
                            BrandSortedContainer(productTypeNames: productTypeNames)
                        }

                        // alphabetic sorting
                        else if sortBy == "Name" {
                            NameSortedContainer(productTypeNames: productTypeNames)
                        }

                        // price sorting desc
                        else if sortBy == "Price Descending" {
                            DescPriceSortedContainer(productTypeNames: productTypeNames)
                        }

                        // price sorting asc
                        else if sortBy == "Price Ascending" {
                            AscPriceSortedContainer(productTypeNames: productTypeNames)
                        }
                    }
                }
                .navigationBarTitle("TechFind")
                .navigationBarItems(
                    leading: Button(action: { // button toggles sorting popup view
                        withAnimation(.easeInOut) {
                            self.showingSortView.toggle()
                            self.viewOffset = CGSize.zero
                        }
                    }) {
                        Image(systemName: "list.bullet").font(.system(size: 20, weight: .bold))
                    }
                )
            }

            // popup view for sorting
            SortingPopup(viewOffset: $viewOffset, showingSortView: $showingSortView, sortBy: $sortBy)

        }.accentColor(.systemIndigo)
    }
}

// produces ProductContainers if user has selected brand sorting
struct BrandSortedContainer: View {
    var productTypeNames: [String]
    var body: some View {
        ForEach(0 ..< productTypeNames.count) { index in
            ProductContainer(
                productType: productTypes.first(where: { $0.name == self.productTypeNames[index] })!,
                productIcon: productTypes.first(where: { $0.name == self.productTypeNames[index] })!.icon,
                products: productDB.filter { $0.productTypeName == self.productTypeNames[index] }.sorted(by: { $0.company < $1.company })
            )
        }
    }
}

// produces ProductContainer if user has selected alphabetic sorting
struct NameSortedContainer: View {
    var productTypeNames: [String]
    var body: some View {
        ForEach(0 ..< productTypeNames.count) { index in
            ProductContainer(
                productType: productTypes.first(where: { $0.name == self.productTypeNames[index] })!,
                productIcon: productTypes.first(where: { $0.name == self.productTypeNames[index] })!.icon,
                products: productDB.filter { $0.productTypeName == self.productTypeNames[index] }.sorted(by: { $0.name < $1.name })
            )
        }
    }
}

// produces ProductContainer if user has selected price descending sorting
struct DescPriceSortedContainer: View {
    var productTypeNames: [String]
    var body: some View {
        ForEach(0 ..< productTypeNames.count) { index in
            ProductContainer(
                productType: productTypes.first(where: { $0.name == self.productTypeNames[index] })!,
                productIcon: productTypes.first(where: { $0.name == self.productTypeNames[index] })!.icon,
                products: productDB.filter { $0.productTypeName == self.productTypeNames[index] }.sorted(by: { $0.price > $1.price })
            )
        }
    }
}

// produces ProductContainer if user has selected price ascending sorting
struct AscPriceSortedContainer: View {
    var productTypeNames: [String]
    var body: some View {
        ForEach(0 ..< productTypeNames.count) { index in
            ProductContainer(
                productType: productTypes.first(where: { $0.name == self.productTypeNames[index] })!,
                productIcon: productTypes.first(where: { $0.name == self.productTypeNames[index] })!.icon,
                products: productDB.filter { $0.productTypeName == self.productTypeNames[index] }.sorted(by: { $0.price < $1.price })
            )
        }
    }
}

// DEBUG
// show preview on xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
