import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [PostcardItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Always kept comfortably above seed data count so a
    /// fresh install never trips the paywall immediately.
    static let freeLimit = 15

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        fileURL = support.appendingPathComponent("postcardpile_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: PostcardItem) {
        guard canAddMore else { return }
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: PostcardItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: PostcardItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([PostcardItem].self, from: data) {
            items = decoded
        } else {
            items = seedData()
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    private func seedData() -> [PostcardItem] {
        [
        PostcardItem(title: "Eiffel Tower at Dusk", sender: "Aunt Rina", location: "Paris, France", dateReceived: "2024-09-10"),
        PostcardItem(title: "Grand Canyon Sunrise", sender: "Dad", location: "Arizona, USA", dateReceived: "2025-03-02"),
        PostcardItem(title: "Venice Canals", sender: "Marco", location: "Venice, Italy", dateReceived: "2025-05-18")
        ]
    }
}
