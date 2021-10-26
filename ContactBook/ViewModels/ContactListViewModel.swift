import Foundation

class ContactListViewModel: ViewModel {
    
    @Published var contacts: [ContactViewModel] = []
    private let manager = CoreDataManager.shared
    
    override init() {
        super.init()
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
