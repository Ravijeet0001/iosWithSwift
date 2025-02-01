//
//  AddNoteView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                    }
                }
            }
        }
    }

    private func saveNote() {
        CoreDataManager.shared.createNote(title: title, content: content)
        presentationMode.wrappedValue.dismiss()
    }
}
