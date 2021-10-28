import Foundation

class ContactListViewModel: ViewModel {
    
    @Published var contacts: [ContactViewModel] = []
    private let manager = CoreDataManager.preview
    
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
    func delete(contactVMs: [ContactViewModel]) -> Bool {
        do {
            try manager.delete(contactVMs: contactVMs)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetch()
    }
    
    
    @discardableResult
    func save(contactVM: ContactViewModel) -> Bool {
        if contactVM.name.isEmpty {
            errorMessage = "Name cannot be empty"
            return false
        }
        
        do {
            try manager.save(contactVM: contactVM)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetch()
    }
}
