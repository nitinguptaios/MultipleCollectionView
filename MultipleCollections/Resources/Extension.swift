//
//  Extension.swift
//  Multiple Collections
//
//  Created by IPH Technologies on 21/04/22.
//
//  Copyright © 2022 IPH Technologies All rights reserved.


import Foundation
import UIKit

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
