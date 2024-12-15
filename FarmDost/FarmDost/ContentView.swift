import SwiftUI

struct ContentView: View {
    @State private var userType: String? = nil
    @State private var isLoggedIn: Bool = false // Track logged-in state
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                if let type = userType {
                    if type == "Seller" {
                        SellerDashboardView(viewModel: viewModel, userType: $userType, isLoggedIn: $isLoggedIn)
                    } else if type == "Customer" {
                        CustomerDashboardView(viewModel: viewModel, userType: $userType, isLoggedIn: $isLoggedIn)
                    } else {
                        Text("Unknown User Type")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            } else {
                LoginView(userType: $userType, isLoggedIn: $isLoggedIn) // Pass login state and user type
            }
        }
    }
}
