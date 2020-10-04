//
//  Vellum.swift
//  Pequod
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

enum VellumStatus {
	case loading, clean, dirty, deleted
}

class Vellum {
	let acnt: UUID
	let iden: UUID
	let type: String
	let only: String?
	var json: String!
	var vers: Int
	var fork: Int
	var born: Int
	var gone: Int?
	
	var attributes: [String:Any] {
		didSet {
			loadAttributes(attributes)
		}
	}
	var modified: Date = Date()
	
	var status: VellumStatus = .loading
	
	static let iso8601: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return formatter
	}()
	
	init (acnt: UUID, born: Int, attributes: [String:Any]) {
		self.attributes = attributes

		self.acnt = acnt
		self.born = born
		
		iden = UUID(uuidString: attributes["iden"] as! String)!
		type = attributes["type"] as! String
		
		if let onlyTag = Vellum.resolver(for: type)?.only {
			only = attributes[onlyTag] as? String
		} else {
			only = nil
		}

		json = ""
		vers = attributes["vers"] as! Int
		fork = attributes["fork"] as! Int
		gone = attributes["gone"] as? Int
	}
	init (acnt: UUID, iden: UUID, type: String, only: String?, json: String, vers: Int, fork: Int, born: Int, gone: Int?) {
		self.acnt = acnt
		self.iden = iden
		self.type = type
		self.only = only
		self.json = json
		self.vers = vers
		self.fork = fork
		self.born = born
		self.gone = gone
		
		self.attributes = [:]
	}
	
	private func loadAttributes (_ attributes: [String:Any]) {
		json = ""
		vers = attributes["vers"] as! Int
		fork = attributes["fork"] as! Int
		gone = attributes["gone"] as? Int
		
		modified =  Vellum.iso8601.date(from: attributes["modified"] as! String)!
	}
	
// Actions =========================================================================================
	func create () {
		dirty()
	}
	func edit () {
		dirty()
	}
	func delete () {
		status = .deleted
	}
	
	private func dirty () {
		status = .dirty
	}
	
	func load () {
		status = .clean
	}
	func save () {
		status = .clean
	}

// Static ==========================================================================================
	static var resolvers = [String:Resolver]()
	
	static func registerResolver (_ resolver: Resolver) {
		resolvers[resolver.type] = resolver
	}
	static func resolver (for type: String) -> Resolver? {
		return resolvers[type]
	}
}
