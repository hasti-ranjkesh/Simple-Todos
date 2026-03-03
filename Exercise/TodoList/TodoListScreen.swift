//
//  TodoListScreen.swift
//  Exercise
//
//  Created by Hasti on 27/02/2026.
//

import SwiftUI

/// A screen that renders the current list of todo items and status-specific actions.
/// The screen observes a ``TodoListViewModel`` and updates automatically whenever the underlying items change.

struct TodoListScreen: View {
    /// The observable source of truth for todo items and list actions.
    @ObservedObject var viewModel: TodoListViewModel
    
    /// The content and behavior of the todo list screen.
    ///
    /// Displays each item's title, applies a status-based text color, and shows:
    /// - A progress indicator while an item is saving.
    /// - A delete action after an item has been saved.
    /// - No trailing action when saving failed.
    
    var body: some View {
        List {
            ForEach(viewModel.items, id: \.id) { item in
                HStack(spacing: 16) {
                    Text(item.title)
                        .foregroundStyle(textColor(for: item.status))
                    
                    Spacer()
                    
                    switch item.status {
                    case .saving:
                        ProgressView()
                    case .saved:
                        Button {
                            viewModel.deleteTask(id: item.id)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.primary)
                        }
                    case .failed:
                        EmptyView()
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    /// Returns the text color associated with a todo item's persistence status.
    ///
    /// - Parameter status: The current status of a todo item.
    /// - Returns: `.primary` for `.saving` and `.saved`; `.red` for `.failed`.
    private func textColor(for status: TodoItemStatus) -> Color {
        switch status {
        case .saving, .saved:
            return .primary
        case .failed:
            return .red
        }
    }
}

