import Foundation

struct UserProfile: Codable, Identifiable {
    var id = UUID()
    let gender: String
    let age: Int
    let height: Double  // in inches
    let weight: Double  // in pounds
    let activityLevel: String
    let fitnessGoal: String
    let workoutEnvironment: String
    let exerciseExperience: String
    let nutritionKnowledge: String
    let trainerQualities: [String]
    
    // Computed properties for convenience
    var heightInCm: Double {
        return height * 2.54
    }
    
    var weightInKg: Double {
        return weight * 0.453592
    }
    
    var bmi: Double {
        let heightInMeters = heightInCm / 100
        return weightInKg / (heightInMeters * heightInMeters)
    }
    
    var bmr: Double {
        // Mifflin-St Jeor Equation
        let s = gender == "Male" ? 5 : -161
        return (10 * weightInKg) + (6.25 * heightInCm) - (5 * Double(age)) + Double(s)
    }
    
    var tdee: Double {
        let activityMultiplier: Double
        switch activityLevel {
        case "Sedentary":
            activityMultiplier = 1.2
        case "Lightly active":
            activityMultiplier = 1.375
        case "Moderately active":
            activityMultiplier = 1.55
        case "Very active":
            activityMultiplier = 1.725
        default:
            activityMultiplier = 1.2
        }
        
        return bmr * activityMultiplier
    }
    
    var dailyCalorieTarget: Int {
        var calorieAdjustment: Double = 0
        
        switch fitnessGoal {
        case "Gain muscle":
            calorieAdjustment = 500
        case "Lose fat":
            calorieAdjustment = -500
        case "Both":
            calorieAdjustment = 0
        default:
            calorieAdjustment = 0
        }
        
        return Int(tdee + calorieAdjustment)
    }
} 