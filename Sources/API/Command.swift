//
//  Command.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/12/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectHTTP

open class Command: Radical {
	func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		return [:]
	}
	
// Radical =========================================================================================
	public final override func execute (request: HTTPRequest, response: HTTPResponse) -> [String:Any] {
		var params = [String:String]()
		for (a,b) in request.params() {
			params[a] = b
		}
		
		guard let body: String = request.postBodyString else {return [:]}
		
		let attributes: [String:Any] = body.toAttributes()
		
		guard	let token: String = attributes["token"] as? String,
				let device: Device = CodexPool.device(token: token),
				let account: Account = CodexPool.account(acnt: device.acnt)
			else {return [:]}
		
		let codex: Codex = CodexPool.codex(acnt: account.acnt)
		
		return execute(params: params, attributes: attributes, device: device, account: account, codex: codex)
	}
}
