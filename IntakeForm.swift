import SwiftUI

// Define the question model
struct Question {
    let title: String
    let type: QuestionType
}

// Enum to handle different question types
enum QuestionType {
    case text(placeholder: String?, keyboardType: UIKeyboardType)
    case selection(options: [String])
    case multiSelection(options: [String])
}

// Progress Indicator Component
struct ProgressIndicator: View {
    let index: Int
    let isCurrent: Bool
    let total: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if index > 0 {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 2, height: 30)
            } else {
                Spacer().frame(height: 30)
            }
            
            if isCurrent {
                Text(String(format: "%02d", index))
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
            } else {
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
            }
            
            if index < total - 1 {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 2, height: 30)
            } else {
                Spacer().frame(height: 30)
            }
        }
        .frame(width: 50)
    }
}

// Question View Component
struct QuestionView: View {
    let question: Question
    @Binding var answer: String
    let isCurrent: Bool
    let onComplete: () -> Void
    
    @State private var selectedOptions: Set<String> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.title)
                .font(.headline)
                .foregroundColor(.gray)
            
            if isCurrent {
                switch question.type {
                case .text(let placeholder, let keyboardType):
                    TextField(placeholder ?? "Enter your answer", text: $answer)
                        .keyboardType(keyboardType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                case .selection(let options):
                    Picker("Select an option", selection: $answer) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.bottom, 10)
                case .multiSelection(let options):
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(options, id: \.self) { option in
                            Toggle(option, isOn: Binding(
                                get: { selectedOptions.contains(option) },
                                set: { isOn in
                                    if isOn {
                                        selectedOptions.insert(option)
                                    } else {
                                        selectedOptions.remove(option)
                                    }
                                    answer = selectedOptions.sorted().joined(separator: ", ")
                                }
                            ))
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                Button("Next") {
                    onComplete()
                }
                .padding()
                .buttonStyle(.bordered)
            }
        }
        .opacity(isCurrent ? 1 : 0.3)
        .padding(.vertical, 20)
        .onAppear {
            if case .multiSelection = question.type {
                selectedOptions = Set(answer.split(separator: ", ").map(String.init))
            }
        }
    }
}

// Main Intake Form View
struct IntakeForm: View {
    @State private var currentQuestion = 0
    @State private var answers: [String] = Array(repeating: "", count: 10)
    @State private var isFormCompleted = false
    
    let questions: [Question] = [
        Question(title: "What is your gender?", type: .selection(options: ["Male", "Female", "Prefer not to say"])),
        Question(title: "What is your age?", type: .text(placeholder: "e.g., 30", keyboardType: .numberPad)),
        Question(title: "What is your height (inches)?", type: .text(placeholder: "e.g., 68", keyboardType: .numberPad)),
        Question(title: "What is your weight (pounds)?", type: .text(placeholder: "e.g., 150", keyboardType: .numberPad)),
        Question(title: "What is your activity level?", type: .selection(options: ["Sedentary", "Lightly active", "Moderately active", "Very active"])),
        Question(title: "What is your fitness goal?", type: .selection(options: ["Gain muscle", "Lose fat", "Both"])),
        Question(title: "What is your preferred workout environment?", type: .selection(options: ["Home", "Gym", "Hybrid"])),
        Question(title: "What is your exercise experience?", type: .selection(options: ["Beginner", "Intermediate", "Advanced", "Expert"])),
        Question(title: "What is your nutrition knowledge?", type: .selection(options: ["None", "Basic", "Intermediate", "Advanced"])),
        Question(title: "What qualities do you prefer in a trainer? (Select all that apply)", type: .multiSelection(options: ["Supportive", "Motivational", "Disciplined", "Flexible"]))
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        ForEach(0..<questions.count, id: \.self) { index in
                            HStack(alignment: .top) {
                                ProgressIndicator(
                                    index: index,
                                    isCurrent: index == currentQuestion,
                                    total: questions.count
                                )
                                
                                QuestionView(
                                    question: questions[index],
                                    answer: $answers[index],
                                    isCurrent: index == currentQuestion,
                                    onComplete: {
                                        if currentQuestion < questions.count - 1 {
                                            withAnimation {
                                                currentQuestion += 1
                                                proxy.scrollTo(currentQuestion, anchor: .center)
                                            }
                                        } else {
                                            isFormCompleted = true
                                        }
                                    }
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .id(index)
                        }
                    }
                }
            }
            
            if isFormCompleted {
                NavigationLink(destination: FitnessPlanner(userProfile: createUserProfile()), isActive: $isFormCompleted) {
                    EmptyView()
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            withAnimation {
                ScrollViewReader { proxy in
                    proxy.scrollTo(0, anchor: .center)
                }
            }
        }
    }
    
    // Create a user profile from the answers
    private func createUserProfile() -> UserProfile {
        return UserProfile(
            gender: answers[0],
            age: Int(answers[1]) ?? 0,
            height: Double(answers[2]) ?? 0.0,
            weight: Double(answers[3]) ?? 0.0,
            activityLevel: answers[4],
            fitnessGoal: answers[5],
            workoutEnvironment: answers[6],
            exerciseExperience: answers[7],
            nutritionKnowledge: answers[8],
            trainerQualities: answers[9].split(separator: ", ").map(String.init)
        )
    }
}

// Preview
struct IntakeForm_Previews: PreviewProvider {
    static var previews: some View {
        IntakeForm()
    }
} 