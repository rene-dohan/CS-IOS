//
// Created by Rene Dohan on 12/27/20.
//

import Foundation

public func function(if boolean: Bool, function: Func) -> CSConditionalResult {
    if boolean { function() }
    return CSConditionalResult(doElseIf: boolean == false)
}

func functionTest() {
    let A = "A"
    let B = "B"
    function(if: A == B) {
        logInfo("A == B")
    }.elseDo {
        logInfo("A != B")
    }
}

public class Chassis: CSViewController {
//    convenience init() {
//        self.init(frame: .defaultViewRect)
//        background(color: .red)
//    }
}

public class RacingChassis: Chassis {
}

public class Car {
    private let _chassis = Chassis()

    open func chassis() -> Chassis { _chassis }
}

public class RaceCar: Car {
    private let _chassis = RacingChassis()

    open override func chassis() -> RacingChassis { _chassis }
}