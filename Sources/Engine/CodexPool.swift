//
//  CodexPool.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectMySQL

public class CodexPool {
	private let name: String
	private let persist: Persist
	private var devices: NSCache<NSString, Device>
	private var codices: NSCache<NSString, Codex>
	
	init(name: String) {
		self.name = name
		persist = MySQLPersist(name: name)
		devices = NSCache()
		codices = NSCache()
	}
	
	// Ignition ====================================================================================
	func account(acnt: UUID) -> Account? {
		return persist.account(acnt: acnt)
	}
	func account(token: String) -> Account? {
		return persist.account(token: token)
	}
	func account(user: String) -> Account?  {
		persist.account(user: user)
	}
	func account(otid: String) -> Account? {
		persist.account(otid: otid)
	}
	func device(token: String) -> Device? {
		return persist.device(token: token)
	}
	
	// Codex =======================================================================================
	func createCodex(otid: String, expires: Date) -> Codex {
		let codex: Codex = Codex(name: name, otid: otid, expires: expires)
		codices.setObject(codex, forKey: codex.account.acnt.uuidString as NSString)
		return codex
	}
	func codex(acnt: UUID) -> Codex {
		return codices.object(forKey: NSString(string: acnt.uuidString)) ?? {
			let codex = Codex(name: name, acnt: acnt)
			codices.setObject(codex, forKey: acnt.uuidString as NSString)
			return codex
		}()
	}
	func codex(otid: String) -> Codex? {
		guard let account = persist.account(otid: otid) else { return nil }
		return codex(acnt: account.acnt)
	}
	func forget(codex: Codex, device: Device) {
		codices.removeObject(forKey: codex.account.acnt.uuidString as NSString)
		devices.removeObject(forKey: device.token as NSString)
	}
	
// Static ==========================================================================================
	static let pool = CodexPool(name: "pequod")

	// Ignition
	static func account(acnt: UUID) -> Account? {
		return pool.account(acnt: acnt)
	}
	static func account(token: String) -> Account? {
		return pool.account(token: token)
	}
	static func account(user: String) -> Account? {
		return pool.account(user: user)
	}
	static func account(otid: String) -> Account? {
		return pool.account(otid: otid)
	}
	static func device(token: String) -> Device? {
		return pool.device(token: token)
	}

	// Codex
	static func createCodex(otid: String, expires: Date) -> Codex {
		return pool.createCodex(otid: otid, expires: expires)
	}
	static func codex(acnt: UUID) -> Codex {
		return pool.codex(acnt: acnt)
	}
	static func codex(otid: String) -> Codex? {
		return pool.codex(otid: otid)
	}
	static func forget(codex: Codex, device: Device) {
		return pool.forget(codex: codex, device: device)
	}
}
