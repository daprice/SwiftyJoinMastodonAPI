# SwiftyJoinMastodonAPI

An easy way to work with the [joinmastodon.org](https://joinmastodon.org/servers) server listing API in Swift.

```swift
import SwiftyJoinMastodonAPI

// Get all servers
async let servers = JoinMastodonAPI.default.perform(.getServers)

// Get servers filtered by language, category, region, ownership type, or open registrations
async let filteredServers = JoinMastodonAPI.default.perform(.getServers(filterParameters: .init(
	language: "en",
	category: "general",
	region: .europe,
	registrations: .instant
)))

// Use a custom URLSession
let customURLSessionAPIClient = JoinMastodonAPI(urlSession: .init(configuration: .ephemeral))
async let stats = customURLSessionAPIClient.perform(.getStatistics)
```
