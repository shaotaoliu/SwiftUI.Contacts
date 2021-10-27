import SwiftUI

struct ContactEditView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var vm: ContactListViewModel
    @State var contact: ContactViewModel
    @State var showCalendar = false
    @State var showImagePicker = false
    var operation: Operation = .edit
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ContactPhotoView(photo: contact.photo, width: 200, height: 200)
                    
                    Button(contact.photo == nil ? "Add Photo" : "Change Photo") {
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        AddPhotoView(selectedPhoto: $contact.photo)
                    }
                }
                
                Form {
                    TextField("Name", text: $contact.name)
                    
                    HStack {
                        TextField("Birthday", text: $contact.dobString)
                            .disabled(true)
                        
                        Button(action: {
                            showCalendar = true
                        }, label: {
                            Image(systemName: "calendar")
                        })
                            .buttonStyle(.borderless)
                            .sheet(isPresented: $showCalendar, content: {
                                AddDateView(dateString: $contact.dobString)
                            })
                        
                        Button(action: {
                            contact.dobString = ""
                        }, label: {
                            Image(systemName: "xmark.circle")
                        })
                            .buttonStyle(.borderless)
                    }
                    
                    TextField("Phone", text: $contact.phone)
                    TextField("Email", text: $contact.email)
                    
                    VStack(alignment: .leading) {
                        Text("Address")
                            //.foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                            .padding(.top, 3)
                        
                        TextEditor(text: $contact.address)
                            .frame(height: 90)
                            .border(Color(red: 0.88, green: 0.88, blue: 0.88))
                    }
                }
            }
            .navigationTitle("\(operation == .add ? "New" : "Edit") Contact")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CancelButton, trailing: SaveButton)
        }
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var SaveButton: some View {
        Button("Save") {
            if vm.save(contactVM: contact) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.errorMessage, actions: { error in
        }, message: { error in
            Text(error)
        })
    }
}

struct ContactEditView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEditView(contact: ContactViewModel(), operation: .add)
            .environmentObject(ContactListViewModel())
    }
}
