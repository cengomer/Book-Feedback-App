//
//  AddBookView.swift
//  Bookworm
//
//  Created by omer elmas on 11.06.2023.
//

import SwiftUI
import Combine

class ImageStore: ObservableObject {
    @Published var bookImage: UIImage? = nil
}
struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    @State private var showingImagePicker = false
    
    
    let genres = ["Fantasy","Horror","Kids","Mystrey","Poetry","Romance","Thriller"]
    @StateObject private var imageStore = ImageStore()

    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    HStack(spacing:60) {
                        if let image = imageStore.bookImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .clipShape(Circle())
                        }else {
                            Text("No Image Selected")
                                .foregroundColor(.secondary)
                        }
                        
                        Button(action: {
                            //open image picker
                            //set the seleceted image to the bookimage
                        }) {
                            Text("Upload Image")
                        } .onTapGesture {
                            //slecet an image
                            showingImagePicker = true
                        }
                    }
                 
              
                }
                Section {
                    
                    TextField("Name of book" , text: $title)
                    TextField("Author name" , text: $author)
                    
                    Picker("Genre" , selection: $genre) {
                        ForEach(genres , id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }header: {
                    Text("Write a review")
                }
                
                
                
                Section {
                    Button("Save"){
                        //ADD THE BOOK
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        
                        if let image = imageStore.bookImage {
                                //convert uiimage to data
                            
                            if let imageData = image.jpegData(compressionQuality: 0.8) {
                                newBook.imageData = imageData
                            }
                        }
                        
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                
                
            }
            .navigationTitle("Add Book")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $imageStore.bookImage)
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
