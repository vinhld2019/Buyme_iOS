//
//  StringUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2/7/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

extension String {
    
    var normal: String {
        let str = self.folding(options: .diacriticInsensitive, locale: .current)
        return str.replacingOccurrences(of: "đ", with: "d").replacingOccurrences(of: "Đ", with: "D")
    }

    var isVietNamMobilePhoneNumber: Bool { regex(regex: "^(0084|\\+84|0)([3|5|7|8|9])([0-9]{8})$") }

    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z]{1,}[A-Z0-9a-z._%+-]{0,}@[A-Za-z0-9]{1,}[A-Za-z0-9-]+(\\.[A-Za-z]{2,64}){1,}"
        return regex(regex: emailRegEx)
    }

    func regex(regex: String) -> Bool {
        let stringTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return stringTest.evaluate(with: self)
    }
    
    func matchesRegex(for regex: String) -> [String] {
        let text = self
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let results = regex.matches(in: text,
                                        range: NSRange(location: 0, length: text.count))
            let finalResult = results.map {
                (text as NSString).substring(with: $0.range)
            }
            return finalResult
        } catch let error {
            nothingHandle(error: error)
            return []
        }
    }

    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, range.lowerBound)),
            upper: min(count, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    var money: String {
        MoneyUtils.fromString(money: self)
    }

    var currency: String {
        return self.contains(".") ? self.doubleCurrency : self.intCurrency
    }

    var intCurrency: String {
        return MoneyUtils.fromString(money: self.number)
    }

    var doubleCurrency: String {
        let string = self
        if string == "." && string.count == 1 {
            return "0."
        }

        if string.suffix(1) == "." {
            let val = String(string.prefix(string.count - 1))
            if val.range(of: ".") != nil {
                return val
            }
            return string
        }

        if string.range(of: ".") == nil {
            return string
        }

        let nums = string.split(separator: ".")
        let num = String(nums[0]).number
        var num1 = String(nums[1]).number
        if num1.count > 3 {
            num1 = String(num1.prefix(3))
        }

        return "\(MoneyUtils.fromString(money: num)).\(num1)"
    }

    var number: String {
        var amount = self
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amount = regex.stringByReplacingMatches(in: amount, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: amount.count), withTemplate: "")
        } catch {
            nothingHandle(error: error)
        }
        
        if let num = Int64(amount) {
            return "\(num)"
        }
        
        return amount
    }
}

extension Character {
    var isAscii: Bool {
        return unicodeScalars.first?.isASCII == true
    }
    var ascii: UInt32? {
        return isAscii ? unicodeScalars.first?.value : nil
    }

    var isNumber: Bool {
        if let ascii = ascii {
            return (ascii >= Int32(48) && ascii <= Int32(57))
        }
        return false
    }

    var isLowerCase: Bool {
        if let ascii = ascii {
            return (ascii >= Int32(97) && ascii <= Int32(122))
        }
        return false
    }

    var isUpperCase: Bool {
        if let ascii = ascii {
            return (ascii >= Int32(65) && ascii <= Int32(90))
        }
        return false
    }

    var isSpecialCharacter: Bool! {
        if let ascii = ascii {
            return (ascii >= Int32(33) && ascii <= Int32(47))
                || (ascii >= Int32(58) && ascii <= Int32(64))
                || (ascii >= Int32(91) && ascii <= Int32(96))
                || (ascii >= Int32(123) && ascii <= Int32(126))
        }
        return false
    }
}

extension Int64 {
    var money: String {
        MoneyUtils.fromLong(money: self)
    }
}

extension Double {
        var money: String {
        let string = String(self)
        let array = string.split(separator: ".")
        let intPart = String(array[0])
        var rem = String(array[1])
        rem = rem == "0" ? "" : ".\(rem)"
        return "\(MoneyUtils.fromString(money: intPart))\(rem)"
    }
}

extension StringProtocol {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
