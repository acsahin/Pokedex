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
