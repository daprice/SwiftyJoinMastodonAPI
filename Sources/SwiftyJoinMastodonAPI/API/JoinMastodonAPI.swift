//
//  JoinMastodonAPI.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

public final class JoinMastodonAPI: Sendable {
	public let baseURL: URL
	public let urlSession: URLSession
	
	public init(baseURL: URL, urlSession: URLSession = .shared) {
		self.baseURL = baseURL
		self.urlSession = urlSession
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
	
	public func url(for request: any Request) -> URL {
		baseURL
			.appending(path: request.relativePath)
			.appending(queryItems: request.queryItems)
	}
	
	public func perform<R: Request>(_ request: R) async throws -> R.Response {
		let (data, _) = try await urlSession.data(from: url(for: request))
		return try Self.jsonDecoder.decode(R.Response.self, from: data)
	}
}
