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
    
    func save(vm: ContactViewModel) throws {
        var contact: Contact
        
        if let id = vm.id {
            contact = try viewContext.existingObject(with: id) as! Contact
        }
        else {
            contact = Contact(context: viewContext)
        }
        
        // copy values from vm to model
        contact.name = vm.name
        contact.dob = vm.dobString.isEmpty ? nil : vm.dobString.toDate()
        contact.photo = vm.photo == nil ? nil : vm.photo!.pngData()
        
        
        try viewContext.save()
    }
    
    func delete(vms: [ContactViewModel]) throws {
        
        for vm in vms {
            let contact = try viewContext.existingObject(with: vm.id!)
            viewContext.delete(contact)
        }
        
        try viewContext.save()
    }
}
