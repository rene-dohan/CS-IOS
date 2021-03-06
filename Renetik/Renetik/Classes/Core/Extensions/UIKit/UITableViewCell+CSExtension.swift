//
// Created by Rene Dohan on 1/22/20.
//

import UIKit

public extension UITableViewCell {

    @discardableResult
    override open func construct() -> Self {
        super.construct()
        selectedBackgroundView = UIView.construct(color: .clear)
        contentView.matchParent()
        return self
    }

    public func setBackgroundViewColor(_ color: UIColor) {
        backgroundView = UIView.construct(color: color)
    }

    public func setSelectedBackgroundColor(_ color: UIColor) {
        selectedBackgroundView = UIView.construct(color: color)
    }

    public var cellView: UIView? { contentView.content }

    @discardableResult
    open override func heightToFit() -> Self {
        contentView.heightToFit()
        super.heightToFit()
        return self
    }
}

extension UITableViewCell: CSHasTextProtocol {
    public func text() -> String? { textLabel?.text }

    public func text(_ text: String?) { textLabel?.text = text }
}