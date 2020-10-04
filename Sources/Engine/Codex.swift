//
//  Codex.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Dispatch
import Foundation

class Codex {
	var persist: Persist
	var account: Account
	
	let queue: DispatchQueue

	var cache = [UUID:Vellum]()
	var holdVellums: [Vellum] = []
	var holdDeleted: [Vellum] = []
	var holdMemories: [Memory] = []
	
	var hasHolds: Bool {
		return holdVellums.count + holdDeleted.count + holdMemories.count > 0
	}

	var busy: Bool = false
	
	init(name: String, otid: String, expires: Date) {
		queue = DispatchQueue(label: name)
		let acnt: UUID = UUID()
		persist = MySQLPersist(name: name, acnt: acnt)
		account = Account(acnt: acnt, otid: otid, expires: expires, fork: 0, token: "", since: 0)
		persist.store(account: account)
	}
	init(name: String, acnt: UUID) {
		queue = DispatchQueue(label: name)
		persist = MySQLPersist(name: name, acnt: acnt)
		account = persist.account(acnt: acnt)!
	}
	init(name: String, token: String) {
		queue = DispatchQueue(label: name)
		persist = MySQLPersist(name: name)
		account = persist.account(token: token)!
	}
	
	// Account =====================================================================================
	func store (account: Account) {
		self.account = account
		self.persist.store(account: account)
	}
	func store (account: Account, device: Device) {
		self.account = account
		self.persist.store(account: account)
		self.persist.store(device: device)
	}
	
	// Device ======================================================================================
	func createDevice(tag: String) -> Device {
		let token = String.randomString(length: 36)
		let device = Device(token: token, acnt: account.acnt, tag: tag, fork: 0, synced: nil)
		self.persist.store(device: device)
		return device
	}
	func deleteDevice(device: Device) {
		self.persist.delete(device: device)
	}
	
	func createToken (tag: String) -> String {
		let token = String.randomString(length: 36)
		persist.transact { () -> (Bool) in
			self.persist.store(device: Device(token: token, acnt: self.account.acnt, tag: tag, fork: 0, synced: nil))
			return true
		}
		return token
	}
	
	// Memory ======================================================================================
	func memory (name: String) -> Memory? {
		return self.persist.memory(name: name)
	}
	
	// Vellums =====================================================================================
	func selectByID (_ iden: UUID) -> Vellum? {
		return cache[iden] ?? {
			guard let vellum = persist.vellum(iden: iden)
				else {return nil}
			cache[vellum.iden] = vellum
			return vellum
		}()
	}
	func selectBy (type: String, only: String) -> Vellum? {
		return persist.vellum(type: type, only: only)
	}
	
	func listAllIdens () -> [String] {
		return persist.listAllIdens()
	}

	func echoPacket (_ from: Int) -> [[String:Any]] {
		var scratch = [UUID:[String:Any]]()

		for vellum in holdVellums {
			scratch[vellum.iden] = vellum.attributes
		}

		let idens: [UUID] = persist.echo(from)
		for iden in idens {
			guard scratch[iden] == nil else {continue}
			if let vellum = cache[iden] {
				scratch[iden] = vellum.attributes
			} else {
				scratch[iden] = persist.vellum(iden: iden)?.attributes
			}
		}

		var result = [[String:Any]]()
		for attributes in scratch.values {
			result.append(attributes)
		}
		return result
	}
	
	var semaphore = DispatchSemaphore(value: 1)
	private func lock () {
		semaphore.wait()
	}
	private func unlock () {
		semaphore.signal()
	}
	func transact (vellums: [Vellum], memories: [Memory]) {
		queue.sync {
			persist.transact { () -> (Bool) in
				for vellum in vellums {
					persist.store(vellum: vellum)
				}
				for memory in memories {
					persist.store(memory: memory)
				}
				return true
			}
		}
	}
}
