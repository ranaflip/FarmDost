import SwiftUI

struct SellerDashboardView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Binding var userType: String? // Binding to reset userType on logout
    @Binding var isLoggedIn: Bool  // Binding to manage login state

    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Seller Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Navigation to Manage Products
                NavigationLink(destination: ManageProductsView(viewModel: viewModel)) {
                    Text("Manage Products")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // High-Demand Crops
                NavigationLink(destination: HighDemandCropsView()) {
                    Text("High-Demand Crops")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Weather-Suitable Crops
                NavigationLink(destination: WeatherSuitableCropsView()) {
                    Text("Weather-Suitable Crops")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()

                // Logout Button
                Button(action: {
                    userType = nil
                    isLoggedIn = false
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)

                // Customer Support Icon
                HStack {
                    Spacer()
                    Button(action: {
                        print("Customer Support Clicked!")
                    }) {
                        Image(systemName: "phone.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(
                        userName: "Rana Chandan",  // Pass dynamic user details
                        userEmail: "rana@1682gmail.com",
                        userRole: "Seller",
                        isLoggedIn: $isLoggedIn
                    )) {
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                    }
                }
            }
        }
    }
}
