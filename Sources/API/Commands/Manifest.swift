//
//  Manifest.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Manifest: Command {
	init () {
		super.init(method: .post, path: "/manifest")
	}

// Command =========================================================================================
	override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		var sb: String = "[manifest]"
		defer {Log.print(sb)}

		var attributes = [String:Any]()
		
		let idens = codex.listAllIdens()
		attributes["idens"] = idens
		
		sb += " \(idens.count) idens returned"

		return attributes
	}
}
