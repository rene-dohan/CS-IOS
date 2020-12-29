//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import RenetikObjc
import BlocksKit

public extension UIView {

    class func construct(owner: NSObject? = nil, xib: String) -> Self {
        let arrayOfXibObjects = Bundle.main.loadNibNamed(xib, owner: owner, options: nil)
        let instance = (arrayOfXibObjects?[0] as? Self)?.construct()
        return instance!
    }

    class func construct(width: CGFloat, height: CGFloat) -> Self {
        construct().width(width, height: height)
    }

    class func construct(width: CGFloat) -> Self {
        construct().width(width)
    }

    class func construct(color: UIColor) -> Self {
        construct().background(color)
    }

    class func construct(frame: CGRect) -> Self {
        construct().frame(frame)
    }

    @discardableResult
    class func construct(defaultSize: Bool = false) -> Self {
        let this: Self = Self().construct()
        if defaultSize { this.defaultSize() }
        return this
    }

    @discardableResult
    @objc open func construct() -> Self { clipsToBounds().setAutoresizingDefaults() }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc open func onClick(_ block: @escaping Func) -> Self {
        onTap { block() }
        return self
    }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    @objc open func onTap(_ block: @escaping Func) -> Self {
        isUserInteractionEnabled = true
        bk_(whenTapped: { block() })
        return self
    }

    /** Overriding non-@objc declarations from extensions is not supported **/
    @discardableResult
    open func onLongPress(_ block: @escaping Func) -> Self {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer.bk_recognizer { _, _, _ in
            block()
        } as! UILongPressGestureRecognizer)
        return self
    }

    @discardableResult
    func background(_ color: UIColor) -> Self { invoke { self.backgroundColor = color } }

    @discardableResult
    func background(_ color: UIColor, opacity: CGFloat) -> Self {
        background(color.add(alpha: opacity))
    }

    @discardableResult
    func background(color: UIColor, opacity: CGFloat = 1) -> Self {
        background(color.add(alpha: opacity))
    }

    @discardableResult
    func interaction(enabled: Bool) -> Self { isUserInteractionEnabled = enabled; return self }

    @discardableResult
    func tint(color: UIColor) -> Self { self.tintColor = color; return self }

    @discardableResult
    func content(mode: UIView.ContentMode) -> Self { self.contentMode = mode; return self }

    @discardableResult
    func clipsToBounds(_ value: Bool = true) -> Self { self.clipsToBounds = value; return self }

    @discardableResult
    func asCircular() -> Self {
        //    let longerSide = self.width > self.width ? self.width : self.height;
        aspectFill()
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }

    @discardableResult
    func roundedCorners(_ width: Int = 5) -> Self {
        layer.cornerRadius = CGFloat(width)
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }

    @discardableResult
    @objc func aspectFit() -> Self { contentMode = .scaleAspectFit; return self }

    @discardableResult
    func clipToBounds() -> Self { clipsToBounds = true; return self }

    @discardableResult
    @objc func aspectFill() -> Self { contentMode = .scaleAspectFill; return self }

    @discardableResult
    func border(width: CGFloat = 1, color: UIColor = .darkGray, radius: CGFloat = 3) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
        return self
    }

    func clone() -> Self {
        NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! Self
    }

    var firstResponder: UIView? {
        for view in subviews {
            if view.isFirstResponder { return view }
            let childFirstResponder = view.firstResponder
            if childFirstResponder.notNil { return childFirstResponder }
        }
        return nil
    }

    @discardableResult
    func background(fadeTo color: UIColor) -> Self {
        if backgroundColor == color { return self }
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = backgroundColor?.cgColor
        animation.toValue = color.cgColor
        animation.duration = .defaultAnimation
        layer.add(animation, forKey: "fadeAnimation")
        backgroundColor = color
        return self
    }

    @discardableResult
    func fadeToggle() -> Self { (isVisible && alpha == 1).then { fadeOut() }.elseDo { fadeIn() }; return self }

    @discardableResult
    func fadeTo(visible: Bool) -> Self { visible.isTrue { fadeIn() }.elseDo { fadeOut() }; return self }

    func fadeIn(duration: TimeInterval = .defaultAnimation, onDone: (Func)? = nil) {
        if isVisible && alpha == 1 { return }
        isVisible = true
        UIView.animate(withDuration: duration, delay: 0,
                options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                animations: { self.alpha = 1.0 },
                completion: { _ in onDone?() })
    }

    func fadeOut(duration: TimeInterval = .defaultAnimation, onDone: (Func)? = nil) {
        if isHidden || alpha == 0 { return }
        UIView.animate(withDuration: duration, delay: 0,
                options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState],
                animations: { self.alpha = 0.0 },
                completion: { isFinished in
                    if isFinished { self.alpha = 1; self.hide() }
                    onDone?()
                })
    }

    func debugLayoutByRandomBorderColor() {
        border(color: UIColor.random())
        debugLayoutBySubviewsRandomBorderColor()
    }

    func debugLayoutBySubviewsRandomBorderColor() {
        subviews.each {
            $0.border(color: UIColor.random())
            $0.debugLayoutBySubviewsRandomBorderColor()
        }
    }

    func debugLayoutBySubviewsRandomColor() {
        background(UIColor.random())
        debugLayoutBySubviewsRandomBackgroundColor()
    }

    func debugLayoutBySubviewsRandomBackgroundColor() {
        subviews.each {
            $0.background(UIColor.random())
            $0.debugLayoutBySubviewsRandomBackgroundColor()
        }
    }
}