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
}
