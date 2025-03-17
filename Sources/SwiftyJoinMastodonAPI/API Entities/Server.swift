//
//  Server.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

/// Information about a Mastodon server.
public struct Server: Codable, Hashable, Sendable {
	/// Which region a server is legally based in.
	public enum Region: String, Sendable, Codable {
		case europe = "europe"
		case northAmerica = "north_america"
		case southAmerica = "south_america"
		case africa = "africa"
		case asia = "asia"
		case oceania = "oceania"
	}
	
	/// The domain name of the server.
	public var domain: String
	/// The version of Mastodon the server runs.
	public var version: String
	/// A short description of the server written by its administrators.
	public var description: String
	/// The supported languages on the server.
	public var languages: [Language.LanguageCode]
	/// The region where the server is legally based.
	public var region: Region?
	/// The names of categories the server belongs to.
	///
	/// Corresponds to ``Category/category``
	public var categories: [Category.Name]
	/// The URL to fetch the server's thumbnail image using joinmastodon's proxy.
	public var proxiedThumbnail: String
	/// The BlurHash string for the server's thumbnail image.
	public var blurhash: String
	/// The total number of users registered on the server.
	public var totalUsers: Int
	/// The number of users active on the server in the past week.
	public var lastWeekUsers: Int
	/// Whether the server requires manual approval of new accounts.
	public var approvalRequired: Bool
	/// The server's primary language.
	///
	/// - SeeAlso: ``languages``
	public var language: Language.LanguageCode
	/// The primary ``Category`` the server belongs to.
	///
	/// - SeeAlso: ``categories``
	public var category: Category.Name
	
	public init(domain: String, version: String, description: String, languages: [Language.LanguageCode], region: Region? = nil, categories: [Category.Name], proxiedThumbnail: String, blurhash: String, totalUsers: Int, lastWeekUsers: Int, approvalRequired: Bool, language: Language.LanguageCode, category: Category.Name) {
		self.domain = domain
		self.version = version
		self.description = description
		self.languages = languages
		self.region = region
		self.categories = categories
		self.proxiedThumbnail = proxiedThumbnail
		self.blurhash = blurhash
		self.totalUsers = totalUsers
		self.lastWeekUsers = lastWeekUsers
		self.approvalRequired = approvalRequired
		self.language = language
		self.category = category
	}
}
