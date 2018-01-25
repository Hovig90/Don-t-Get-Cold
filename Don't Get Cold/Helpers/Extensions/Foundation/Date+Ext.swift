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
        case weekDayPlusFullDate = "EEEE, dd MMM yy"
        case fullDateTime = "yyyy/MM/dd HH:mm:ss"
        case regularDate = "yyyy/MM/dd"
        case regularDateHour = "yyyy/MM/dd HH"
        case day = "dd"
        case hour = "HH"
        case time = "HH:mm:ss"
        case yearMonth = "yyyy/MM"
    }
    
    init(withUNIXDate unix: Double) {
        self = Date(timeIntervalSince1970: unix)
    }
    
    func convertDateToString(withFormatterStyle style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func convertDateToString(withFormatterStyle style: DateFormatStyle) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style.rawValue
        return dateFormatter.string(from: self)
    }
}
