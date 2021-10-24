import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Contact>
    
    @State var showSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { contact in
                    NavigationLink {
                        Text("Contact at \(contact.name!)")
                    } label: {
                        Text(contact.name!)
                    }
                }
                .onDelete(perform: deleteContactss)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addContact) {
                        Label("Add Contact", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                Text("Hello World")
            })
        }
    }

    private func addContact() {
        showSheet = true
    }

    private func deleteContactss(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
