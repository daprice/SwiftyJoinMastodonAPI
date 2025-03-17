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

/// Get servers listed on joinmastodon.org.
public struct GetServersRequest: JoinMastodonAPI.Request {
	public var filterParameters: FilterParameters?
	public typealias Response = [Server]
	
	public init(filterParameters: FilterParameters? = nil) {
		self.filterParameters = filterParameters
	}
	
	public var relativePath: String {
		"servers"
	}
	
	public var queryItems: [URLQueryItem] {
		filterParameters?.queryItems ?? []
	}
	
	public func configureURLRequest(_ urlRequest: inout URLRequest) {
		urlRequest.httpMethod = "GET"
	}
}
