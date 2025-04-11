import Foundation

class HabitManager: ObservableObject {
    @Published var habits: [Habit] = []

    private let habitsKey = "PurposeHabitsKey"

    init() {
        loadHabits()
    }

    func addHabit(name: String, frequency: Int) {
        let habit = Habit(name: name, frequency: frequency)
        habits.append(habit)
        saveHabits()
    }

    private func saveHabits() {
        do {
            let data = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(data, forKey: habitsKey)
        } catch {
            print("Error saving habits: \(error.localizedDescription)")
        }
    }

    private func loadHabits() {
        guard let data = UserDefaults.standard.data(forKey: habitsKey) else {
            habits = []
            return
        }
        do {
            habits = try JSONDecoder().decode([Habit].self, from: data)
        } catch {
            print("Error loading habits: \(error.localizedDescription)")
            habits = []
            UserDefaults.standard.removeObject(forKey: habitsKey) // Clear bad data
        }
    }
}
