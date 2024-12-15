import SwiftUI

struct LoginView: View {
    @Binding var userType: String?
    @Binding var isLoggedIn: Bool
    @State private var selectedRole: String?
    @State private var showLoading = false

    var roles: [Role] = [
        Role(name: "Customer", icon: "person.fill", color: .blue),
        Role(name: "Seller", icon: "cart.fill", color: .green),
        Role(name: "Logistics", icon: "car.fill", color: .orange)
    ]

    var body: some View {
        ZStack {
            // Background Image
            Image("tractor_bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)

            if showLoading {
                // Loading Animation
                LoadingAnimation()
            } else {
                VStack(spacing: 20) {
                    Spacer()

                    // App Title
                    Text("FarmDost")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .shadow(radius: 10)

                    Text("Select your role to continue")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Spacer()

                    // Role Selection Tiles
                    RoleSelectionView(roles: roles, selectedRole: $selectedRole) { role in
                        selectRole(role)
                    }

                    Spacer()

                    // Continue Button
                    if let role = selectedRole {
                        Button(action: {
                            withAnimation {
                                showLoading = true
                            }

                            // Simulate login process
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                userType = role
                                isLoggedIn = true
                            }
                        }) {
                            Text("Continue as \(role)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
        }
    }

    func selectRole(_ role: String) {
        selectedRole = role
    }
}

struct Role: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct RoleSelectionView: View {
    let roles: [Role]
    @Binding var selectedRole: String?
    let onSelect: (String) -> Void

    var body: some View {
        HStack(spacing: 20) {
            ForEach(roles) { role in
                Button(action: {
                    onSelect(role.name)
                }) {
                    VStack {
                        Image(systemName: role.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(role.color.opacity(0.2))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(role.name == selectedRole ? role.color : Color.gray, lineWidth: 3)
                            )

                        Text(role.name)
                            .font(.headline)
                            .foregroundColor(role.name == selectedRole ? role.color : Color.gray)
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(15)
                    .shadow(color: role.name == selectedRole ? role.color.opacity(0.5) : Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct LoadingAnimation: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            HStack(spacing: 30) {
                CircleView(delay: 0)
                CircleView(delay: 0.2)
                CircleView(delay: 0.3)
            }
        }
    }
}

struct CircleView: View {
    var delay: Double

    @State private var moveUp = false

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 20, height: 20)
            .offset(y: moveUp ? -30 : 30)
            .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(delay))
            .onAppear {
                moveUp = true
            }
    }
}
