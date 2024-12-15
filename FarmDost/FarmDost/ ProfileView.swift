import SwiftUI

struct ProfileView: View {
    let userName: String
    let userEmail: String
    let userRole: String
    @Binding var isLoggedIn: Bool // Binding to modify logged-in state

    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Name:")
                        .fontWeight(.bold)
                    Spacer()
                    Text(userName)
                }

                HStack {
                    Text("Email:")
                        .fontWeight(.bold)
                    Spacer()
                    Text(userEmail)
                }

                HStack {
                    Text("Role:")
                        .fontWeight(.bold)
                    Spacer()
                    Text(userRole)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()

            Spacer()

            Button(action: {
                isLoggedIn = false // Log out by setting isLoggedIn to false
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Profile")
    }
}
