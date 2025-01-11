//
//  NoteView.swift
//  notes
//
//  Created by Willard Cabrera on 11/01/25.
//

import SwiftUI

struct NoteView: View {
    
    let isNew: Bool
    @Bindable var note: Note
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            if !isNew {
                Text("* It will update automatically when you modify the note")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding()
            }
            Text("Note:")
            
            TextEditor(text: $note.name).padding(.horizontal)
                .frame(maxWidth: 400, maxHeight: .infinity, alignment: Alignment.center)
                .textContentType(.name)
                .background()
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            Spacer()
            HStack(
                alignment: VerticalAlignment.center
            ) {
                Menu {
                    Button("Low") {
                        $note.wrappedValue.level = 3
                    }
                    Button("Medium") {
                        $note.wrappedValue.level = 2
                    }
                    
                    Button("High") {
                        $note.wrappedValue.level = 1
                    }
                } label: {
                    Image(systemName: "trash")
                    Text("Note Level")
                }
                .padding()
                .menuStyle(.borderlessButton)
                
                Spacer()
                
                let levelDescription = switch note.level {
                case 1: Text("High")
                case 2: Text("Medium")
                case 3: Text("Low")
                default : Text("Unknown")
                }
                
                HStack {
                    let color = switch(note.level) {
                    case 1: Color.green
                    case 2: Color.yellow
                    case 3: Color.red
                    default : Color.green
                        
                    }
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(color)
                    levelDescription
                        .padding()
                }
            }
            Spacer()
            Text("id: \(note.metadata.identifier)")
            Text("Date Created: \(note.metadata.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.center)
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(isNew ? "New Note" : "Edit Note")
        .disableAutocorrection(true)
        .textInputAutocapitalization(.sentences)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                if isNew && !note.name.isEmpty {
                    Button("Save") {
                        withAnimation {
                            modelContext.insert(note)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            ToolbarItem(placement: .bottomBar) {
                if !isNew {
                    Button("Delete") {
                        withAnimation {
                            modelContext.delete(note)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
}
