//
//  NoteDetailView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    @State private var title: String
    @State private var content: String
    var note: Note

    init(note: Note) {
        self.note = note
        _title = State(initialValue: note.title ?? "")
        _content = State(initialValue: note.content ?? "")
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextEditor(text: $content)
                .frame(height: 200)
        }
        .navigationTitle("Edit Note")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    updateNote()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Delete") {
                    deleteNote()
                }
                .foregroundColor(.red)
            }
        }
    }

    private func updateNote() {
        note.title = title
        note.content = content
        CoreDataManager.shared.saveContext()
        presentationMode.wrappedValue.dismiss()
    }

    private func deleteNote() {
        CoreDataManager.shared.deleteNote(note)
        presentationMode.wrappedValue.dismiss()
    }
}
