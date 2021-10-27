import SwiftUI

struct ContactAddView: View {
    @State var newContact = ContactViewModel()
    
    var body: some View {
        ContactEditView(contact: newContact, operation: .add)
    }
}

struct ContactAddView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddView()
    }
}
