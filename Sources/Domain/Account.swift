//
//  Account.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Account {
	var acnt: UUID
	var otid: String
	var expires: Date
	var user: String?
	var email: String?
	var name: String?
	var fork: Int
	var token: String
	var since: Int
	
	public init (acnt: UUID, otid: String, expires: Date, user: String? = nil, email: String? = nil, name: String? = nil, fork: Int, token: String, since: Int) {
		self.acnt = acnt
		self.otid = otid
		self.expires = expires
		self.user = user
		self.email = email
		self.name = name
		self.fork = fork
		self.token = token
		self.since = since
	}
}
