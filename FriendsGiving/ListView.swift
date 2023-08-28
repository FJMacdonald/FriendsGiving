//
//  ListView.swift
//  FriendsGiving
//
//  Created by Francesca MACDONALD on 2023-08-28.
//

import SwiftUI
import AVFAudio

struct ListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var friendsVM: FriendsViewModel
    @State private var audioPlayer: AVAudioPlayer!

    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(friendsVM.friends) { friend in
                        NavigationLink {
                            DetailView(friend: friend)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(friend.name.capitalized)")
                                    .font(.title2)
                                Text("\(friend.bringing)")
                                    .font(.callout)
                            }
                        }
                    }
                    //.onDelete(perform: friendsVM.deleteFriend)
                    //short hand form of writing
                    .onDelete { atOffset in
                        friendsVM.friends.remove(atOffsets: atOffset)
                    }
                    //.onMove(perform: friendsVM.moveFriend)
                    //shorthand form of writiing
                    .onMove { fromOffsets, toOffset in
                        friendsVM.friends.move(fromOffsets: fromOffsets, toOffset: toOffset)
                    }
               }
            }
            .onAppear {
                playSound(soundFile: "gobble")
            }
            .navigationTitle("Friends")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(friend: Friend())
                }
            }
        }
    }


    func playSound(soundFile: String) {
        guard let soundFile = NSDataAsset(name: soundFile) else {
            print("😡 ERROR: could not read sound file")
            return
        }
        do {
            
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: could not create audioPlayer")
            return
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(FriendsViewModel())
    }
}
