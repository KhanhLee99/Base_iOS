//
//  RegEx.swift
//  TrueID
//
//  Created by Kittiphat Srilomsak on 12/3/2559 BE.
//  Copyright © 2559 True Corporation. All rights reserved.
//

import Foundation

/**
 
 let r = RegEx("[0-9]+\s?%")
 r.test(targetText)
 let replacedText = r.replace(targetText, with: replaceText)
 */
public class RegEx {
    
    public let internalExpression: NSRegularExpression
    public let pattern: String
    
    public init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    public func test(input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: .withoutAnchoringBounds, range: NSMakeRange(0, input.count))
        return matches.count > 0
    }
    
    public func replace(input: String, with: String) -> String {
        return self.internalExpression.stringByReplacingMatches(in: input, options: .withoutAnchoringBounds, range: NSMakeRange(0, input.count), withTemplate: with)
    }
    
    public func matchOne(input: String) -> String? {
        guard let result = self.internalExpression.firstMatch(in: input, options: .withoutAnchoringBounds, range: NSMakeRange(0, input.count)) else {
            return nil
        }
        
        if result.numberOfRanges > 1 {
            return (input as NSString).substring(with: result.range(at: 1))
        }
        
        return (input as NSString).substring(with: result.range)
    }
    
    public func match(input: String) -> [NSTextCheckingResult] {
        var results: [NSTextCheckingResult] = []
        self.internalExpression.enumerateMatches(in: input, options: .withoutAnchoringBounds, range: NSRange(location: 0, length: input.count)) { (result, _, _) in
            if let matchedResult = result {
                results.append(matchedResult)
            }
        }
        return results
    }
}

public extension String {
    func replace(_ pattern: RegEx, with: String) -> String {
        return pattern.replace(input: self, with: with)
    }
    
    func `is`(_ pattern: RegEx) -> Bool {
        return pattern.test(input: self)
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

public extension RegEx {
    static let integer = RegEx("^\\d+$")
    static let landLine = RegEx("^02[0-9]{1,7}$")
    static let mobileNumbers = RegEx("^0[0-9]{1,9}$")
    static let validLoginNumber = RegEx("^[0-9]+$")
    static let validEmail = RegEx("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let newPhoneNumber = RegEx("^((\\+{1}(66){1})|(0)){1}\\d{8,9}$")
    static let versionString = RegEx("^[0-9]+\\.[0-9]+\\.[0-9]+$")
    static let majorVersion = RegEx("^([0-9]+)\\.")
    static let minorVersion = RegEx("\\.([0-9]+)\\.")
    static let revisionVersion = RegEx("\\.([0-9]+)$")
}
