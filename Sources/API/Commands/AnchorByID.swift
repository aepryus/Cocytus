//
//  AnchorByID.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectHTTP

class AnchorByID: Command {
	init () {
		super.init(method: .post, path: "/anchorByID")
	}
	
// Command =========================================================================================
	override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		var sb: String = "[anchorByID]"
		defer {Log.print(sb)}
		
		let iden = UUID(uuidString: params["iden"]!)!
		sb += " iden = \(iden)"
		guard let vellum = codex.selectByID(iden) else {
			sb += " : document NOT found"
			return [:]
		}
		sb += " : document found"
		return vellum.attributes
	}
}
