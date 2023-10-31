//
//  String+Extensions.swift
//  Utility
//
//  Created by eren  on 31/10/2023.
//

import Foundation

extension String {
    public func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }

    public var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    public var removingUnderscore: String {
        return self.replacingOccurrences(of: "_", with: " ")
    }
}
