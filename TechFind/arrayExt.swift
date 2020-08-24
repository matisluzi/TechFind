//
//  arrayExt.swift
//  TechFind
//
//  Created by Matis Luzi on 8/20/20.
//  Copyright © 2020 Matis Luzi. All rights reserved.
//

// ==========================================================
// array extension to remove duplicates from array
// ==========================================================

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
