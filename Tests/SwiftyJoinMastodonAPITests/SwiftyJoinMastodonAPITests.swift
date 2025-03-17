import Testing
@testable import SwiftyJoinMastodonAPI

struct DecodableTests {
	@Test func categoriesDecode() throws {
		let testJSON = """
		[{
			"category": "journalism",
			"servers_count": 3
		}, {
			"category": "furry",
			"servers_count": 8
		}]

		"""
		
		let data = testJSON.data(using: .utf8)!
		let categories: [Category] = try JoinMastodonAPI.jsonDecoder.decode([Category].self, from: data)
		#expect(categories.count == 2)
		#expect(categories[0].category == "journalism")
		#expect(categories[0].serversCount == 3)
	}
	
	@Test func dailyStatisticsDecode() throws {
		let testJson = """
		[{
			"period": "2025-02-16",
			"server_count": "8769",
			"user_count": "9460539",
			"active_user_count": "932297"
		}, {
			"period": "2025-02-17",
			"server_count": "8765",
			"user_count": "9464385",
			"active_user_count": "937037"
		}]
		"""
		
		let data = testJson.data(using: .utf8)!
		let stats: [DailyStatistics] = try JoinMastodonAPI.jsonDecoder.decode([DailyStatistics].self, from: data)
		#expect(stats.count == 2)
		#expect(stats[0].period.ISO8601Format() == "2025-02-16T00:00:00Z")
		#expect(stats[0].serverCount == 8769)
	}
	
	@Test func languagesDecode() throws {
		let testJson = """
		[{
			"locale": "be",
			"language": null,
			"servers_count": 1
		}, {
			"locale": "bs",
			"language": null,
			"servers_count": 1
		}, {
			"locale": "ca",
			"language": "Català",
			"servers_count": 3
		}, {
			"locale": "cs",
			"language": "Čeština",
			"servers_count": 2
		}]
		"""
		
		let data = testJson.data(using: .utf8)!
		let languages: [Language] = try JoinMastodonAPI.jsonDecoder.decode([Language].self, from: data)
		#expect(languages.count == 4)
		#expect(languages[0].locale == "be")
		#expect(languages[0].language == nil)
		#expect(languages[0].serversCount == 1)
		#expect(languages[2].locale == "ca")
		#expect(languages[2].language == "Català")
		#expect(languages[2].serversCount == 3)
	}
	
	@Test func serversDecode() throws {
		let testJson = """
		[{
			"domain": "mastodon.social",
			"version": "4.4.0-nightly.2025-03-14-security",
			"description": "The original server operated by the Mastodon gGmbH non-profit",
			"languages": ["en"],
			"region": "",
			"categories": ["general"],
			"proxied_thumbnail": "https://proxy.joinmastodon.org/de816a7e564f2dfeca7582c83a7ad365a6a7d210/68747470733a2f2f66696c65732e6d6173746f646f6e2e736f6369616c2f736974655f75706c6f6164732f66696c65732f3030302f3030302f3030312f4031782f353763313266343431643038336364652e706e67",
			"blurhash": "UeKUpFxuo~R%0nW;WCnhF6RjaJt757oJodS$",
			"total_users": 921100,
			"last_week_users": 367792,
			"approval_required": false,
			"language": "en",
			"category": "general"
		  }, {
			"domain": "example.com",
			"version": "4.4.0-alpha.4+glitch",
			"description": "A Mastodon instance\\r\\n",
			"languages": ["en"],
			"region": "north_america",
			"categories": ["tech"],
			"proxied_thumbnail": "https://proxy.joinmastodon.org/3c980cda8c7d9653dc771565048a4a6efc2320db/68747470733a2f2f6d656469612e696e666f7365632e65786368616e67652f696e666f7365632e65786368616e67652f736974655f75706c6f6164732f66696c65732f3030302f3030302f3030372f4031782f626263366138396235346332343938612e706e67",
			"blurhash": "UE8NU%_NyDiwi_R*bbxa0K9FMxXSb^xai_E1",
			"total_users": 459235,
			"last_week_users": 140219,
			"approval_required": false,
			"language": "en",
			"category": "tech"
		  }]
		"""
		
		let data = testJson.data(using: .utf8)!
		let servers: [Server] = try JoinMastodonAPI.jsonDecoder.decode([Server].self, from: data)
		#expect(servers.count == 2)
		#expect(servers[0].domain == "mastodon.social")
		#expect(servers[0].languages == ["en"])
		#expect(servers[0].region == nil)
		#expect(servers[0].totalUsers == 921100)
		#expect(servers[0].approvalRequired == false)
		#expect(servers[0].registrations == .instant)
		#expect(servers[1].region == .northAmerica)
	}
}
