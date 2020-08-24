//
//  SortingPopupView.swift
//  TechFind
//
//  Created by Matis Luzi on 8/17/20.
//  Copyright © 2020 Matis Luzi. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct SortingPopupView: View {
    @Binding var showingSortView: Bool
    @Binding var sortBy: String

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Sort By")
                        .font(.largeTitle, weight: .heavy).padding(30)
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.showingSortView = false
                        }
                    }) {
                        Text("Done")
                            .font(.system(size: 20))
                    }.padding(30)
                }
                Picker(selection: $sortBy, label: Color.clear) {
                    Text("Brand").tag("Brand")
                    Text("Name").tag("Name")
                    Text("Price Descending").tag("Price Descending")
                    Text("Price Ascending").tag("Price Ascending")
                }.labelsHidden().frame(maxWidth: .infinity).padding(.bottom, 100)
            }.background(Color.secondarySystemGroupedBackground).cornerRadius([.topLeading, .topTrailing], 10)
                .padding(.bottom, -100)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct SortingPopupView_Previews: PreviewProvider {
    static var previews: some View {
        SortingPopupView(showingSortView: .constant(true), sortBy: .constant("Default"))
    }
}
