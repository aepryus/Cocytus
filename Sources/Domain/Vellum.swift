//
//  Vellum.swift
//  Pequod
//
//  Created by Joe Charlier on 9/4/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public enum VellumStatus {
	case loading, clean, dirty, deleted
}

public class Vellum {
	public let acnt: UUID
	public let iden: UUID
	public let type: String
	public let only: String?
	public var json: String!
	public var vers: Int
	public var fork: Int
	public var born: Int
	public var gone: Int?
	
	public var attributes: [String:Any] {
		didSet {
			loadAttributes(attributes)
		}
	}
	public var modified: Date = Date()
	
	public var status: VellumStatus = .loading
	
	public static let iso8601: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return formatter
	}()
	
	public init (acnt: UUID, born: Int, attributes: [String:Any]) {
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
	public init (acnt: UUID, iden: UUID, type: String, only: String?, json: String, vers: Int, fork: Int, born: Int, gone: Int?) {
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
	public func create () {
		dirty()
	}
	public func edit () {
		dirty()
	}
	public func delete () {
		status = .deleted
	}
	
	private func dirty () {
		status = .dirty
	}
	
	public func load () {
		status = .clean
	}
	public func save () {
		status = .clean
	}

// Static ==========================================================================================
	static var resolvers = [String:Resolver]()
	
	public static func registerResolver (_ resolver: Resolver) {
		resolvers[resolver.type] = resolver
	}
	public static func resolver (for type: String) -> Resolver? {
		return resolvers[type]
	}
}
