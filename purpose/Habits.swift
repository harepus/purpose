import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var frequency: Int

    init(id: UUID = UUID(), name: String, isCompleted: Bool = false, frequency: Int = 1) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.frequency = max(1, min(frequency, 7))
    }
}
