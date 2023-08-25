import SwiftUI

struct RecommendationView: View {
    
    @State private var userName: String = "Rehana Ali" // Replace with the actual user name
    @State private var selectedDay: Int = Calendar.current.component(.weekday, from: Date()) - 1 // Current day of the week

    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    // 7-day timeline
                    HStack(spacing: geometry.size.width / 40) { // Adjusts the spacing between the bubbles
                        ForEach(selectedDay - 3..<selectedDay + 4, id: \.self) { index in
                            if index < selectedDay {
                                Image(systemName: "checkmark.circle.fill") // Filled checkmark for completed days
                                    .resizable()
                                    .aspectRatio(contentMode: .fit) // Maintains aspect ratio
                                    .frame(width: geometry.size.width / 9) // Sets the size of the checkmark
                                    .foregroundColor(.gray.opacity(0.25)) // Lighter stroke
                            } else if index == selectedDay {
                                Text(daysOfWeek[index % 7])
                                    .font(.subheadline)
                                    .frame(width: geometry.size.width / 9, height: geometry.size.width / 9) // Sets the size of the bubbles
                                    .background(Color.blue) // Blue background for the current day
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            } else {
                                Text(daysOfWeek[index % 7])
                                    .font(.subheadline)
                                    .frame(width: geometry.size.width / 9, height: geometry.size.width / 9) // Sets the size of the bubbles
                                    .background(Color.gray) // Gray background for other days
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal, (geometry.size.width - (geometry.size.width / 9 * 7 + geometry.size.width / 40 * 6)) / 2) // Centers the bubbles
                    
                    .padding(.leading, -30) // Aligns the bubbles to the left


                    Text("Hi \(userName)!")
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    // Recommendations
                    Text("Today’s Focus")
                        .font(Font.custom("Poppins", size: 20).weight(.medium))
                        .padding(.bottom)
                        .lineSpacing(26)
                        .foregroundColor(.black)
                
                    VStack(alignment: .leading) {
                        RecommendationItemView(emoji: "😴", title: "Sleep", details: "8 h of sleep minimum", width: geometry.size.width - 60)
                        RecommendationItemView(emoji: "🧘🏻‍♀️", title: "Movement", details: "Ongoing", width: geometry.size.width - 60)
                        RecommendationItemView(emoji: "🍬", title: "Glucose", details: "14 days", width: geometry.size.width - 60)
                        RecommendationItemView(emoji: "💊", title: "Supplements", details: "2 months left", width: geometry.size.width - 60)
                    }
                }
                .padding(.horizontal, 30)
            }
            .navigationBarTitle("Health Suggestions", displayMode: .inline)
        }
    }
}

struct RecommendationItemView: View {
    var emoji: String
    var title: String
    var details: String
    var width: CGFloat
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(emoji)
                .font(Font.custom("Poppins", size: 22).weight(.medium))
                .lineSpacing(22)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Font.custom("Poppins", size: 18))
                    .lineSpacing(22)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(details)
                    .font(Font.custom("Poppins", size: 14))
                    .lineSpacing(17.50)
                    .foregroundColor(Color(red: 0.61, green: 0.61, blue: 0.61))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(20)
        .frame(width: width)
        .background(Color(red: 0.85, green: 0.85, blue: 0.86))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.50)
                .stroke(Color(red: 0.92, green: 0.92, blue: 0.92), lineWidth: 0.50)
        )
        .shadow(
            color: Color(red: 0.91, green: 0.91, blue: 0.91, opacity: 1), radius: 2, y: 1
        )
    }
}
