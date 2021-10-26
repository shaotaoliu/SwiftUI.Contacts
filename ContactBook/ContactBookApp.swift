import SwiftUI

@main
struct ContactBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContactListView()
                .environmentObject(ContactListViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
