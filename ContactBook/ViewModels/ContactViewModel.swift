import SwiftUI
import CoreData

struct ContactViewModel {
    
    var id: NSManagedObjectID? = nil
    var name: String = ""
    var dobString: String = ""
    var phone: String = ""
    var email: String = ""
    var address: String = ""
    var photo: UIImage? = nil

    init() {}
    
    init(contact: Contact) {
        id = contact.objectID
        name = contact.name!
        dobString = contact.dob == nil ? "" : contact.dob!.toDateString()
        phone = contact.phone ?? ""
        email = contact.email ?? ""
        address = contact.address ?? ""
        photo = contact.photo == nil ? nil : UIImage(data: contact.photo!)!
    }
    
    func copyTo(_ contact: Contact) {
        contact.name = name
        contact.dob = dobString.isEmpty ? nil : dobString.toDate()
        contact.photo = photo == nil ? nil : photo!.pngData()
        contact.phone = phone.isEmpty ? nil : phone
        contact.email = email.isEmpty ? nil : email
        contact.address = address.isEmpty ? nil : address
    }
}
