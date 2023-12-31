//
//  DetailView.swift
//  Bookworm
//
//  Created by omer elmas on 11.06.2023.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let sharedImageStore = ImageStore()

    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                
                if let image = sharedImageStore.bookImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } else {
                    Text("No Image Selected")
                        .foregroundColor(.secondary)
                }
                
                
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5 , y:-5)
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?" , isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel" , role: .cancel){}
        } message: {
            Text("Are you sure u wanna delete these boook from you recently books ?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label : {
                    Label("Delete this book" , systemImage: "trash")
            }
        }
        
    }
    
    func deleteBook()  {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}
