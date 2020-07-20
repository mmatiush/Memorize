//
//  Grid.swift
//  Memorize
//
//  Created by Max Matiushchenko on 16.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
	
	var items: [Item]
	var viewForItem: (Item) -> ItemView
	
	init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
		self.items = items
		self.viewForItem = viewForItem
	}
	
	//    var body: some View {
	//		GeometryReader { geometry in
	//			ForEach(self.items) { item in
	//				self.viewForItem(GridLayout(itemCount: self.items.count, in: geometry.size))
	//			}
	//		}
	//    }
	
	var body: some View {
		GeometryReader { geometry in
			self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
		}
	}
	
	func body(for layout: GridLayout) -> some View {
		ForEach(self.items) { item in
			self.body(for: item, in: layout)
		}
	}
	
	func body(for item: Item, in layout: GridLayout) -> some View {
		let index = items.FirstIndex(matching: item)!
		return viewForItem(item)
			.frame(width: layout.itemSize.width, height: layout.itemSize.height)
			.position(layout.location(ofItemAt: index))
	}
}
