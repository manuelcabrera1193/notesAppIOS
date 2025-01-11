//
//  notesApp.swift
//  notes
//
//  Created by Willard Cabrera on 8/01/25.
//

import SwiftUI
import SwiftData

@main
struct notesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Note.self, Metadata.self], inMemory: true)
    }
}
