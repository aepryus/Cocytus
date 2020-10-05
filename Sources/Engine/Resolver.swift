//
//  Resolver.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

open class Resolver {
	var type: String
	var only: String?

	init (type: String) {
		self.type = type
	}
	
	func resolve (old: [String:Any], new: [String:Any], uncommitted: Bool) -> [String:Any] {
		return new
	}
}
