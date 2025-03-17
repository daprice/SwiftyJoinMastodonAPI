//
//  JoinMastodonAPI.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

public final class JoinMastodonAPI: Sendable {
	public let baseURL: URL
	
	public init(baseURL: URL) {
		self.baseURL = baseURL
	}
	
	public static let `default` = JoinMastodonAPI(baseURL: URL(string: "https://api.joinmastodon.org/")!)
	
	public static let jsonDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .custom({ decoder in
			let container = try decoder.singleValueContainer()
			let dateString = try container.decode(String.self)
			
			let formatter = ISO8601DateFormatter()
			formatter.formatOptions = [
				.withFullDate,
				.withDashSeparatorInDate,
			]
			
			guard let date = formatter.date(from: dateString) else {
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription:
						"Error parsing date: '\(dateString)'")
			}
			
			return date
		})
		return decoder
	}()
	
	public func url(for request: Request) -> URL {
		baseURL
			.appending(path: request.relativePath)
			.appending(queryItems: request.queryItems)
	}
}
