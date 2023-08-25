//
//  ContentView.swift
//  Shared
//
//  Created by Iris Yan on 8/3/23.
//
import SwiftUI
struct UserProfileView: View {
    @State private var name = ""
    @State private var age = ""
    @State private var gender = "Female" // Initialized with a default value
    @Binding var hasCompletedProfile: Bool
    @Binding var hasCompletedHealthDataAccess: Bool // Add this binding

    @State private var progress: Double = 0.5 // Example progress value; you can update this as needed
    @State private var showNextView = false // State to control the navigation

    var body: some View {
        NavigationView {
            VStack {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            Text("Personal Information")
                .font(.headline)
            Text("Please tell us more about yourself")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            Form {
                Section {
                    TextField("Full Name", text: $name)
                    TextField("Age", text: $age)
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                    }
                }
            }
            Spacer() // Pushes the button to the bottom
            Button("Next") {
                showNextView = true
                hasCompletedProfile = true
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity) // Makes the button full width
            .background(Color.blue) // Sets the background color
            .cornerRadius(15) // Rounds the corners
            .padding() // Adds some space around the button
            .background(
            NavigationLink("", destination: HealthDataAccessView(hasCompletedHealthDataAccess: $hasCompletedHealthDataAccess), isActive: $showNextView) // Pass the correct binding here
)
        }
        .navigationBarHidden(true) // Hides the navigation bar
    }
}
}
}
 
