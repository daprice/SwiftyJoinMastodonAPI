//
//  JoinMastodonAPI.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Represents the API used for [the joinmastodon.org servers page](https://joinmastodon.org/servers).
public final class JoinMastodonAPI: Sendable {
	/// The base URL of the host, e.g. `https://api.joinmastodon.org`
	public let baseURL: URL
	/// The URLSession instance to make requests when using ``perform(_:)``
	public let urlSession: URLSession
	
	public init(baseURL: URL, urlSession: URLSession = .shared) {
		self.baseURL = baseURL
		self.urlSession = urlSession
	}
	
	/// A preconfigured singleton that connects to `https://api.joinmastodon.org` using the shared `URLSession`.
	public static let `default` = JoinMastodonAPI(baseURL: URL(string: "https://api.joinmastodon.org")!)
	
	/// A `JSONDecoder` instance configured for the formats used by the joinmastodon API.
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
	
	/// Get the full URL for any request, including query parameters.
	public func url(for request: any Request) -> URL {
		baseURL
			.appending(path: request.relativePath)
			.appending(queryItems: request.queryItems)
	}
	
	/// Perform a request and return the decoded response.
	///
	/// The following returns an array of ``Server``:
	/// ```swift
	///	async let servers = JoinMastodonAPI.shared.perform(.getServers) // returns `[Server]` asynchronously
	/// ```
	public func perform<R: Request>(_ request: R) async throws -> R.Response {
		let (data, _) = try await urlSession.data(from: url(for: request))
		return try Self.jsonDecoder.decode(R.Response.self, from: data)
	}
}
