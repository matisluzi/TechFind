//
//  products.swift
//  TechFind
//
//  Created by Matis Luzi on 8/15/20.
//

import CSV
import SwiftIcons
import SwiftUI

// product struct
// contains product info: name, price, company, product type, and product link
struct Product: Hashable {
    let name, company: String
    let price: Double
    let productTypeName: String
    // link that opens when user presses "More Info" button
    let link: URL
}

// product type struct
// contains product type as a string, and the corresponding IcoFont icon for each type
struct ProductType: Hashable {
    let name: String
    let icon: IcofontType

    static func == (lhs: ProductType, rhs: ProductType) -> Bool {
        return (lhs.name == rhs.name && lhs.icon == rhs.icon)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(icon)
    }
}

// array of all possible product types
var productTypes: [ProductType] = [
    ProductType(name: "Phones", icon: .uiTouchPhone),
    ProductType(name: "Laptops", icon: .laptop),
    ProductType(name: "PCs", icon: .computer),
    ProductType(name: "Headphones", icon: .headphone),
    ProductType(name: "Cases", icon: .broken),
    ProductType(name: "Power Banks", icon: .batteryFull),
    ProductType(name: "Wireless Chargers", icon: .charging)
]

// product database array
// gets populated by load_DB function on app launch
var productDB = [Product]()

// load the database csv file, which contains all the products
func load_DB() {
    do {
        let fileURL = Bundle.main.url(forResource: "db", withExtension: "csv")!
        let stream = InputStream(url: fileURL)!
        let csv = try CSVReader(stream: stream, hasHeaderRow: true)

        while csv.next() != nil {
            // populate productDB
            productDB.append(Product(
                name: csv["name"]!,
                company: csv["company"]!,
                price: Double(csv["price"]!)!,
                productTypeName: csv["productTypeName"]!,
                link: URL(string: csv["link"]!)!)
            )
        }
    }
    catch {
        print("Error: \(error)")
    }
}
