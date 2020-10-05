//
//  Memory.swift
//  Pequod
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Memory {
	public var acnt: UUID
	public var name: String
	public var value: String
	public var vers: Int
	public var fork: Int
	public var born: Int
	public var gone: Int?
	
	public init (acnt: UUID, name: String, value: String, vers: Int, fork: Int, born: Int, gone: Int?) {
		self.acnt = acnt
		self.name = name
		self.value = value
		self.vers = vers
		self.fork = fork
		self.born = born
		self.gone = gone
	}
}
