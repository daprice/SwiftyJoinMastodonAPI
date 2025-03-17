//
//  JoinMastodonAPI+Request.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

extension JoinMastodonAPI {
	
	public protocol Request: Sendable {
		var relativePath: String { get }
		var queryItems: [URLQueryItem] { get }
		associatedtype Response: Decodable
	}
	
}

public extension JoinMastodonAPI.Request where Self == GetCategoriesRequest {
	static var getCategories: GetCategoriesRequest { GetCategoriesRequest() }
	
	static func getCategories(filterParameters: FilterParameters) -> GetCategoriesRequest {
		GetCategoriesRequest(filterParameters: filterParameters)
	}
}

public extension JoinMastodonAPI.Request where Self == GetLanguagesRequest {
	static var getLanguages: GetLanguagesRequest { GetLanguagesRequest() }
	
	static func getLanguages(filterParameters: FilterParameters) -> GetLanguagesRequest {
		GetLanguagesRequest(filterParameters: filterParameters)
	}
}

public extension JoinMastodonAPI.Request where Self == GetStatisticsRequest {
	static var getStatistics: GetStatisticsRequest {
		GetStatisticsRequest()
	}
}

public extension JoinMastodonAPI.Request where Self == GetServersRequest {
	static var getServers: GetServersRequest { GetServersRequest() }
	
	static func getServers(filterParameters: FilterParameters) -> GetServersRequest {
		GetServersRequest(filterParameters: filterParameters)
	}
}
