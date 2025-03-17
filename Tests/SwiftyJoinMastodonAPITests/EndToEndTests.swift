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
		let request = JoinMastodonAPI.CategoriesRequest(filterParameters: .init())
		let url = JoinMastodonAPI.default.url(for: request)
		let (data, _) = try await URLSession.shared.data(from: url)
		let categories: [SwiftyJoinMastodonAPI.Category] = try JoinMastodonAPI.jsonDecoder.decode([SwiftyJoinMastodonAPI.Category].self, from: data)
		#expect(categories.count > 5)
		#expect(categories.contains(where: { $0.category == "furry" })) // If there aren't any furry servers we're doomed
    }

	@Test func testGetFilteredCategories() async throws {
		let request = JoinMastodonAPI.CategoriesRequest(filterParameters: .init())
		async let categories = try await JoinMastodonAPI.default.perform(request)
		
		let filteredRequest = JoinMastodonAPI.CategoriesRequest(filterParameters: .init(language: "en"))
		async let filteredCategories = JoinMastodonAPI.default.perform(filteredRequest)
		
		let totalServerCount = try await categories.reduce(into: 0) { $0 = $0 + $1.serversCount }
		let filteredServerCount = try await filteredCategories.reduce(into: 0) { $0 = $0 + $1.serversCount }
		
		#expect(filteredServerCount < totalServerCount)
	}
}
