//
//  Language.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

/// A language that servers can support.
public struct Language: Codable, Hashable, Sendable {
	/// A string representing an ISO 639 language code.
	public typealias LanguageCode = String
	
	/// The ISO 639 language code for the language.
	public var locale: String
	/// The native name of the language.
	public var language: LanguageCode?
	/// The number of servers that support this language.
	public var serversCount: Int
	
	public init(locale: String, language: LanguageCode? = nil, serversCount: Int) {
		self.locale = locale
		self.language = language
		self.serversCount = serversCount
	}
}
