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
