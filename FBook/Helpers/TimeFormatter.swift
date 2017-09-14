//
//  TimeFormatter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class TimeFormatter: DateFormatter {

    static let `default`: TimeFormatter = {
        let timeFormatter = TimeFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        return timeFormatter
    }()

    func string(from date: Date, outputFormat format: String) -> String? {
        dateFormat = format
        return string(from: date)
    }

    func string(from string: String, inputFormat: String, outputFormat: String) -> String? {
        dateFormat = inputFormat
        guard let date = self.date(from: string) else {
            return nil
        }
        return self.string(from: date, outputFormat: outputFormat)
    }

    func date(from string: String, format: String) -> Date {
        dateFormat = format
        return date(from: string) ?? Date()
    }

}
