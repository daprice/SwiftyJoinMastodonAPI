//
//  JoinMastodonAPI+Request.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension JoinMastodonAPI {
	
	/// A request that can be fulfilled by an API endpoint and may have parameters.
	public protocol Request: Sendable {
		/// The relative path to the API endpoint.
		var relativePath: String { get }
		/// Array of `URLQueryItem` to send as URL parameters.
		var queryItems: [URLQueryItem] { get }
		/// Set any properties on a URLRequest that are specific to this request.
		func configureURLRequest(_ urlRequest: inout URLRequest)
		/// The type to decode the response as.
		associatedtype Response: Decodable
	}
	
}

public extension JoinMastodonAPI.Request where Self == GetCategoriesRequest {
	/// Get a list of available ``Category`` that servers can belong to.
	static var getCategories: GetCategoriesRequest { GetCategoriesRequest() }
	
	/// Get a list of available ``Category`` that servers can belong to, that meet the filter criteria.
	///
	/// The stats for each category will reflect the filter options you pass in.
	static func getCategories(filterParameters: FilterParameters) -> GetCategoriesRequest {
		GetCategoriesRequest(filterParameters: filterParameters)
	}
}

public extension JoinMastodonAPI.Request where Self == GetLanguagesRequest {
	/// Get a list of available ``Language`` that servers can support.
	static var getLanguages: GetLanguagesRequest { GetLanguagesRequest() }
	
	/// Get a list of supported ``Language`` on servers that meet the filter criteria.
	static func getLanguages(filterParameters: FilterParameters) -> GetLanguagesRequest {
		GetLanguagesRequest(filterParameters: filterParameters)
	}
}

public extension JoinMastodonAPI.Request where Self == GetStatisticsRequest {
	/// Get daily statistics about the servers tracked by the joinmastodon service.
	static var getStatistics: GetStatisticsRequest {
		GetStatisticsRequest()
	}
}

public extension JoinMastodonAPI.Request where Self == GetServersRequest {
	/// Get all servers listed on joinmastodon.org.
	static var getServers: GetServersRequest { GetServersRequest() }
	
	/// Get the servers that meet the given filter criteria.
	static func getServers(filterParameters: FilterParameters) -> GetServersRequest {
		GetServersRequest(filterParameters: filterParameters)
	}
}
