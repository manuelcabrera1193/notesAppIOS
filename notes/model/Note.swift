//
//  Item.swift
//  notes
//
//  Created by Willard Cabrera on 8/01/25.
//

import Foundation
import SwiftData
import BackgroundTasks

@Model
final class Note {
        
    var name: String
    var level: Int
    @Relationship(deleteRule: .cascade) var metadata: Metadata
    
    @Transient var label: String  {
        name + " (\(level))"
    }
    
    init(name: String, level: Int) {
        self.name = name
        self.level = level
        self.metadata = Metadata()
    }
}


@Model
class Metadata {
    @Attribute(.unique) var identifier: UUID
    var timestamp: Date
    
    init() {
        self.identifier = UUID()
        self.timestamp = Date()
    }
}
