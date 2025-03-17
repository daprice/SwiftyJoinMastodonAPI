//
//  File.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

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
}
