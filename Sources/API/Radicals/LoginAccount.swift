//
//  LoginAccount.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/13/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectHTTP

class LoginAccount: Radical {
	init() {
		super.init(method: .post, path: "/loginAccount")
	}
	
// Radical =========================================================================================
	override func execute (request: HTTPRequest, response: HTTPResponse) -> [String:Any] {
		var sb: String = "[loginAccount]"
		let sbe: String? = nil
		defer {
			Log.print(sb)
			if let sbe = sbe { Log.print(sbe) }
		}

		guard	let attributes: [String:Any] = request.postBodyString?.toAttributes(),
				let tag: String = attributes["tag"] as? String
		else { return [:] }
		
		var a: Account? = nil
		let otidLogin: Bool
		
		if let otid = attributes["otid"] as? String {
			a = CodexPool.account(otid: otid)
			otidLogin = true
			sb += "  otid: \(otid),"
		} else if let user = attributes["user"] as? String {
			a = CodexPool.account(user: user)
			otidLogin = false
			sb += " user: \(user),"
		} else { return [:] }
		
		guard let account = a else { return [:] }
		
		let codex: Codex = CodexPool.codex(acnt: account.acnt)
		let device: Device = codex.createDevice(tag: tag)

		sb += " token: \(device.token), acnt: \(codex.account.acnt)"
		
		if otidLogin, let user = attributes["user"] as? String {
			if let oldUser = account.user {
				sb += ", user changed from: \(oldUser) to: \(user)"
			} else {
				sb += ", user registered: \(user)"
			}
			account.user = user
			account.email = attributes["email"] as? String
			codex.store(account: account)
		} else {
			sb += ", email: \(codex.account.email ?? "N/A")"
		}
			
		var result: [String:Any] = [:]
		result["otid"] = account.otid
		result["expires"] = account.expires.toISOFormattedString()
		result["expired"] = Date.now > account.expires
		result["user"] = account.user
		result["token"] = device.token
		return result
	}
}
