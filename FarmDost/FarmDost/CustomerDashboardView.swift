import SwiftUI

struct CustomerDashboardView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Binding var userType: String? // Binding to reset userType on logout
    @Binding var isLoggedIn: Bool  // Binding to manage login state
    @State private var searchText = "" // State to hold search input

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // Custom Search Bar
                CustomSearchBar(searchText: $searchText)

                // Dashboard Title
                Text("Customer Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                // Filtered Product List
                List(filteredProducts, id: \.id) { product in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.name)
                            .font(.headline)
                        Text("Price: $\(product.price, specifier: "%.2f")")
                            .foregroundColor(.green)
                        Text("Weight: \(product.weight, specifier: "%.2f") kg")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }

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
            }
            .navigationTitle("Dashboard")
            .toolbar {
                // Profile Button in the Toolbar
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(
                        userName: "Rana Chandan",  // Replace with dynamic user details
                        userEmail: "ranachandan@1682gmail.com",
                        userRole: "Customer",
                        isLoggedIn: $isLoggedIn
                    )) {
                        Image(systemName: "person.crop.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    // Filtered products based on the search text
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

// Custom Search Bar Component
struct CustomSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        ZStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .padding(10)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.leading, 40)

                Spacer()

                // Search Icon
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding(.trailing, 10)
            }
            .padding(.horizontal, 15)

            // Decorative Background Grid
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color.gray]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .opacity(0.1)
                .cornerRadius(10)
                .frame(height: 60)
        }
        .padding(.vertical, 10)
    }
}
