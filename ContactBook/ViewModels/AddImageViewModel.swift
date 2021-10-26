import SwiftUI
import ImagePicker

class AddImageViewModel: ViewModel {
    
    @Published var showCameraSheet = false
    @Published var selectedImage: UIImage? = nil
    @Published var sourceType = ImagePicker.SourceType.library
    
    func showImagePicker(sourceType: ImagePicker.SourceType) {
        if sourceType == .camera {
            do {
                try ImagePicker.checkCameraStatus()
            }
            catch {
                self.errorMessage = error.localizedDescription
                return
            }
        }
        
        self.sourceType = sourceType
        self.showCameraSheet = true
    }
    
    func select() -> Bool {
        if selectedImage == nil {
            errorMessage = "Please choose image"
            return false
        }
        
        return true
    }
}
