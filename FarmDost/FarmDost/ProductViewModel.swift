import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let baseURL = "http://localhost:5001/api/products" // Replace with your backend URL

    // Fetch products from the backend
    func fetchProducts(completion: (() -> Void)? = nil) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL: \(baseURL)")
            completion?()
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { completion?() } // Ensure completion handler is called

            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response from server")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                print("Raw Data: \(String(data: data, encoding: .utf8) ?? "Unreadable data")")
                let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self?.products = decodedProducts
                    print("Fetched Products: \(decodedProducts)")
                }
            } catch {
                print("Error decoding products: \(error.localizedDescription)")
            }
        }.resume()
    }

    // Add a product to the backend
    func addProductToBackend(product: Product, completion: (() -> Void)? = nil) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL: \(baseURL)")
            completion?()
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let productData = try JSONEncoder().encode(product)
            request.httpBody = productData
        } catch {
            print("Error encoding product: \(error)")
            completion?()
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] _, response, error in
            defer { completion?() } // Ensure completion handler is called

            if let error = error {
                print("Error adding product: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                print("Failed to add product. Response: \(String(describing: response))")
                return
            }

            DispatchQueue.main.async {
                self?.fetchProducts() // Refresh the product list after adding
            }
        }.resume()
    }

    // Remove a product from the backend
    func removeProduct(at offsets: IndexSet, completion: (() -> Void)? = nil) {
        offsets.forEach { index in
            let product = products[index]
            guard let url = URL(string: "\(baseURL)/\(product.id)") else {
                print("Invalid URL for product removal")
                completion?()
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { [weak self] _, response, error in
                defer { completion?() } // Ensure completion handler is called

                if let error = error {
                    print("Error deleting product: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Failed to delete product. Response: \(String(describing: response))")
                    return
                }

                DispatchQueue.main.async {
                    self?.products.remove(at: index)
                }
            }.resume()
        }
    }
}
