//
//  DateGeneratorImpl.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//
import Foundation

struct DateGeneratorImpl: DateGenerator {
    
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func randomDateString() -> String {
        let start = Self.calendar.date(from: DateComponents(year: 1995, month: 6, day: 16))!
        let end = Date()
        
        let days = Self.calendar.dateComponents([.day], from: start, to: end).day ?? 0
        let randomOffset = Int.random(in: 0...max(days, 0))
        let randomDate = Self.calendar.date(byAdding: .day, value: randomOffset, to: start)!
        
        return Self.formatter.string(from: randomDate)
    }
    
    func todayDateString() -> String {
        Self.formatter.string(from: Date())
    }
    
    func todayMinus29DaysDateString() -> String {
        let today = Date()
        let date = Self.calendar.date(byAdding: .day, value: -29, to: today) ?? today
        return Self.formatter.string(from: date)
    }
}
