////
////  RetrieveGData.swift
////  Tandem Health (iOS)
////
////  Created by Iris Yan on 8/8/23.
//
////retrieve glucose data
//
//import GlucoseDirectClient
//
//let glucoseClient = GlucoseDirectClient()
//glucoseClient.fetchGlucoseData { glucoseData, error in
//    if let data = glucoseData {
//        // Process the glucose data here
//    } else if let error = error {
//        print("Error fetching glucose data: \(error.localizedDescription)")
//    }
//}
//
//
////process data for spikes
//let userDefinedRange = (80...140) // Example range. This should be dynamic based on user settings.
//var spikeEvents: [GlucoseData] = []
//
//for reading in glucoseData {
//    if !userDefinedRange.contains(reading.value) {
//        spikeEvents.append(reading)
//    }
//}
//
////display for detected spikes
//struct SpikeView: View {
//    var glucoseData: [GlucoseData]
//    var body: some View {
//        VStack {
//            Text("Glucose Spike Detected!")
//                .font(.headline)
//            // You can use a library or custom SwiftUI views to generate a graph of the glucose data
//            Text("Timestamp: \(glucoseData.timestamp)") // Format this as needed
//            Text("Value: \(glucoseData.value) mg/dL")
//        }
//        .padding()
//        .background(Color.red.opacity(0.1))
//        .cornerRadius(8)
//    }
//}
//
//
//let totalReadings = glucoseData.count
//let spikeCount = spikeEvents.count
//let inRangeCount = totalReadings - spikeCount
//let percentageInRange = (Double(inRangeCount) / Double(totalReadings)) * 100
//
//func generateWeeklySummary() -> (spikeCount: Int, percentageInRange: Double) {
//    let totalReadings = self.glucoseReadings.count
//    let spikeCount = self.spikeEvents.count
//    let inRangeCount = totalReadings - spikeCount
//    let percentageInRange = (Double(inRangeCount) / Double(totalReadings)) * 100
//    return (spikeCount, percentageInRange)
//}
//
//struct WeeklySummaryView: View {
//    var spikeCount: Int
//    var percentageInRange: Double
//    var body: some View {
//        VStack {
//            Text("Weekly Glucose Summary")
//                .font(.headline)
//            Text("Spikes Detected: \(spikeCount)")
//            Text("Percentage in range: \(percentageInRange, specifier: "%.2f")%")
//        }
//        .padding()
//        .background(Color.blue.opacity(0.1))
//        .cornerRadius(8)
//    }
//}
//
//
//struct WorkoutChatView: View {
//    var spikeEvents: [GlucoseData]
//    var body: some View {
//        List(spikeEvents, id: \.timestamp) { spike in
//            SpikeView(glucoseData: [spike])
//            Button("What did you eat?") {
//                // Open a dialog or another view to let the user input details
//            }
//        }
//    }
//}
