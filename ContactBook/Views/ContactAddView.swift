import SwiftUI

struct ContactAddView: View {
    @State var contact = ContactViewModel()
    
    var body: some View {
        ContactEditView(contact: contact, operation: .add)
    }
}

struct ContactAddView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddView()
    }
}
