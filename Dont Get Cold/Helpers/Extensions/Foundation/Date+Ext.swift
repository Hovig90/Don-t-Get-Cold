//
//  Date+Ext.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/25/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

extension Date {
    
    enum DateFormatStyle: String {
        case fullDay = "EEEE, dd"
        case weekdayShort = "EEE"
        case weekdayPlusFullDate = "EEEE, dd MMM yy"
        case fullDateTime = "yyyy/MM/dd HH:mm:ss"
        case regularDate = "yyyy/MM/dd"
        case regularDateHour = "yyyy/MM/dd HH"
        case day = "dd"
        case hour = "HH"
        case minute = "mm"
        case timeLong = "HH:mm:ss"
        case timeShort = "HH:mm"
        case yearMonth = "yyyy/MM"
    }
    
    init(withUNIXDate unix: Double) {
        self = Date(timeIntervalSince1970: unix)
    }
    
    func convertDateToString(withFormatterStyle style: DateFormatter.Style, timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func convertDateToString(withFormatterStyle style: DateFormatStyle, timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.string(from: self)
    }
    
    func compare(toDate: Date, withFormat format: DateFormatStyle = .fullDay) -> Bool {//Add Comparison
        let date = self.convertDateToString(withFormatterStyle: format)
        let toDate = toDate.convertDateToString(withFormatterStyle: format)
        if date == toDate {
            return true
        }
        return false
    }
}
