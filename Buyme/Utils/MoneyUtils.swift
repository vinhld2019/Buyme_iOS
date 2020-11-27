//
//  MoneyUtils.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class MoneyUtils {

    static var decimalSeparator: String {
        NumberFormatter().decimalSeparator
    }
    ///dau phan cach don vi
    static var digitUnit: String {
        NumberFormatter().decimalSeparator == "." ? "," : "."
    }
    static func fomart(money: String) -> String {
        return money.replacingOccurrences(of: MoneyUtils.digitUnit, with: "")
    }

    static func fromDouble(money: Double) -> String {
        return fromLong(money: Int64(money))
    }

    static func fromLong(money: Int64) -> String {
        return fromString(money: String(money))
    }

    static func fromString(money: String) -> String {
        var val = ""
        var mon = money
        while mon.count > 3 {
            let sub = mon.index(mon.startIndex, offsetBy: mon.count - 3)
            val = "," + String(mon[sub...]) + val
            mon = String(mon[..<sub])
        }
        return mon + val
    }
    
    static func amountToWord(amount: String, currency: String) -> String {
        let sAmount = amount
        let array = sAmount.split(separator: ".")
        
        var after = String(array[1])
        if after != "0" {
            after = "phẩy \(amountToWord(amount: after, value: currency))"
        } else {
            after = currency
        }
        
        let before = String(array[0])
        return amountToWord(amount: before, value: after)
    }
    
    static func amountToWord(amount: String, value: String = "") -> String {
        var amount = amount
        let count = amount.count
        if count < 3 {
            amount = "0\(amount)"
            return amountToWord(amount: amount, value: value)
        } else if count > 3 {
            var head = count % 3
            if head == 0 {
                head = 3
            }
            let newValue = amountWords[((((count - head) % 9 ) / 3) + 2) % 3]
            return "\(amountToWord(amount: String(amount.prefix(head)), value: newValue)) \(amountToWord(amount: String(amount.suffix(count - head)), value: value))"
        }
        let characters = Array(amount)
        var word = ""
        let hundreds = AmountToWord(rawValue: String(characters[0])) ?? .zero
        word += hundreds.value3
        let ties = AmountToWord(rawValue: String(characters[1])) ?? .zero
        let unit = AmountToWord(rawValue: String(characters[2])) ?? .zero
        word += "\(ties.getValue2(hundreds: hundreds, unit: unit))"
        word += "\(unit.getValue(ties: ties))"
        return "\(word)\(value)"
    }
    
    static let amountWords: [String] = ["nghìn", "triệu", "tỷ"]

    static func formatCurrency(money: String) -> String {
        var last = ""
        var mon = MoneyUtils.fomart(money: money)
        if !(money.last?.isNumber ?? true) {
            last = String(money.last!)
            mon.removeLast()
        }

        let value: Double = Double("\(mon.replacingOccurrences(of: ",", with: "."))") ?? 0
        let formatter = NumberFormatter()
        formatter.groupingSeparator = MoneyUtils.digitUnit
        formatter.numberStyle = .decimal
        return "\(formatter.string(for: value) ?? "")\(last)"
    }
    static func validInput(_ data: String?, replacementString string: String, range: NSRange) -> Bool {
        var indexDecimalSeparator: Int?
        var newVal = data ?? ""
        if string != "" {
            newVal.insert(Character(string), at: newVal.index(newVal.startIndex, offsetBy: range.location))
        }
        let arr = newVal.split(separator: Character(MoneyUtils.decimalSeparator))
        if let index = Array(data ?? "").firstIndex(where: { (char) -> Bool in
                return char == MoneyUtils.decimalSeparator.first
            }) {
            indexDecimalSeparator = index
        }
        if indexDecimalSeparator != nil && (data?.count ?? 0) >= (indexDecimalSeparator! + 3) && string != "" && arr.last?.count ?? 0 > 2 {
            return false
            // khong che 2 chu so thap phan
        }
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        if Int(string) == nil && string != "" {
            return false
        }
        return true
    }
}

enum AmountToWord: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    var value1: String {
        switch self {
        case .zero:
            return ""
        case .one:
            return "một "
        case .two:
            return "hai "
        case .three:
            return "ba "
        case .four:
            return "bốn "
        case .five:
            return "năm "
        case .six:
            return "sáu "
        case .seven:
            return "bảy "
        case .eight:
            return "tám "
        case .nine:
            return "chín "
        }
    }
    
    var value11: String {
        self == .five ? "lăm " : self.value1
    }
    
    var value12: String {
        switch self {
        case .one:
            return "mốt "
        case .four:
            return "tư "
        default:
            return self.value11
        }
    }
    
    var value2: String {
        switch self {
        case .zero:
            return ""
        case .one:
            return "mười "
        default:
            return "\(self.value1)mươi "
        }
    }
    
    var value21: String {
        self == .zero ? "linh " : self.value2
    }
    
    var value3: String {
        self == .zero ? "" : "\(self.value1)trăm "
    }
    
    func getValue2(hundreds: AmountToWord, unit: AmountToWord) -> String {
        if hundreds != .zero && unit != .zero {
            return self.value21
        }
        return self.value2
    }
    
    func getValue(ties: AmountToWord) -> String {
        switch ties {
        case .zero:
            return self.value1
        case .one:
            return self.value11
        default:
            return self.value12
        }
    }
}
