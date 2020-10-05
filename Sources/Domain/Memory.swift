//
//  Memory.swift
//  Pequod
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Memory {
	var acnt: UUID
	var name: String
	var value: String
	var vers: Int
	var fork: Int
	var born: Int
	var gone: Int?
	
	init (acnt: UUID, name: String, value: String, vers: Int, fork: Int, born: Int, gone: Int?) {
		self.acnt = acnt
		self.name = name
		self.value = value
		self.vers = vers
		self.fork = fork
		self.born = born
		self.gone = gone
	}
}
