import CoreData
import UIKit

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let contacts: [CodableContact] = FileReader.read(filename: "contacts.json")
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for c in contacts {
            let contact = Contact(context: viewContext)
            contact.name = c.name
            contact.dob = c.dob.toDate()
            contact.phone = c.phone
            contact.email = c.email
            contact.address = c.address
            contact.photo = UIImage(named: c.name)!.pngData()
        }
        
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ContactBook")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    

}
