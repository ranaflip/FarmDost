import SwiftUI

struct WeatherSuitableCropsView: View {
    @State private var weather: String = "Sunny, 26°C"
    @State private var crops: [String] = ["Wheat", "Maize", "Rice"]

    var body: some View {
        VStack {
            Text("Weather: \(weather)").font(.title2).padding()
            List(crops, id: \.self) { crop in
                Text(crop)
            }
        }
        .navigationTitle("Weather Suitable Crops")
    }
}
