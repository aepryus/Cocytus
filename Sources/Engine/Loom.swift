//
//  Loom.swift
//  Acheron
//
//  Created by Joe Charlier on 4/23/19.
//  Copyright © 2019 Aepryus Software. All rights reserved.
//

import Foundation

public class Loom {
	private static var namespaces: [String] = []
	static var domains = [String:[String:AnyClass]]()

	static func nameFromType(_ type: Domain.Type) -> String {
		let fullname: String = NSStringFromClass(type)
		let name = String(fullname[fullname.range(of: ".")!.upperBound...])
		return name[0...0].lowercased()+name[1...]
	}
	static func classFromName(_ name: String) -> AnyClass? {
		var cls: AnyClass? = nil
		for namespace in Loom.namespaces {
			let fullname = namespace + "." + name[0...0].uppercased()+name[1...]
			cls =  NSClassFromString(fullname)
			if cls != nil {break}
		}
		return cls
	}
	public static func classForKeyPath(keyPath: String, parent: Domain.Type) -> AnyClass? {
		return NSClassFromString("Domain")
	}
	public static func arrayClassForKeyPath(keyPath: String, parent: AnyObject) -> AnyClass? {
		let mirror: Mirror = Mirror(reflecting: parent)
		for property in mirror.children {
			guard property.label! == keyPath else {continue}
			var className = "\(Swift.type(of: property.value))"
			if className.starts(with: "Array<") {
				className.removeLast(1)
				className.removeFirst(6)
				for namespace in Loom.namespaces {
					if let cls = NSClassFromString("\(namespace).\(className)") {
						return cls
					}
				}
			}
			return nil
		}
		return nil
	}
}
