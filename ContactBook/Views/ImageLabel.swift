import SwiftUI

struct ImageLabel: View {
    
    let title: String
    let systemImage: String
    
    var body: some View {
        Label(title, systemImage: systemImage)
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.blue)
            .cornerRadius(8)
    }
}

struct ImageLabel_Previews: PreviewProvider {
    static var previews: some View {
        ImageLabel(title: "Camera", systemImage: "camera")
    }
}
