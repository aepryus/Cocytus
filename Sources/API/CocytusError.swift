//
//  CocytusError.swift
//  Cocytus
//
//  Created by Joe Charlier on 7/27/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation

public enum CocytusError: Error, Equatable, CustomStringConvertible {
	case wrongServer
	case other(_ message: String)
	
// CustomStringConvertible =========================================================================
	public var description: String {
		switch self {
			case .wrongServer: return "wrong server"
			case .other(let message): return message
		}
	}
}
