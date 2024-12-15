import SwiftUI

struct DashboardView: View {
    var userType: String // Role: Customer or Seller
    @ObservedObject var viewModel: ProductViewModel // Pass the ProductViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome, \(userType)")
                .font(.largeTitle)
                .fontWeight(.bold)

            if userType == "Seller" {
                NavigationLink(destination: ManageProductsView(viewModel: viewModel)) {
                    Text("Manage Products")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else if userType == "Customer" {
                NavigationLink(destination: BrowseProductsView(viewModel: viewModel)) {
                    Text("Browse Products")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Dashboard")
    }
}
