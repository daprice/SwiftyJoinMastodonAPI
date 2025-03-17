//
//  JoinMastodonAPI+Request.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

extension JoinMastodonAPI {
	public enum Request: Sendable {
		public struct FilterParameters: Codable, Hashable, Sendable {
			public var language: Language.LanguageCode?
			public var category: Category.Name?
			public var region: Server.Region?
			public var ownership: Server.Ownership?
			public var registrations: Server.RegistrationMethod?
			
			public init(language: Language.LanguageCode? = nil, category: Category.Name? = nil, region: Server.Region? = nil, ownership: Server.Ownership? = nil, registrations: Server.RegistrationMethod? = nil) {
				self.language = language
				self.category = category
				self.region = region
				self.ownership = ownership
				self.registrations = registrations
			}
			
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
		
		case getCategories(FilterParameters)
		
		public var relativePath: String {
			switch self {
			case .getCategories(_):
				"categories"
			}
		}
		
		public var queryItems: [URLQueryItem] {
			switch self {
			case .getCategories(let filterParameters):
				filterParameters.queryItems
			}
		}
	}
}
