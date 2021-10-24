import SwiftUI

struct ContactListView: View {
    
    @ObservedObject var contactListVM = ContactListViewModel()
    @State var searchText = ""
    @State var showAddSheet = false
    
    var contacts: [ContactViewModel] {
        if searchText.isEmpty {
            return contactListVM.contacts
        }
        
        return contactListVM.contacts.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.id) { contact in
                    NavigationLink(destination: {
                        ContactDetailView(contact: contact)
                    }, label: {
                        Text(contact.name)
                    })
                }
                .onDelete(perform: deleteContacts)
            }
            .searchable(text: $searchText)
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationBarItems(leading: Button(action: {
                showAddSheet = true
            }, label: {
                Image(systemName: "plus")
            }), trailing: EditButton())
            .sheet(isPresented: $showAddSheet, onDismiss: {
                contactListVM.fetch()
            }) {
                ContactEditView(contact: ContactViewModel(), operation: .add)
            }
        }
    }
    
    private func deleteContacts(offsets: IndexSet) {
        contactListVM.delete(contacts: offsets.map { contacts[$0] })
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
