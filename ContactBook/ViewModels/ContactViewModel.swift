import Foundation
import CoreData
import UIKit

class ContactViewModel: ViewModel {
    private let manager = CoreDataManager.shared
    private var contact: Contact?
    
    init(contact: Contact) {
        self.contact = contact
        
        // TODO: copy values from model to vm
        name = contact.name!
        dobString = contact.dob == nil ? "" : contact.dob!.toDateString()
        phone = contact.phone ?? ""
        email = contact.email ?? ""
        address = contact.address ?? ""
        photo = contact.photo == nil ? nil : UIImage(data: contact.photo!)!
    }
    
    override init() {
        super.init()
        self.contact = nil
    }

    var id: NSManagedObjectID? {
        contact?.objectID
    }
    
    @Published var name: String = ""
    @Published var dobString: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var photo: UIImage?
    
    @discardableResult
    func save() -> Bool {
        if name.isEmpty {
            errorMessage = "Name cannot be empty"
            return false
        }
        
        do {
            try manager.save(vm: self)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return true
    }
}
