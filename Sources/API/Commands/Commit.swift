//
//  Commit.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public class Commit: Command {
	public init () {
		super.init(method: .post, path: "/commit")
	}
	
// Command =========================================================================================
	public override func execute (params: [String:String], attributes: [String:Any], device: Device, account: Account, codex: Codex) -> [String:Any] {
		var sb: String = "[commit]"
		defer {Log.print(sb)}
		
		guard codex.hasHolds else {
			sb += " codex has nothing on hold"
			return [:]
		}
		if codex.holdVellums.count > 0 {
			codex.transact(vellums: codex.holdVellums, memories: codex.holdMemories)
			account.fork += 1
			if account.token != device.token {
				account.token = device.token
				account.since = account.fork
			}
			
			let isoFormatter = DateFormatter()
			isoFormatter.locale = Locale(identifier: "en_US_POSIX")
			isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
			
			device.fork = account.fork
			device.synced = isoFormatter.string(from: Date())
			
			codex.store(account: account, device: device)
			
			sb += " fork \(account.fork) committed"

		} else {
			sb += " no hold vellums found"
		}
		
		var echo = [String:Any]()
		echo["fork"] = account.fork
		return echo
	}
}
