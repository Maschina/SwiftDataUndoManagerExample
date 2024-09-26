//
//  SiblingItem.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import Foundation
import SwiftData

@Model
final class ChildItem: Identifiable {
	@Attribute(.unique) var id: UUID
	
	var timestamp: Date
	
	var parent: ParentItem?
	
	init(id: UUID = UUID(), timestamp: Date = Date()) {
		self.id = id
		self.timestamp = timestamp
	}
}
