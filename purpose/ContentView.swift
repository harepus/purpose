import SwiftUI

struct ContentView: View {
    @StateObject private var habitManager = HabitManager()
    @State private var showingAddHabit = false
    @State private var newHabitName = ""
    @State private var newHabitFrequency = 1

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Purpose")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                List(habitManager.habits) { habit in
                    VStack(alignment: .leading) {
                        Text(habit.name)
                            .font(.headline)
                        Text("\(habit.frequency) times")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddHabit = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                VStack(spacing: 20) {
                    Text("Add New Habit")
                        .font(.title2)
                        .fontWeight(.bold)
                    TextField("Habit name", text: $newHabitName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Picker("Times", selection: $newHabitFrequency) {
                        ForEach(1...7, id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(.menu)
                    HStack {
                        Button("Cancel") {
                            showingAddHabit = false
                            resetForm()
                        }
                        .foregroundColor(.red)
                        Spacer()
                        Button("Save") {
                            if !newHabitName.isEmpty {
                                habitManager.addHabit(name: newHabitName, frequency: newHabitFrequency)
                                showingAddHabit = false
                                resetForm()
                            }
                        }
                        .disabled(newHabitName.isEmpty)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .presentationDetents([.medium])
            }
        }
    }

    private func resetForm() {
        newHabitName = ""
        newHabitFrequency = 1
    }
}

#Preview {
    ContentView()
}
