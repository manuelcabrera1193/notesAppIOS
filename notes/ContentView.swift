//
//  ContentView.swift
//  notes
//
//  Created by Willard Cabrera on 8/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(notes) { item in
                    NavigationLink(value: item) {
                        HStack {
                            let color = switch(item.level) {
                            case 1: Color.green
                            case 2: Color.yellow
                            case 3: Color.red
                            default : Color.green
                                
                            }
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(color)
                            Text("\(item.name)")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
                
            }
            .navigationDestination(for: Note.self, destination: { note in
                NoteView(isNew: false, note: note)
            })
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    let note = Note(name: "", level: 1)
                    NavigationLink(
                        destination: {  NoteView(isNew: true, note: note)}
                    ) {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            print(notes)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
    
    
    private func moveItems(offsets: IndexSet, index: Int) {
        withAnimation {
            for index in offsets {
                print("index >\(index)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Note.self, Metadata.self], inMemory: true)
}
