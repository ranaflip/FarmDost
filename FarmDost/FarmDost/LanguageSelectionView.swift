import SwiftUI

struct LanguageSelectionView: View {
    @Binding var userType: String?

    var body: some View {
        VStack {
            Text("Select Language")
                .font(.largeTitle)
                .padding()

            Button("English") {
                userType = nil
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Hindi") {
                userType = nil
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
