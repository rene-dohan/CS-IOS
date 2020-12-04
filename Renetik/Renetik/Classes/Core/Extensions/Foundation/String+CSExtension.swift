//
//  String+CSExtension.swift
//  Renetik
//
//  Created by Rene Dohan on 2/14/19.
//

import Foundation
import RenetikObjc

public extension String {

    static let newLine = "\n"

    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in
            letters.randomElement()!
        })
    }

    func parseJsonObject() -> [String: Any?]? { parseJson() as? [String: Any?] }

    func parseJsonArray() -> [Any]? { parseJson() as? [Any] }

    func parseJson() -> Any? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments])
        }
        return nil
    }

    var isSet: Bool { !isEmpty }

    var length: Int { count }

    var asNSString: NSString { self as NSString }

    var boolValue: Bool { asNSString.boolValue }

    var doubleValue: Double { asNSString.doubleValue }

    var intValue: Int { asNSString.integerValue }

    func trim() -> String { asNSString.trim() }

    func substring(from index: Int) -> String {
        asNSString.substring(from: index, to: length) as String
    }

    func substring(to index: Int) -> String {
        asNSString.substring(from: 0, to: index) as String
    }

    func substring(from: Int, to: Int) -> String {
        asNSString.substring(from: from, to: to) as String
    }

    func substring(_ range: ClosedRange<Int>) -> String {
        substring(from: range.first!, to: range.last!)
    }

    @inlinable public func stringIndex(at: String.IndexDistance) -> String.Index {
        self.index(startIndex, offsetBy: at)
    }

    func index(of string: String, from: Int) -> Int? {
        let index = asNSString.index(of: string, from: from)
        return index >= 0 ? index : nil
    }

    func index(of string: String) -> Int? { index(of: string, from: 0) }

    func contains(_ string: String, ignoreCase: Bool = false) -> Bool {
        ignoreCase ? asNSString.containsNoCase(string) : asNSString.contains(string)
    }

    func ends(with value: String) -> Bool { hasSuffix(value) }

    func starts(with value: String) -> Bool { hasPrefix(value) }

    func remove(_ string: String) -> String { remove(all: string) }

    func remove(all string: String) -> String { replace(all: string, with: "") }

    func replace(all string: String, with replace: String) -> String {
        replacingOccurrences(of: string, with: replace)
    }

    public func replace(range: NSRange, with string: String) -> String {
        asNSString.replacingCharacters(in: range, with: string)
    }

    func attributed(_ dictionary: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        NSAttributedString(string: self, attributes: dictionary)
    }

    public func split(by separator: String) -> [String] { components(separatedBy: separator) }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if self == nil {
            return true
        }
        return self!.isEmpty
    }

    public func isNilOrEmpty(_ function: Func) -> Self {
        if isNilOrEmpty { function() }
        return self
    }

    public var isSet: Bool {
        if self == nil {
            return false
        }
        return !self!.isEmpty
    }

    public func contains(_ string: String) -> Bool {
        if self == nil {
            return false
        }
        return self!.contains(string)
    }


}
