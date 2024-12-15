import SwiftUI

struct AddProductView: View {
    @State private var productName: String = ""
    @State private var productPrice: String = ""
    @State private var productWeight: String = ""

    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        VStack {
            TextField("Product Name", text: $productName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Product Price", text: $productPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            TextField("Product Weight", text: $productWeight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            Button(action: {
                if let price = Double(productPrice),
                   let weight = Double(productWeight) {
                    let newProduct = Product(
                        id: UUID(),
                        name: productName,
                        price: price,
                        weight: weight
                    )
                    viewModel.addProductToBackend(product: newProduct)
                    clearFields()
                }
            }) {
                Text("Add Product")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func clearFields() {
        productName = ""
        productPrice = ""
        productWeight = ""
    }
}
