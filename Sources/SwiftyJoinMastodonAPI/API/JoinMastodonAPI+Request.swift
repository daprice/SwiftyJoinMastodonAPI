//
//  JoinMastodonAPI+Request.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

extension JoinMastodonAPI {
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
	
	public protocol Request: Sendable {
		var relativePath: String { get }
		var queryItems: [URLQueryItem] { get }
		associatedtype Response: Decodable
	}
	
	public struct CategoriesRequest: Request {
		public var filterParameters: FilterParameters
		public typealias Response = [Category]
		
		public init(filterParameters: FilterParameters) {
			self.filterParameters = filterParameters
		}
		
		public var relativePath: String {
			"categories"
		}
		
		public var queryItems: [URLQueryItem] {
			filterParameters.queryItems
		}
	}
	
	public struct LanguagesRequest: Request {
		public var filterParameters: FilterParameters
		public typealias Response = [Language]
		
		public init(filterParameters: FilterParameters) {
			self.filterParameters = filterParameters
		}
		
		public var relativePath: String {
			"languages"
		}
		
		public var queryItems: [URLQueryItem] {
			filterParameters.queryItems
		}
	}
	
	public struct ServersRequest: Request {
		public var filterParameters: FilterParameters
		public typealias Response = [Server]
		
		public init(filterParameters: FilterParameters) {
			self.filterParameters = filterParameters
		}
		
		public var relativePath: String {
			"servers"
		}
		
		public var queryItems: [URLQueryItem] {
			filterParameters.queryItems
		}
	}
	
	public struct StatisticsRequest: Request {
		public typealias Response = [DailyStatistics]
		
		public init() {}
		
		public var relativePath: String {
			"statistics"
		}
		
		public var queryItems: [URLQueryItem] { [] }
	}
}
