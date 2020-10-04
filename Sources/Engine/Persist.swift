//
//  Persist.swift
//  Cocytus
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

class Persist {
	var name: String
	var acnt: UUID?
	
	init(name: String) {
		self.name = name
	}
	init(name: String, acnt: UUID) {
		self.name = name
		self.acnt = acnt
	}
	
	func echo(_ from: Int) -> [UUID] {
		return []
	}
	func listAllIdens() -> [String] {
		return []
	}
	func transact (_ transact: ()->(Bool)) {}
	
	// Account =========================================================================================
	func store(account: Account) {}
	func account(acnt: UUID) -> Account? {return nil}
	func account(user: String) -> Account? {return nil}
	func account(otid: String) -> Account? {return nil}
	func account(token: String) -> Account? {return nil}
	
	// Memory ==========================================================================================
	func store(memory: Memory) {}
	func memory(name: String) -> Memory? {return nil}
	
	// Device ===========================================================================================
	func store(device: Device) {}
	func device(token: String) -> Device? {return nil}
	func delete(device: Device) {}
	
	// Vellum ==========================================================================================
	func store (vellum: Vellum) {}
	func vellum (iden: UUID) -> Vellum? {return nil}
	func vellum (type: String, only: String) -> Vellum? {return nil}
}

//open class Persist: NSObject {
//	open var name: String
//	var acnt: UUID?
//	var typeToOnly: [String:String] = [:]
//
//	public init(_ name: String) {
//		self.name = name
//	}
//	init(name: String) {
//		self.name = name
//	}
//	init(name: String, acnt: UUID) {
//		self.name = name
//		self.acnt = acnt
//	}
//
//	public func associate(type: String, only: String) {
//		typeToOnly[type] = only
//	}
//	public func only(type: String) -> String? {
//		return typeToOnly[type]
//	}
//
//	open func selectAll() -> [[String:Any]] {
//		return []
//	}
//	open func selectAll(type: String) -> [[String:Any]] {
//		return []
//	}
//	open func select(where: String, is value: String?, type: String) -> [[String:Any]] {
//		return []
//	}
//	open func selectOne(where: String, is value: String, type: String) -> [String:Any]? {
//		return nil
//	}
//
//	open func selectForked() -> [[String:Any]] {
//		return []
//	}
//	open func selectForkedMemories() -> [[String:Any]] {
//		return []
//	}
//
//	open func attributes(iden: String) -> [String:Any]? {return nil}
//	open func attributes(type: String, only: String) -> [String:Any]? {return nil}
//
//	open func delete(iden: String) {}
//	open func store(iden: String, attributes: [String:Any]) {}
//
//	open func transact(_ closure: ()->(Bool)) {
//		_ = closure()
//	}
//
//	open func wipe() {}
//	open func wipeDocuments() {}
//
//	open func show() {}
//	open func show(_ iden: String) {}
//	open func census() {}
//
//	open func set(key: String, value: String) {}
//	open func setServer(key: String, value: String) {}
//	open func get(key: String) -> String? {
//		return nil
//	}
//	open func unset(key: String) {}
//
//	open func logError(_ error: Error) {}
//	open func logError(message: String) {}
//
//	func echo(_ from: Int) -> [UUID] {
//		return []
//	}
//	func listAllIdens() -> [String] {
//		return []
//	}
//
//// Account =========================================================================================
//	func store(account: Account) {}
//	func account(acnt: UUID) -> Account? {return nil}
//	func account(user: String) -> Account? {return nil}
//	func account(otid: String) -> Account? {return nil}
//	func account(token: String) -> Account? {return nil}
//
//// Memory ==========================================================================================
//	func store(memory: Memory) {}
//	func memory(name: String) -> Memory? {return nil}
//
//// Device ===========================================================================================
//	func store(device: Device) {}
//	func device(token: String) -> Device? {return nil}
//	func delete(device: Device) {}
//
//// Vellum ==========================================================================================
//	func store (vellum: Vellum) {}
//	func vellum (iden: UUID) -> Vellum? {return nil}
//	func vellum (type: String, only: String) -> Vellum? {return nil}
//}
