import SwiftUI

@main
struct ContactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContactListView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
