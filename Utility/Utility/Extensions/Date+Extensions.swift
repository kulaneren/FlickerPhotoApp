//
//  Date+Extensions.swift
//  Utility
//
//  Created by eren  on 31/10/2023.
//

import Foundation

extension Date {

    //2023-10-29T07:03:42Z
    public init(flpServiceStyle: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: flpServiceStyle) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    public func showAsStandartFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
}
