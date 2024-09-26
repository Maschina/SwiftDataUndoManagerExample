//
//  DateFormatter+Extensions.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import Foundation

extension DateFormatter {
    static func date(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.date(from: string)
    }
}
