//
//  EndToEndTests.swift
//  SwiftyJoinMastodonAPI
//
//  Created by Dale Price on 3/16/25.
//

import Testing
import Foundation
@testable import SwiftyJoinMastodonAPI

struct EndToEndTests {

    @Test func testGetCategories() async throws {
		let request = GetCategoriesRequest()
		let url = JoinMastodonAPI.default.url(for: request)
		let (data, _) = try await URLSession.shared.data(from: url)
		let categories: [SwiftyJoinMastodonAPI.Category] = try JoinMastodonAPI.jsonDecoder.decode([SwiftyJoinMastodonAPI.Category].self, from: data)
		#expect(categories.count > 5)
		#expect(categories.contains(where: { $0.category == "furry" })) // If there aren't any furry servers we're doomed
    }

	@Test func testGetFilteredCategories() async throws {
		let request = GetCategoriesRequest()
		async let categories = try await JoinMastodonAPI.default.perform(request)
		
		let filteredRequest = GetCategoriesRequest(filterParameters: .init(language: "en"))
		async let filteredCategories = JoinMastodonAPI.default.perform(filteredRequest)
		
		let totalServerCount = try await categories.reduce(into: 0) { $0 = $0 + $1.serversCount }
		let filteredServerCount = try await filteredCategories.reduce(into: 0) { $0 = $0 + $1.serversCount }
		
		#expect(filteredServerCount < totalServerCount)
	}
	
	@Test func testGetLanguages() async throws {
		let languages = try await JoinMastodonAPI.default.perform(.getLanguages)
		#expect(languages.count > 5)
		#expect(languages.contains(where: {$0.language == "English" && $0.locale == "en"}))
	}
	
	@Test func testGetStatistics() async throws {
		let stats = try await JoinMastodonAPI.default.perform(.getStatistics)
		#expect(stats.count > 5)
	}
	
	@Test func testGetServers() async throws {
		let servers = try await JoinMastodonAPI.default.perform(.getServers)
		#expect(servers.count > 5)
	}
	
	@Test func testServerFilters() async throws {
		async let unfilteredServers = JoinMastodonAPI.default.perform(.getServers)
		async let filteredByLanguage = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(language: "en")))
		async let filteredByCategory = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(category: "regional")))
		async let filteredByRegion = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(region: .europe)))
		async let filteredByOwnership = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(ownership: .privateIndividual)))
		async let filteredByRegistrations = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(registrations: .instant)))
		async let filteredByMultiple = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(language: "en", category: "general", region: .europe, ownership: .privateIndividual, registrations: .instant)))
		
		#expect(try await !filteredByLanguage.isEmpty)
		#expect(try await filteredByLanguage.count < unfilteredServers.count)
		#expect(try await filteredByLanguage.allSatisfy({ $0.languages.contains("en") }))
		#expect(try await !unfilteredServers.allSatisfy({ $0.languages.contains("en") }))
		
		#expect(try await !filteredByCategory.isEmpty)
		#expect(try await filteredByCategory.count < unfilteredServers.count)
		
		#expect(try await !filteredByRegion.isEmpty)
		#expect(try await filteredByRegion.count < unfilteredServers.count)
		
		#expect(try await !filteredByOwnership.isEmpty)
		#expect(try await filteredByOwnership.count < unfilteredServers.count)
		
		#expect(try await !filteredByRegistrations.isEmpty)
		#expect(try await filteredByRegistrations.count < unfilteredServers.count)
		
		#expect(try await !filteredByMultiple.isEmpty)
		#expect(try await filteredByMultiple.count < unfilteredServers.count)
		#expect(try await filteredByMultiple.count < filteredByLanguage.count)
	}
}
