//
//  Item.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import Foundation
import SwiftData

@Model
final class ParentItem: Identifiable {
	@Attribute(.unique) var id: UUID
	
	var timestamp: Date
	
	@Relationship(deleteRule: .cascade, inverse: \ChildItem.parent)
	var children: [ChildItem] = []
	
	init(id: UUID = UUID(), timestamp: Date = Date()) {
		self.id = id
		self.timestamp = timestamp
	}
}
