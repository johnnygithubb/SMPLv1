import SwiftUI

struct FitnessPlanner: View {
    let userProfile: UserProfile
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView(userProfile: userProfile)
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(0)
            
            WorkoutPlanView(userProfile: userProfile)
                .tabItem {
                    Label("Workouts", systemImage: "figure.strengthtraining.traditional")
                }
                .tag(1)
            
            MealPlanView(userProfile: userProfile)
                .tabItem {
                    Label("Nutrition", systemImage: "fork.knife")
                }
                .tag(2)
            
            ProgressView(userProfile: userProfile)
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(3)
        }
        .navigationBarTitle("Your Fitness Plan", displayMode: .inline)
    }
}

struct DashboardView: View {
    let userProfile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Welcome section
                VStack(alignment: .leading) {
                    Text("Welcome to your fitness journey")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Hello, \(userProfile.gender == "Male" ? "Sir" : "Ma'am")!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                
                // Stats section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Stats")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 15) {
                        StatCard(title: "BMI", value: String(format: "%.1f", userProfile.bmi))
                        StatCard(title: "Daily Calories", value: "\(userProfile.dailyCalorieTarget)")
                    }
                }
                .padding()
                
                // Today's plan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Today's Plan")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // Workout card
                    NavigationLink(destination: WorkoutDetailView()) {
                        PlanCard(
                            title: "Upper Body Workout",
                            subtitle: "45 minutes",
                            icon: "figure.arms.open",
                            color: .blue
                        )
                    }
                    
                    // Meal card
                    NavigationLink(destination: MealDetailView()) {
                        PlanCard(
                            title: "Meal Plan",
                            subtitle: "\(userProfile.dailyCalorieTarget) calories",
                            icon: "fork.knife",
                            color: .green
                        )
                    }
                }
                .padding()
                
                // AI Coach tip
                VStack(alignment: .leading, spacing: 10) {
                    Text("AI Coach Tip")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "brain")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                        
                        Text("Based on your profile, focus on proper form during strength training to maximize results and prevent injury.")
                            .font(.body)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct PlanCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct WorkoutPlanView: View {
    let userProfile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Weekly Workout Plan")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Generate workout plan based on user profile
                ForEach(generateWorkoutPlan(), id: \.day) { workout in
                    NavigationLink(destination: WorkoutDetailView()) {
                        WorkoutDayCard(workout: workout)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func generateWorkoutPlan() -> [WorkoutDay] {
        // This would typically come from an AI model or backend
        // For now, we'll create a sample plan based on the user's profile
        var workouts: [WorkoutDay] = []
        
        switch userProfile.fitnessGoal {
        case "Gain muscle":
            workouts = [
                WorkoutDay(day: "Monday", focus: "Chest & Triceps", duration: 60),
                WorkoutDay(day: "Tuesday", focus: "Back & Biceps", duration: 60),
                WorkoutDay(day: "Wednesday", focus: "Active Recovery", duration: 30),
                WorkoutDay(day: "Thursday", focus: "Shoulders & Arms", duration: 60),
                WorkoutDay(day: "Friday", focus: "Legs", duration: 60),
                WorkoutDay(day: "Saturday", focus: "Full Body", duration: 45),
                WorkoutDay(day: "Sunday", focus: "Rest Day", duration: 0)
            ]
        case "Lose fat":
            workouts = [
                WorkoutDay(day: "Monday", focus: "HIIT Cardio", duration: 45),
                WorkoutDay(day: "Tuesday", focus: "Upper Body", duration: 45),
                WorkoutDay(day: "Wednesday", focus: "Low Intensity Cardio", duration: 30),
                WorkoutDay(day: "Thursday", focus: "Lower Body", duration: 45),
                WorkoutDay(day: "Friday", focus: "HIIT Cardio", duration: 45),
                WorkoutDay(day: "Saturday", focus: "Full Body", duration: 45),
                WorkoutDay(day: "Sunday", focus: "Rest Day", duration: 0)
            ]
        default:
            workouts = [
                WorkoutDay(day: "Monday", focus: "Upper Body & Cardio", duration: 60),
                WorkoutDay(day: "Tuesday", focus: "Lower Body & Core", duration: 60),
                WorkoutDay(day: "Wednesday", focus: "Active Recovery", duration: 30),
                WorkoutDay(day: "Thursday", focus: "Full Body Circuit", duration: 45),
                WorkoutDay(day: "Friday", focus: "HIIT Training", duration: 45),
                WorkoutDay(day: "Saturday", focus: "Mobility & Core", duration: 30),
                WorkoutDay(day: "Sunday", focus: "Rest Day", duration: 0)
            ]
        }
        
        return workouts
    }
}

struct WorkoutDay: Identifiable {
    var id = UUID()
    let day: String
    let focus: String
    let duration: Int
}

struct WorkoutDayCard: View {
    let workout: WorkoutDay
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.day)
                    .font(.headline)
                
                Text(workout.focus)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(workout.duration) minutes")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: workout.focus == "Rest Day" ? "bed.double.fill" : "figure.run")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.bottom, 5)
    }
}

struct WorkoutDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Upper Body Workout")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Complete 3 sets of each exercise")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                ForEach(sampleExercises, id: \.name) { exercise in
                    ExerciseCard(exercise: exercise)
                }
            }
            .padding()
        }
        .navigationBarTitle("Workout Details", displayMode: .inline)
    }
    
    private var sampleExercises: [Exercise] {
        [
            Exercise(name: "Push-ups", reps: "12-15", weight: "Body weight"),
            Exercise(name: "Dumbbell Bench Press", reps: "10-12", weight: "Moderate"),
            Exercise(name: "Bent-over Rows", reps: "10-12", weight: "Moderate"),
            Exercise(name: "Shoulder Press", reps: "10-12", weight: "Light-Moderate"),
            Exercise(name: "Bicep Curls", reps: "12-15", weight: "Light"),
            Exercise(name: "Tricep Dips", reps: "12-15", weight: "Body weight")
        ]
    }
}

struct Exercise {
    let name: String
    let reps: String
    let weight: String
}

struct ExerciseCard: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack {
                Label(exercise.reps, systemImage: "repeat")
                Spacer()
                Label(exercise.weight, systemImage: "scalemass")
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.bottom, 5)
    }
}

struct MealPlanView: View {
    let userProfile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Daily Nutrition Plan")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    StatCard(title: "Daily Target", value: "\(userProfile.dailyCalorieTarget) cal")
                    
                    VStack {
                        Text("Macros")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            MacroCircle(name: "Protein", percentage: 30, color: .red)
                            MacroCircle(name: "Carbs", percentage: 45, color: .blue)
                            MacroCircle(name: "Fats", percentage: 25, color: .yellow)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("Meal Plan")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                ForEach(sampleMeals, id: \.name) { meal in
                    NavigationLink(destination: MealDetailView()) {
                        MealCard(meal: meal)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var sampleMeals: [Meal] {
        [
            Meal(name: "Breakfast", calories: userProfile.dailyCalorieTarget / 4, time: "7:00 AM"),
            Meal(name: "Lunch", calories: userProfile.dailyCalorieTarget / 3, time: "12:00 PM"),
            Meal(name: "Snack", calories: userProfile.dailyCalorieTarget / 10, time: "3:00 PM"),
            Meal(name: "Dinner", calories: userProfile.dailyCalorieTarget / 3, time: "7:00 PM")
        ]
    }
}

struct MacroCircle: View {
    let name: String
    let percentage: Int
    let color: Color
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 5)
                    .frame(width: 40, height: 40)
                
                Circle()
                    .trim(from: 0, to: CGFloat(percentage) / 100)
                    .stroke(color, lineWidth: 5)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(-90))
                
                Text("\(percentage)%")
                    .font(.caption2)
                    .fontWeight(.bold)
            }
            
            Text(name)
                .font(.caption)
        }
    }
}

struct Meal {
    let name: String
    let calories: Int
    let time: String
}

struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.headline)
                
                Text("\(meal.calories) calories")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(meal.time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "fork.knife")
                .font(.title)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.bottom, 5)
    }
}

struct MealDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Breakfast")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("500 calories")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ForEach(sampleIngredients, id: \.name) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text(ingredient.amount)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                
                Divider()
                
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("1. In a bowl, mix oats, milk, and chia seeds.\n2. Cover and refrigerate overnight.\n3. In the morning, add chopped banana and berries.\n4. Sprinkle with nuts and a drizzle of honey.")
            }
            .padding()
        }
        .navigationBarTitle("Meal Details", displayMode: .inline)
    }
    
    private var sampleIngredients: [Ingredient] {
        [
            Ingredient(name: "Rolled Oats", amount: "1/2 cup"),
            Ingredient(name: "Almond Milk", amount: "3/4 cup"),
            Ingredient(name: "Chia Seeds", amount: "1 tbsp"),
            Ingredient(name: "Banana", amount: "1 medium"),
            Ingredient(name: "Mixed Berries", amount: "1/4 cup"),
            Ingredient(name: "Walnuts", amount: "1 tbsp"),
            Ingredient(name: "Honey", amount: "1 tsp")
        ]
    }
}

struct Ingredient {
    let name: String
    let amount: String
}

struct ProgressView: View {
    let userProfile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your Progress")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Weight tracking chart placeholder
                VStack(alignment: .leading) {
                    Text("Weight Tracking")
                        .font(.headline)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(height: 200)
                        
                        Text("Weight chart will appear here")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Workout consistency chart placeholder
                VStack(alignment: .leading) {
                    Text("Workout Consistency")
                        .font(.headline)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(height: 200)
                        
                        Text("Consistency chart will appear here")
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Achievements section
                VStack(alignment: .leading) {
                    Text("Achievements")
                        .font(.headline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(sampleAchievements, id: \.title) { achievement in
                                AchievementCard(achievement: achievement)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var sampleAchievements: [Achievement] {
        [
            Achievement(title: "First Workout", description: "Completed your first workout", icon: "star.fill", unlocked: true),
            Achievement(title: "Consistency", description: "Worked out 3 days in a row", icon: "flame.fill", unlocked: true),
            Achievement(title: "Early Bird", description: "Completed a workout before 8 AM", icon: "sunrise.fill", unlocked: false),
            Achievement(title: "Strength Gains", description: "Increased your lifting weight", icon: "arrow.up.circle.fill", unlocked: false)
        ]
    }
}

struct Achievement {
    let title: String
    let description: String
    let icon: String
    let unlocked: Bool
}

struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        VStack {
            Image(systemName: achievement.icon)
                .font(.largeTitle)
                .foregroundColor(achievement.unlocked ? .yellow : .gray)
                .padding()
            
            Text(achievement.title)
                .font(.headline)
            
            Text(achievement.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 150)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .opacity(achievement.unlocked ? 1.0 : 0.6)
    }
}

struct FitnessPlanner_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FitnessPlanner(userProfile: PreviewData.sampleUserProfile)
        }
    }
}

// Sample data for previews
struct PreviewData {
    static let sampleUserProfile = UserProfile(
        gender: "Male",
        age: 30,
        height: 70,
        weight: 180,
        activityLevel: "Moderately active",
        fitnessGoal: "Gain muscle",
        workoutEnvironment: "Gym",
        exerciseExperience: "Intermediate",
        nutritionKnowledge: "Basic",
        trainerQualities: ["Motivational", "Disciplined"]
    )
} 