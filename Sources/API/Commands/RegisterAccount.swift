//
//  RegisterAccount.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/13/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

class RegisterAccount: Command {
	init() {
		super.init(method: .post, path: "/registerAccount")
	}
	
// Command =========================================================================================
	override func execute(params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String : Any] {
		var sb: String = "[registerAccount]"
		defer {Log.print(sb)}
		
		guard	let user: String = attributes["user"] as? String,
				let email: String = attributes["email"] as? String
			else {return [:]}

		account.user = user
		account.email = email

		codex.store(account: account)

		sb += " user: \(account.user!), email: \(account.email!)"

		return [:]
	}
}
