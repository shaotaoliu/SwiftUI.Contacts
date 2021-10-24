import SwiftUI

struct ContactEditView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var contact: ContactViewModel
    @State var showCalendar = false
    let operation: Operation
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("photo-placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipped()
                        .padding(.top)
                    
                    Button("Add Photo") {
                        
                    }
                }
                
                Form {
                    TextField("Name", text: $contact.name)
                    
                    HStack {
                        TextField("Date of Birth", text: $contact.dobString)
                            .disabled(true)
                        
                        Button(action: {
                            showCalendar = true
                        }, label: {
                            Image(systemName: "calendar")
                        })
                            .buttonStyle(.borderless)
                            .sheet(isPresented: $showCalendar, content: {
                                CalendarView(dobString: $contact.dobString)
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
                            .foregroundColor(.gray)
                        
                        TextEditor(text: $contact.address)
                            .frame(height: 90)
                            .border(.gray)
                    }
                }
            }
            .navigationTitle("\(operation == .add ? "New" : "Edit") Contact")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var saveButton: some View {
        Button("Save") {
            contact.save()
            
            if !contact.hasError {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .alert("Error", isPresented: $contact.hasError, presenting: contact.errorMessage, actions: { error in
            
        }, message: { error in
            Text(error)
        })
    }
}

struct ContactEditView_Previews: PreviewProvider {
    static let manager = CoreDataManager(preview: true)
    
    static var previews: some View {
        ContactEditView(contact: ContactViewModel(), operation: .add)
    }
}
