//
//  String+Shortcuts.swift
//  TikAssignment
//
//  Created by Cuong Nguyen on 10/5/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import Foundation

extension String { 
    public func standardizedWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
