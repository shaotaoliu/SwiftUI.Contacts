import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    static let preview = CoreDataManager(preview: true)
    private let viewContext: NSManagedObjectContext
    
    init(preview: Bool = false) {
        viewContext = (preview ? PersistenceController.preview : PersistenceController.shared).container.viewContext
    }
        
    func fetchAllContacts() throws -> [ContactViewModel] {
        
        let request = Contact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let contacts = try viewContext.fetch(request)
        return contacts.map { ContactViewModel(contact: $0) }
    }
    
    func save(contactVM: ContactViewModel) throws {
        var contact: Contact
        
        if let id = contactVM.id {
            contact = try viewContext.existingObject(with: id) as! Contact
        }
        else {
            contact = Contact(context: viewContext)
        }
        
        contactVM.copyTo(contact)
        try viewContext.save()
    }
    
    func delete(contactVMs: [ContactViewModel]) throws {
        
        for contactVM in contactVMs {
            let contact = try viewContext.existingObject(with: contactVM.id!)
            viewContext.delete(contact)
        }
        
        try viewContext.save()
    }
}
