//
//  DetailView.swift
//  FriendsGiving
//
//  Created by Francesca MACDONALD on 2023-08-28.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var friendVM: FriendsViewModel
    @State var friend: Friend
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Name:")
                .font(.title2)
                .bold()
            TextField("Enter friend's name here", text: $friend.name)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Text("Bringing:")
                .font(.title2)
                .bold()
            TextField("Enter what your friend is bringing", text: $friend.bringing)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Text("Notes:")
                .font(.title2)
                .bold()
            TextField("Enter any notes like allergies, seating preferences here", text: $friend.notes)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    friendVM.saveFriend(friend: friend)
                    dismiss()
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(friend: Friend())
        }
    }
}
