import SwiftUI

struct CustomerSupportView: View {
    @State private var message: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Customer Support")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("How can we assist you?")
                .font(.headline)
                .foregroundColor(.gray)

            TextEditor(text: $message)
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button(action: {
                sendSupportMessage()
            }) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(message.isEmpty)

            Spacer()
        }
        .padding()
    }

    private func sendSupportMessage() {
        // Logic to send the support message (mocked for now)
        print("Support message sent: \(message)")
        message = ""
    }
}
