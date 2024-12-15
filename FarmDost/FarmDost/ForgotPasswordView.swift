import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Forgot Password")
                .font(.largeTitle)
                .padding()

            TextField("Enter your email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button("Submit") {
                // Logic to handle forgot password
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
