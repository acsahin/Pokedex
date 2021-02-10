import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let base_experience: Int
    let height: Int
    let name: String
    let order: Int
    let stats: [StatElement]
    let types: [TypeElement]
    let weight: Int
    let sprites: Sprites
}
// MARK: - StatElement
struct StatElement: Codable {
    let base_stat, effort: Int
    let stat: TypeClass
}
// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}
// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String
}
// MARK: - Sprites
struct Sprites: Codable {
    let other: Other?
}
// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}
// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
