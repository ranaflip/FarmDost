import SwiftUI

@main
struct FarmDostApp: App {
    @StateObject var productViewModel = ProductViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(productViewModel)
            }
        }
    }
}
