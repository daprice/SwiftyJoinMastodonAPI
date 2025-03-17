//
//  FilterParameters.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

/// Request parameters for how to filter the returned results.
public struct FilterParameters: Codable, Hashable, Sendable {
	/// Only include servers that support this language code.
	public var language: Language.LanguageCode?
	/// Only include servers in this category.
	public var category: Category.Name?
	/// Only include servers based in this region.
	public var region: Server.Region?
	/// Only include servers owned by this type of owner.
	public var ownership: Server.Ownership?
	/// Only include servers accepting new users via this method.
	public var registrations: Server.RegistrationMethod?
	
	public init(language: Language.LanguageCode? = nil, category: Category.Name? = nil, region: Server.Region? = nil, ownership: Server.Ownership? = nil, registrations: Server.RegistrationMethod? = nil) {
		self.language = language
		self.category = category
		self.region = region
		self.ownership = ownership
		self.registrations = registrations
	}
	
	/// Array of `URLQueryItem` with corresponding to the properties of this FilterParameters struct and their values.
	public var queryItems: [URLQueryItem] {
		[
			.init(name: "language", value: language),
			.init(name: "category", value: category),
			.init(name: "region", value: region?.rawValue),
			.init(name: "ownership", value: ownership?.rawValue),
			.init(name: "registrations", value: registrations?.rawValue),
		]
	}
}
