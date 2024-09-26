//
//  ChildList.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import SwiftUI
import SwiftData

struct ChildrenList: View {
	let selectedParent: ParentItem
	
	@Binding private var selection: ChildItem?
	@Environment(\.modelContext) private var modelContext
	@Environment(\.undoManager) private var undoManager
	@Query(animation: .default) private var children: [ChildItem]
	
	init(parent: ParentItem, selectedChild: Binding<ChildItem?>) {
		self.selectedParent = parent
		self._selection = selectedChild
		
		let selectedParentId = parent.id
		let predicate = #Predicate<ChildItem> {
			$0.parent?.id == selectedParentId
		}
		self._children = Query(filter: predicate, animation: .default)
	}
	
	var body: some View {
		List(selection: $selection) {
			ForEach(children) { item in
				Text("Child at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
					.tag(item)
			}
			.onDelete(perform: deleteItems)
		}
		.toolbar {
			ToolbarItem(placement: .navigation) {
				Button(action: addItem) {
					Label("Add Item", systemImage: "plus")
				}
			}
		}
	}
	
	private func addItem() {
		undoManager?.beginUndoGrouping()
		
		let newItem = ChildItem(timestamp: Date())
		newItem.parent = selectedParent
		modelContext.insert(newItem)
		
		try? modelContext.save()
		
		undoManager?.endUndoGrouping()
	}
	
	private func deleteItems(offsets: IndexSet) {
		undoManager?.beginUndoGrouping()
		
		for index in offsets {
			modelContext.delete(children[index])
		}
		
		try? modelContext.save()
		
		undoManager?.endUndoGrouping()
	}
}
