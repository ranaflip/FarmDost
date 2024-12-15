import SwiftUI

struct BrowseProductsView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                VStack(alignment: .leading) {
                    Text(product.name).font(.headline)
                    Text("₹\(product.price, specifier: "%.2f") - \(product.weight, specifier: "%.2f") kg")
                }
            }
        }
        .navigationTitle("Browse Products")
    }
}
