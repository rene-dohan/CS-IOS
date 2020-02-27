//
//  Integer+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 5/7/19.
//

import Foundation
import CoreGraphics

public extension Int {
    var isEmpty: Bool { self == 0 }
    var isSet: Bool { !isEmpty }
    var set: Bool { isSet }
    var asFloat: CGFloat { CGFloat(self) }
}
