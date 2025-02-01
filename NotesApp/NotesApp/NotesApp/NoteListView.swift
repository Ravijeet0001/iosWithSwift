//
//  NoteListView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI
import CoreData

struct NoteListView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.dateCreated, ascending: false)]
    ) private var notes: FetchedResults<Note>

    @State private var isAddingNote = false

    var body: some View {
        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "Untitled")
                                .font(.headline)
                            
                            Text(note.content ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                            
                            if let date = note.dateCreated {
                                Text(formatDate(date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingNote = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNote) {
                AddNoteView()
            }
        }
    }

    private func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let note = notes[index]
            CoreDataManager.shared.deleteNote(note)
        }
    }

    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
