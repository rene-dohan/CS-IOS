//
//  Created by Rene on 11/26/18.
//

import UIKit
import RenetikObjc

public extension UIView {

    @discardableResult
    func add<View: UIView>(view: View, _ apply: ((View) -> ())? = nil) -> View {
        content?.addSubview(view) ?? addSubview(view)
        apply?(view)
        return view
    }

    public func show(in parent: UIView) {
        let transition = CATransition()
        transition.duration = 0.15
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromBottom
        layer.add(transition, forKey: nil)
        parent.add(view: self).matchParent()
    }

    public func hideIn() {
//        let transition = CATransition()
//        transition.duration = 0.15
//        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        transition.type = .push
//        transition.subtype = .fromBottom
//        layer.add(transition, forKey: nil)
//        removeFromSuperview()

        animate(duration: .defaultAnimation, operation: {
            self.bottom = -5
        }, completion: { self.removeFromSuperview() })
    }

    @discardableResult
    func add(all views: UIView...) -> Self {
        views.forEach { view in addSubview(view) }
        return self
    }

    @discardableResult
    func add<View: UIView>(view: View, index: Int, _ apply: ((View) -> ())? = nil) -> View {
        insertSubview(view, at: index)
        apply?(view)
        return view
    }

    @discardableResult
    func set<View: UIView>(view: View, index: Int, _ apply: ((View) -> ())? = nil) -> View {
        subviews.at(index)?.removeFromSuperview()
        add(view: view, index: index)
        apply?(view)
        return view
    }

    func findPrevious(of subview: UIView, skipHidden: Bool = true) -> UIView? {
        if subviews.index(of: subview).isNil { fatalError() }
        return skipHidden ? findVisibleSubviewBackwards(from: subviews.index(of: subview)! - 1)
                : subviews.previous(of: subview)
    }

    var lastVisibleSubview: UIView? { findVisibleSubviewBackwards(from: subviews.lastIndex) }

    func findVisibleSubviewBackwards(from index: Int) -> UIView? {
        var index = index
        while index >= 0 {
            let view = subviews[index]
            if view.isVisible { return view }
            index -= 1
        }
        return nil
    }

    func findLastSubviewOf(type someType: AnyClass) -> UIView? {
        var index = subviews.count - 1
        while index >= 0 {
            let subView = subviews[index]
            if type(of: subView) === someType { return subView }
            index -= 1
        }
        return nil
    }

    @discardableResult
    func clearSubviews() -> Self { invoke { subviews.each { $0.removeFromSuperview() } } }

    @discardableResult
    func removeAllSubviews() -> Self { clearSubviews() }

    var isEmpty: Bool { subviews.isEmpty }

    @discardableResult
    func horizontalGrid<View: UIView>(add view: View, margin: CGFloat = 0, columns: Int = 1) -> View {
        add(view: view).alignHorizontalGrid(margin: margin, columns: columns)
    }

    @discardableResult
    func verticalGrid<View: UIView>(add view: View, margin: CGFloat = 0, rows: Int = 1) -> View {
        add(view: view).alignVerticalGrid(margin: margin, rows: rows)
    }

    @discardableResult
    func addBottomSeparator(height: CGFloat = 0.5, color: UIColor = .darkGray) -> UIView {
        add(view: UIView.construct()).height(height).from(bottom: 0).matchParentWidth()
                .flexibleTop().fixedBottom().background(color)
    }
}
