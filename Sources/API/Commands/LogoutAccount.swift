//
//  LogoutAccount.swift
//  Cocytus
//
//  Created by Joe Charlier on 3/6/18.
//  Copyright © 2018 Aepryus Software. All rights reserved.
//

import Foundation

class LogoutAccount: Command {
	init () {
		super.init(method: .post, path: "/logoutAccount")
	}
	
// Command =========================================================================================
	override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		var sb: String = "[logout]"
		defer {Log.print(sb)}
		
		if let email = account.email { sb += " email: \(email)" }
		codex.deleteDevice(device: device)
		CodexPool.forget(codex: codex, device: device)
		
		return [:]
	}
}
