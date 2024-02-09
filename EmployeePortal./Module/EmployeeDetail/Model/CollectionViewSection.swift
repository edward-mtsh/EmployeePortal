import Foundation

struct CollectionViewSection: HashIdentifiable {
    let id = UUID().uuidString
    let title: String
    let items: [AnyHashable]
}
