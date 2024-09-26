//
//  ContentView.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Environment(\.undoManager) private var undoManager
    @Query private var items: [ParentItem]
	
	@State private var selectedParent: ParentItem?
	@State private var selectedChild: ChildItem?

    var body: some View {
        NavigationSplitView {
			ParentList(selection: $selectedParent)
				.navigationSplitViewColumnWidth(min: 180, ideal: 200)
		} content: {
			if let selectedParent {
				ChildrenList(parent: selectedParent, selectedChild: $selectedChild)
			} else {
				// no selection
				Text("No Parent Selected")
			}
		} detail: {
            Text("Select an item")
        }
		// instantiating UndoManager
		.onChange(of: undoManager, initial: true) {
			modelContext.undoManager = undoManager
		}
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ParentItem.self, inMemory: true)
}
