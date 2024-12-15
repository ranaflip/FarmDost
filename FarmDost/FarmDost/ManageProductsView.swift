import SwiftUI

struct ManageProductsView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var showingAddProductSheet = false
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if viewModel.products.isEmpty {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom)

                        Text("No products available")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else {
                    List(viewModel.products, id: \.id) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.name)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Price: $\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.green)

                            Text("Weight: \(product.weight, specifier: "%.2f") kg")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(InsetGroupedListStyle())
                }

                Button(action: {
                    showingAddProductSheet = true
                }) {
                    Label("Add Product", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 10)
            }
            .navigationTitle("Manage Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                isLoading = true
                viewModel.fetchProducts { // Correct closure call
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                }
            }
            .sheet(isPresented: $showingAddProductSheet) {
                AddProductView(viewModel: viewModel)
            }
        }
    }
}
