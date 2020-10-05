//
//  Device.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Device {
	public var token: String
	public var acnt: UUID
	public var tag: String
	public var fork: Int
	public var synced: String?
	
	public init (token: String, acnt: UUID, tag: String, fork: Int, synced: String?) {
		self.token = token
		self.acnt = acnt
		self.tag = tag
		self.fork = fork
		self.synced = synced
	}
}
