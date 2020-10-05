//
//  Rollback.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Rollback: Command {
	init () {
		super.init(method: .post, path: "/rollback")
	}
	
// Commamnd ========================================================================================
	override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		let sb: String = "[rollback] fork \(account.fork+1) rolledback"
		defer {Log.print(sb)}

		codex.holdVellums = []
		codex.holdDeleted = []
		codex.holdMemories = []
		
		return [:]
	}
}
