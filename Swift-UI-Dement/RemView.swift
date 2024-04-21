//
//  RemView.swift
//  Swift-UI-Dement
//
//  Created by Vasav Srivastava on 4/20/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct RemView: View {
    @State private var showImagePicker = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    @State private var description = ""
    @State private var showUploadComponents = true
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                // User information and avatar section
                HStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 69, height: 69)
                    VStack(alignment: .leading) {
                        Text("Good morning,")
                            .font(.system(size: 13))
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Text("Daffa Toldo!")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 10)
                .padding(.top, 1)
                
                // Title and description section with slight padding at the bottom for space
                VStack(alignment: .leading) {
                    Text("Reminiscence Therapy")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Text("Add pictures and an audio/text description")
                        .font(.system(size: 11))
                        
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                if selectedImage != nil && showUploadComponents {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: .infinity, height: .infinity)
                            .cornerRadius(20)
                        
                        TextField("Enter description here...", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color(.systemGray6))
                            .padding()
                    
                        Button(action: {
                                // Add your recording action here
                            }) {
                                Image(systemName: "mic.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24) // Set appropriate size for the icon
                                    .foregroundColor(.black) // Icon color
                            }
                            .background(Color.white)
                            .padding(15)
                            .cornerRadius(5)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                            .stroke(Color.gray, lineWidth: 2))
                    
                    Button (action: {
                            uploadPhoto()
                            showUploadComponents = false
                        }) {
                            Text("Upload Data")
                                .foregroundColor(.black)
                                .padding()
                                .frame(minWidth: 0, maxWidth: 150)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        
                        ForEach(retrievedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                    .cornerRadius(20)
                        }
                        
                        Button(action: {
                                showImagePicker = true
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 2)
                                        .frame(width: 180, height: 180)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                }
                                .padding()
                            }
                            .sheet(isPresented: $showImagePicker) {
                                    // Image picker would go here
                                    ImagePicker(selectedImage: $selectedImage, showImagePicker: $showImagePicker)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func uploadPhoto() {
        guard selectedImage != nil else {
            return
        }
        
        let storeRef = Storage.storage().reference()
        
        let imageData = selectedImage!.jpegData(compressionQuality: 1)
        
        guard imageData != nil else {
            return
        }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storeRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            if error == nil && metadata != nil {
                
                let db = Firestore.firestore()
                db.collection("Images").document().setData(["url": path]) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.retrievedImages.append(self.selectedImage!)
                        }
                    }
                }
            }
        }
    }

    func retrievePhotos() {
        let db = Firestore.firestore()
        
        db.collection("Images").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                for doc in snapshot!.documents {
                    paths.append(doc["url"] as! String)
                }
                
                for path in paths {
                    let storageRef = Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        if error == nil && data != nil {
                            if let image = UIImage(data: data!) {
                                
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
    struct RemView_Previews: PreviewProvider {
        static var previews: some View {
        RemView()
    }
}
