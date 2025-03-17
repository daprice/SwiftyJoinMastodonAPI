//
//  ReadmeSampleCodeTests.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/17/25.
//

import Foundation

import Testing
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@testable import SwiftyJoinMastodonAPI

struct ReadmeSampleCodeTests {
	
	@Test func testReadmeSampleCode() async throws {
		// Get all servers
		async let servers = JoinMastodonAPI.default.perform(.getServers)
		
		// Get servers filtered by language, category, region, ownership type, or open registrations
		async let filteredServers = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(
			language: "en",
			category: "general",
			region: .europe,
			registrations: .instant
		)))
		
		#expect(try await !servers.isEmpty)
		#expect(try await !filteredServers.isEmpty)
	}
}
