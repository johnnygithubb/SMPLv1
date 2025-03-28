# SMPLv1

SMPLv1 is a personalized fitness coaching application that leverages artificial intelligence to create tailored workout and nutrition plans based on your individual profile.

## Features

- **Personalized Profiles**: Set up your fitness profile through a comprehensive intake form
- **Workout Planning**: Get personalized workout plans based on your fitness goals and experience
- **Nutrition Guidance**: Receive tailored meal plans that match your caloric needs
- **Progress Tracking**: Monitor your fitness journey and track achievements
- **AI Coaching**: Receive personalized tips from an AI coach designed to optimize your fitness routine

## Project Structure

```
SMPLv1/
├── SMPLv1.swift             # Main app entry point
├── ContentView.swift         # Main app view and navigation
├── IntakeForm.swift          # User profile setup questionnaire
├── Models/
│   └── UserProfile.swift     # User profile model
└── Views/
    └── FitnessPlanner.swift  # Various fitness plan views (workout, nutrition, etc.)
```

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run on your iOS device or simulator

## Development

This project uses SwiftUI for the user interface and follows the MVVM architecture pattern.

## Future Enhancements

- Integration with HealthKit for more accurate progress tracking
- Machine learning model to adapt workout plans based on user progress
- Community features for sharing achievements and workouts
- Integration with popular fitness tracking devices 