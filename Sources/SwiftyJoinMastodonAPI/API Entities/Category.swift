import Foundation

/// A category that servers can belong to.
public struct Category: Codable, Hashable, Sendable {
	/// A non-localized category name.
	public typealias Name = String
	
	/// The non-localized name of the category.
	public var category: Name
	/// The number of servers in this category.
	public var serversCount: Int
	
	public init(category: Name, serversCount: Int) {
		self.category = category
		self.serversCount = serversCount
	}
}
