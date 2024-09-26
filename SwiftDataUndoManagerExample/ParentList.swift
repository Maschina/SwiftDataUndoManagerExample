//
//  ParentList.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 20.09.24.
//

import SwiftUI
import SwiftData

struct ParentList: View {
	@Binding var selection: ParentItem?
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.undoManager) private var undoManager
	@Query private var items: [ParentItem]
	
	var body: some View {
		List(selection: $selection) {
			ForEach(items) { item in
				Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
					.tag(item)
			}
			.onDelete(perform: deleteItems)
		}
		.toolbar {
			ToolbarItem {
				Button(action: addItem) {
					Label("Add Item", systemImage: "plus")
				}
			}
		}
	}
	
	private func addItem() {
		undoManager?.beginUndoGrouping()
		
		let newItem = ParentItem(timestamp: Date())
		modelContext.insert(newItem)
		
		try? modelContext.save()
		
		undoManager?.endUndoGrouping()
	}
	
	private func deleteItems(offsets: IndexSet) {
		undoManager?.beginUndoGrouping()
		
		for index in offsets {
			modelContext.delete(items[index])
		}
		
		try? modelContext.save()
		
		undoManager?.endUndoGrouping()
	}
}

