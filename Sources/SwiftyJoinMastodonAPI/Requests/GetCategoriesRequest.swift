//
//  File.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Get a list of available ``Category`` that servers can belong to.
public struct GetCategoriesRequest: JoinMastodonAPI.Request {
	public var filterParameters: FilterParameters?
	public typealias Response = [Category]
	
	public init(filterParameters: FilterParameters? = nil) {
		self.filterParameters = filterParameters
	}
	
	public var relativePath: String {
		"categories"
	}
	
	public var queryItems: [URLQueryItem] {
		filterParameters?.queryItems ?? []
	}
	
	public func configureURLRequest(_ urlRequest: inout URLRequest) {
		urlRequest.httpMethod = "GET"
	}
}
