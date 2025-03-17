//
//  File.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

public struct GetLanguagesRequest: JoinMastodonAPI.Request {
	public var filterParameters: FilterParameters?
	public typealias Response = [Language]
	
	public init(filterParameters: FilterParameters? = nil) {
		self.filterParameters = filterParameters
	}
	
	public var relativePath: String {
		"languages"
	}
	
	public var queryItems: [URLQueryItem] {
		filterParameters?.queryItems ?? []
	}
}
