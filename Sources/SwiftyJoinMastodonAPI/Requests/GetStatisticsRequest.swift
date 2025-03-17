//
//  File.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

public struct GetStatisticsRequest: JoinMastodonAPI.Request {
	public typealias Response = [DailyStatistics]
	
	public init() {}
	
	public var relativePath: String {
		"statistics"
	}
	
	public var queryItems: [URLQueryItem] { [] }
}
