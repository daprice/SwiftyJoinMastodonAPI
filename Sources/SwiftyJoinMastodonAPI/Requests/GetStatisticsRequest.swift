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

/// Get daily statistics about the servers tracked by the joinmastodon service.
///
/// For convenience, you can also create this request using ``JoinMastodonAPI/Request/getStatistics``.
public struct GetStatisticsRequest: JoinMastodonAPI.Request {
	public typealias Response = [DailyStatistics]
	
	public init() {}
	
	public var relativePath: String {
		"statistics"
	}
	
	public var queryItems: [URLQueryItem] { [] }
	
	public func configureURLRequest(_ urlRequest: inout URLRequest) {
		urlRequest.httpMethod = "GET"
	}
}
