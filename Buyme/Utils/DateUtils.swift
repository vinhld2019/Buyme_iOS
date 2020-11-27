//
//  DateUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2020-02-18.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

enum VDateFormat: String {
    case dash           = "-"
    case day            = "d"
    case dayD           = "dd"
    case hour           = "H"
    case hourH          = "HH"
    case month          = "M"
    case monthM         = "MM"
    case monthMM        = "MMM"
    case minute         = "m"
    case minuteM        = "mm"
    case second         = "s"
    case secondS        = "ss"
    case slash          = "/"
    case space          = " "
    case year           = "yyyy"
    
    static func createDateFormat(_ src: [VDateFormat]) -> String {
        var string = ""
        for format in src {
            string += format.rawValue
        }
        return string
    }
    
    static var yyyyMMddWithDash: String { Self.createDateFormat([.year, .dash, .monthM, .dash, .dayD]) }
    static var ddMMyyyyWithDash: String { Self.createDateFormat([.dayD, .dash, .monthM, .dash, .year]) }
    static var yyyyMMddWithSlash: String { Self.createDateFormat([.year, .slash, .monthM, .slash, .dayD]) }
    static var ddMMyyyyWithSlash: String { Self.createDateFormat([.dayD, .slash, .monthM, .slash, .year]) }
}

extension DateFormatter {
    
    static var shared: DateFormatter { DateFormatter() }
    
    func initDateWith(format: String, string: String, locale: Locale? = nil) -> Date? {
        
        dateFormat = format
        self.locale = locale
        
        return date(from: string)
    }
}

extension Date {
    
    static let kDayTimeStamp: Int64 = 24 * 60 * 60 * 1000
    static var currentDateInSeconds: Int64 { Date().dateInSeconds }
    static var currentTimeInSeconds: Int64 { return Date().timeInSeconds }
    
    init?(format: String, string: String, locale: Locale? = nil) {
        self.init()
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        if locale != nil {
            dateFormatter.locale = locale
        } else {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        
        if let date = dateFormatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
    
    init?(timestamp: Int64) {
        self.init(timeInSecond: timestamp / 1000)
    }
    
    init?(timeInSecond: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timeInSecond))
    }
    
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: LocalizedUtils.shared.current ?? "en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var dateInSeconds: Int64 {
        let date = self
        let stringDate = "\(date.yearString)-\(date.mothString)-\(date.dayString)"
        return DateFormatter.shared.initDateWith(format: VDateFormat.yyyyMMddWithDash,
                                                 string: stringDate)?.timeInSeconds
            ?? date.timeInSeconds
    }
    
    var timeInSeconds: Int64 { Int64(timeIntervalSince1970) }
    
    var timeStamp: Int64 { timeInSeconds * 1000 }
    
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var yearString: String {
        "\(self.year)"
    }
    
    var moth: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var mothString: String {
        let string = "\(self.moth)"
        return string.count == 1 ? "0\(string)" : string
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var dayString: String {
        let string = "\(self.day)"
        return string.count == 1 ? "0\(string)" : string
    }
}

extension Int64 {
    var date: Date? {
        Date(timeInSecond: self)
    }
}
