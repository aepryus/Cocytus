//
//  Device.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

class Device {
	var token: String
	var acnt: UUID
	var tag: String
	var fork: Int
	var synced: String?
	
	init (token: String, acnt: UUID, tag: String, fork: Int, synced: String?) {
		self.token = token
		self.acnt = acnt
		self.tag = tag
		self.fork = fork
		self.synced = synced
	}
}
