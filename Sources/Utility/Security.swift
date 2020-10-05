//
//  Security.swift
//  Pequod
//
//  Created by Joe Charlier on 4/13/20.
//  Copyright © 2020 Aepryus Software. All rights reserved.
//

import Foundation
import PerfectBCrypt

public class Security {
	static func encryptSHA256(string: String) -> String? {
		if let encoded = string.digest(.sha256)?.encode(.base64) {
			return String(validatingUTF8: encoded)
		}
		return nil
	}
	static func encryptBCrypt(password: String, salt: String) -> String? {
		do {
			return try BCrypt.Hash(password, salt: salt)
		} catch {
			return nil
		}
	}
	static func salt() -> String? {
		do {
			return try BCrypt.Salt()
		} catch {
			return nil
		}
	}
}
