//
//  String+Cocytus.swift
//  Cocytus
//
//  Created by Joe Charlier on 4/23/19.
//  Copyright © 2019 Aepryus Software. All rights reserved.
//

import Foundation

let chars_ = "0123456789abcdefghijklmnopqrstuvwxyz"

public extension String {
	subscript(i: Int) -> Character {										// [a]
		return self[index(startIndex, offsetBy: i)]
	}
	subscript(r: CountableClosedRange<Int>) -> String {						// [a...b]
		let start = index(startIndex, offsetBy: r.lowerBound)
		let end = index(startIndex, offsetBy: r.upperBound)
		return String(self[start...end])
	}
	subscript(r: CountablePartialRangeFrom<Int>) -> String {				// [a...]
		let start = index(startIndex, offsetBy: r.lowerBound)
		let end = endIndex
		return String(self[start..<end])
	}
	subscript(r: PartialRangeThrough<Int>) -> String {						// [...b]
		let start = startIndex
		let end = index(startIndex, offsetBy: r.upperBound)
		return String(self[start...end])
	}
	subscript(r: PartialRangeUpTo<Int>) -> String {							// [..<b]
		guard r.upperBound > 0 else {return ""}
		let start = startIndex
		let end = index(startIndex, offsetBy: r.upperBound-1)
		return String(self[start...end])
	}
	
	func loc(of string: String) -> Int? {
		guard let range = range(of: string) else {return nil}
		return distance(from: startIndex, to: range.lowerBound)
	}
	var capitalize: String {
		guard let first = first else { return "" }
		return String(first).uppercased() + dropFirst()
	}
	
	func toInt8() -> UnsafeMutablePointer<Int8> {
		return UnsafeMutablePointer<Int8>(mutating: (self as NSString).utf8String!)
	}
	func toCString() -> [CChar]? {
		return self.cString(using: .utf8)
	}
	func toAttributes() -> [String:Any] {
		guard self != "" else {return [:]}
		do {
			return try JSONSerialization.jsonObject(with: data(using: .utf8)!, options: [.allowFragments]) as! [String:Any]
		} catch {
			print("Error Attempting to Parse [\(self)]\n\(error)")
			return [:]
		}
	}
	func toArray() -> [[String:Any]] {
		guard self != "" else {return []}
		do {
			return try JSONSerialization.jsonObject(with: data(using: .utf8)!, options: [.allowFragments]) as! [[String:Any]]
		} catch {
			print("Error Attempting to Parse [\(self)]\n\(error)")
			return []
		}
	}
	
	static func uuid() -> String {
		return UUID().uuidString
	}
	
	static func randomString(length: Int) -> String {
		var sb = String()
		for _ in 0..<length {
			let index  = chars_.index(chars_.startIndex, offsetBy: Int.random(in: 0..<36))
			sb.append(chars_[index])
		}
		return sb
	}
}
