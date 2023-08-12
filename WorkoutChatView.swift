////
////  WorkoutChatView.swift
////  Tandem Health (iOS)
////
////  Created by Iris Yan on 8/7/23.
////
//
//import SwiftUI
//
//struct Workout: Identifiable {
//    let id: Int
//    let date: Date
//    let type: String
//    let duration: TimeInterval // in seconds
//    let distance: Double // might be in miles or kilometers
//    let calories: Double
//    let heartRateZones: [ZoneDuration]
//}
//
//enum HeartRateZone: String, Decodable {
//    case peak
//    case cardio
//    case fatBurn
//    case outOfZone
//}
//struct ZoneDuration: Decodable {
//    let zone: HeartRateZone
//    let duration: TimeInterval // in seconds
//}
//
//
//struct HeartRateZoneView: View {
//    let zoneDuration: ZoneDuration
//
//    var body: some View {
//        VStack {
//            Text(zoneDuration.zone.rawValue.capitalized)
//                .font(.caption)
//            Rectangle()
//                .fill(colorForZone(zone: zoneDuration.zone))
//                .frame(width: 10, height: CGFloat(zoneDuration.duration / 60)) // Assuming height in minutes for simplicity
//        }
//    }
//
//    func colorForZone(zone: HeartRateZone) -> Color {
//        switch zone {
//        case .peak: return .red
//        case .cardio: return .orange
//        case .fatBurn: return .yellow
//        case .outOfZone: return .gray
//        }
//    }
//}
//
//struct WorkoutChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutChatView()
//    }
//}
//
//struct WorkoutChatView: View {
//    @State private var latestWorkout: Workout?
//    @State private var isLoading: Bool = false
//    @State private var errorMessage: String?
//    @State private var isRefreshing: Bool = false
//
//    var body: some View {
//        VStack {
//            if isLoading {
//                ProgressView("Fetching latest workout...")
//            } else if let workout = latestWorkout {
//                List {
//                    Text("Workout Type: \(workout.type)")
//                    Text("Duration: \(workout.duration) seconds")
//                    Text("Distance: \(workout.distance)")
//                    Text("Calories: \(workout.calories)")
//                    // Display other workout data...
//
//                    HStack {
//                        ForEach(workout.heartRateZones) { zoneDuration in
//                            HeartRateZoneView(zoneDuration: zoneDuration)
//                        }
//                    }
//                }
//                .refreshable {
//                    await loadLatestWorkout()
//                }
//            } else if let error = errorMessage {
//                Text(error)
//                    .foregroundColor(.red)
//            } else {
//                Text("No recent workouts found.")
//            }
//        }
//        .onAppear(perform: loadCachedWorkout)
//        .onAppear(perform: loadLatestWorkout)
//    }
//
//    func loadCachedWorkout() {
//        if let cachedWorkout = UserDefaults.standard.workout(forKey: "latestWorkout") {
//            self.latestWorkout = cachedWorkout
//        }
//    }
//
//    func loadLatestWorkout() async {
//        isLoading = true
//
//        // Assuming your backend endpoint is at this URL
//        let url = URL(string: "https://your-backend-url.com/latestWorkout")!
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let workout = try JSONDecoder().decode(Workout.self, from: data)
//            self.latestWorkout = workout
//            UserDefaults.standard.setWorkout(workout, forKey: "latestWorkout")
//            errorMessage = nil
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//
//        isLoading = false
//        isRefreshing = false
//    }
//}
