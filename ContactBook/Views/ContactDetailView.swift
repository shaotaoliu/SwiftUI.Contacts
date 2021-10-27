import SwiftUI

struct ContactDetailView: View {
    
    @Binding var contact: ContactViewModel
    @State private var showEditView = false
    
    var body: some View {
            VStack {
                Text(contact.name)
                    .font(.title2)
                    .bold()
                
                ContactPhotoView(photo: contact.photo, width: 200, height: 200)

                Form {
                    FieldRow(text: "Name", value: contact.name)
                    FieldRow(text: "Birthday", value: contact.dobString)
                    FieldRow(text: "Phone", value: contact.phone)
                    FieldRow(text: "Email", value: contact.email)
                    FieldRow(text: "Address", value: contact.address)
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: EditButton)
    }
    
    var EditButton: some View {
        Button("Edit") {
            showEditView = true
        }
        .sheet(isPresented: $showEditView) {
            ContactEditView(contact: contact)
        }
    }
    
    struct FieldRow: View {
        let text: String
        let value: String
        
        var body: some View {
            HStack {
                Text(text)
                Spacer()
                Text(value)
            }
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: .constant(ContactViewModel()))
    }
}
