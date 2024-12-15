import Foundation

struct Product: Identifiable, Codable {
    let id: UUID
    let name: String
    let price: Double
    let weight: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id" // Map backend's `_id` to `id`
        case name
        case price
        case weight
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        guard let uuid = UUID(uuidString: idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "Invalid UUID format")
        }
        self.id = uuid
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.weight = try container.decode(Double.self, forKey: .weight)
    }

    init(id: UUID = UUID(), name: String, price: Double, weight: Double) {
        self.id = id
        self.name = name
        self.price = price
        self.weight = weight
    }
}
