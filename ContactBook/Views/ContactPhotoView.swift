import SwiftUI

struct ContactPhotoView: View {
    var photo: UIImage? = nil
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        if let photo = photo {
            Image(uiImage: photo)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height, alignment: .center)
                .clipped()
        }
        else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height, alignment: .center)
                .opacity(0.3)
                .clipped()
        }
    }
}

struct ContactPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactPhotoView(width: 200, height: 200)
    }
}
