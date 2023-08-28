//
//  FriendsViewModel.swift
//  FriendsGiving
//
//  Created by Francesca MACDONALD on 2023-08-28.
//

import Foundation

@MainActor
class FriendsViewModel: ObservableObject {    
    @Published var friends: [Friend] = []
    init() {
        loadData()
    }
    func saveFriend(friend: Friend) {
        if friend.id == nil {
            var newFriend = friend
            newFriend.id = UUID().uuidString
            friends.append(newFriend)
        } else {
            if let index = friends.firstIndex(where: { $0.id == friend.id }) {
                friends[index] = friend
            }
        }
        saveData()
    }
    
    func deleteFriend(indexSet: IndexSet) {
        friends.remove(atOffsets: indexSet)
        saveData()
        
    }
    func moveFriend(fromOffsets: IndexSet, toOffset: Int) {
        friends.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
        
    }
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "Friends")
        let data = try? JSONEncoder().encode(friends) //try? means if an error is thrown, data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("😡 Error: Could not save data \(error.localizedDescription)")
        }
    }
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "Friends")
        guard let data = try? Data(contentsOf: path) else { return }
        do {
            friends = try JSONDecoder().decode(Array<Friend>.self, from: data)
        } catch {
            print("😡 Error: Could not load data \(error.localizedDescription)")
        }
    }
    //to get rid of data for the preview simulator (means you don't need to delete the app to simulate an empty app.
    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "Friends")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("😡 Error: Could not save data \(error.localizedDescription)")
        }
    }
}
