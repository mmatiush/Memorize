//
//  Array+Only.swift
//  Memorize
//
//  Created by Max Matiushchenko on 19.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation

extension Array {
	var only: Element? {
		count == 1 ? first : nil
	}
}
