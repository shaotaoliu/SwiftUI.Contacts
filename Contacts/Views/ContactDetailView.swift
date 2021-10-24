import SwiftUI

struct ContactDetailView: View {
    
    let contact: ContactViewModel
    
    var body: some View {
        Form {
            Text(contact.name)
            Text(contact.dobString)
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: ContactListViewModel().contacts[0])
    }
}
