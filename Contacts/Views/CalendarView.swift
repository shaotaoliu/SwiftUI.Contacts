import SwiftUI

struct CalendarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var dobString: String
    @State private var dob: Date = Date()

    var body: some View {
        NavigationView {
            VStack() {
                DatePicker("", selection: $dob, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                
                Spacer()
            }
            .navigationTitle("Date of Birth")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CancelButton, trailing: AddButton)
            .onAppear() {
                if !dobString.isEmpty {
                    dob = dobString.toDate()!
                }
            }
        }
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var AddButton: some View {
        Button("Add") {
            dobString = dateFormatter.string(from: dob)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(dobString: .constant(""))
    }
}
