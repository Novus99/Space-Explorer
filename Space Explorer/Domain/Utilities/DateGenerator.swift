//
//  DateGenerator.swift
//  Space Explorer
//
//  Created by Novus on 14/12/2025.
//

protocol DateGenerator {
    func randomDateString() -> String
    func todayDateString() -> String
    func todayMinus29DaysDateString() -> String
}
