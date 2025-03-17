//
//  DailyStatistics.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Foundation

/// Statistics about the servers tracked by joinmastodon.org on a given day.
public struct DailyStatistics: Codable, Hashable, Sendable {
	/// The day the statistics are for.
	public var period: Date
	/// The number of servers tracked by joinmastodon.org on this day.
	public var serverCount: Int
	/// The total number of users as of this day.
	public var userCount: Int
	/// The number of active users on this day.
	public var activeUserCount: Int
	
	public init(period: Date, serverCount: Int, userCount: Int, activeUserCount: Int) {
		self.period = period
		self.serverCount = serverCount
		self.userCount = userCount
		self.activeUserCount = activeUserCount
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.period = try container.decode(Date.self, forKey: .period)
		
		if let intServerCount = try? container.decode(Int.self, forKey: .serverCount) {
			self.serverCount = intServerCount
		} else {
			let stringServerCount = try container.decode(String.self, forKey: .serverCount)
			guard let intServerCount = Int(stringServerCount) else {
				throw DecodingError.dataCorruptedError(forKey: .serverCount, in: container, debugDescription: "Invalid server count: \(stringServerCount)")
			}
			self.serverCount = intServerCount
		}
		
		if let intUserCount = try? container.decode(Int.self, forKey: .userCount) {
			self.userCount = intUserCount
		} else {
			let stringUserCount = try container.decode(String.self, forKey: .userCount)
			guard let intUserCount = Int(stringUserCount) else {
				throw DecodingError.dataCorruptedError(forKey: .userCount, in: container, debugDescription: "Invalid user count: \(stringUserCount)")
			}
			self.userCount = intUserCount
		}
		
		if let intActiveUserCount = try? container.decode(Int.self, forKey: .activeUserCount) {
			self.activeUserCount = intActiveUserCount
		} else {
			let stringActiveUserCount = try container.decode(String.self, forKey: .activeUserCount)
			guard let intActiveUserCount = Int(stringActiveUserCount) else {
				throw DecodingError.dataCorruptedError(forKey: .activeUserCount, in: container, debugDescription: "Invalid user count: \(stringActiveUserCount)")
			}
			self.activeUserCount = intActiveUserCount
		}
	}
}
