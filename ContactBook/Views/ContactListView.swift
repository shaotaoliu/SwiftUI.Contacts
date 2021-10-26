import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject var vm: ContactListViewModel
    @State var searchText = ""
    @State var showAddSheet = false
    
    var contacts: [ContactViewModel] {
        return searchText.isEmpty ? vm.contacts : vm.contacts.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.id) { contact in
                    NavigationLink(destination: ContactDetailView(contact: $vm.contacts[vm.contacts.firstIndex(where: { $0.id == contact.id })!])) {
                        Text(contact.name)
                    }
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
            .sheet(isPresented: $showAddSheet) {
                ContactAddView()
            }
        }
    }
    
    private func deleteContacts(offsets: IndexSet) {
        vm.delete(contactVMs: offsets.map { contacts[$0] })
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
            .environmentObject(ContactListViewModel())
    }
}
