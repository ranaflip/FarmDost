import SwiftUI

struct HighDemandCropsView: View {
    var body: some View {
        List {
            Text("Wheat")
            Text("Rice")
            Text("Potatoes")
            Text("Tomatoes")
        }
        .navigationTitle("High-Demand Crops")
    }
}
