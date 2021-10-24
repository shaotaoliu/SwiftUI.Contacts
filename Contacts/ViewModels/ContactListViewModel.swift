import Foundation

class ContactListViewModel: ObservableObject {
    
    @Published var contacts: [ContactViewModel] = []
    @Published var hasError = false
    @Published var errorMessage: String? = nil {
        didSet {
            hasError = errorMessage != nil
        }
    }
    
    private let manager = CoreDataManager.shared
    
    init() {
        fetch()
    }
    
    @discardableResult
    func fetch() -> Bool {
        do {
            contacts = try manager.fetchAllContacts()
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return true
    }
    
    @discardableResult
    func delete(contacts: [ContactViewModel]) -> Bool {
        do {
            try manager.delete(vms: contacts)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetch()
    }
}
