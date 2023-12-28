//
//  Date+Extension.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 28/12/23.
//

import Foundation

extension Date {
    static func combine(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var newComponents = DateComponents()
        newComponents.timeZone = .current
        newComponents.day = dateComponents.day
        newComponents.month = dateComponents.month
        newComponents.year = dateComponents.year
        newComponents.hour = timeComponents.hour
        newComponents.minute = timeComponents.minute
        newComponents.second = timeComponents.second
        
        return calendar.date(from: newComponents)
    }
}
