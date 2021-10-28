import SwiftUI
import ImagePicker

struct AddPhotoView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var vm = AddImageViewModel()
    @Binding var selectedPhoto: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        vm.showImagePicker(sourceType: .camera)
                    }, label: {
                        ImageLabel(title: "Camera", systemImage: "camera")
                    })
                    
                    Button(action: {
                        vm.showImagePicker(sourceType: .library)
                    }, label: {
                        ImageLabel(title: "Photos", systemImage: "photo")
                    })
                }
                .sheet(isPresented: $vm.showSheet) {
                    ImagePicker(sourceType: vm.sourceType, selectedImage: $vm.selectedImage)
                        .ignoresSafeArea()
                }
                .alert("Error", isPresented: $vm.hasError, presenting: vm.errorMessage, actions: { errorMessage in
                }, message: { errorMessage in
                    Text(errorMessage)
                })
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Add Photo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CancelButton, trailing: SelectButton)
        }
    }
    
    private var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var SelectButton: some View {
        Button("Select") {
            if vm.select() {
                selectedPhoto = vm.selectedImage
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var photo: UIImage?
    static var previews: some View {
        AddPhotoView(selectedPhoto: .constant(photo))
    }
}
