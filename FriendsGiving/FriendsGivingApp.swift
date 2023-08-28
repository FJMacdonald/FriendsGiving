//
//  FriendsGivingApp.swift
//  FriendsGiving
//
//  Created by Francesca MACDONALD on 2023-08-28.
//

import SwiftUI

@main
struct FriendsGivingApp: App {
    @StateObject var friendsVM = FriendsViewModel()
    var body: some Scene {
        WindowGroup {
            
            ListView()
                .environmentObject(friendsVM)
        }
    }
}
