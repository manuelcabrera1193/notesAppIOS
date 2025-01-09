//
//  Item.swift
//  notes
//
//  Created by Willard Cabrera on 8/01/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
