import Foundation

struct PostcardItem: Identifiable, Codable, Equatable {
    var id: UUID
    var dateAdded: Date
    var title: String
    var sender: String
    var location: String
    var dateReceived: String

    init(id: UUID = UUID(), dateAdded: Date = Date(), title: String, sender: String, location: String, dateReceived: String) {
        self.id = id
        self.dateAdded = dateAdded
        self.title = title
        self.sender = sender
        self.location = location
        self.dateReceived = dateReceived
    }

    static func blank() -> PostcardItem {
        PostcardItem(title: "", sender: "", location: "", dateReceived: "")
    }
}
