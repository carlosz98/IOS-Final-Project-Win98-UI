//
//  MusicPlayerView.swift
//  Win98App
//
//  Created by Zabala Alexander on 6/3/25.
//

import SwiftUI

// MARK: - MusicPlayerView
struct MusicPlayerView: View {
    @Binding var isShowing: Bool // Binding to control the visibility of this window

    var body: some View {
        ZStack {
            Color.win98Background
                .cornerRadius(0)
                .shadow(radius: 5)

            VStack(spacing: 0) {
                // Use the shared Win98TitleBar component
                Win98TitleBar(title: "Music", onClose: {
                    isShowing = false // Dismiss the window
                })
                .padding(.bottom, 2)

                // Menu bar (File, Edit, View, Go, Help)
                HStack(spacing: 15) {
                    Text("File")
                    Text("Edit")
                    Text("View")
                    Text("Go")
                    Text("Help")
                    Spacer()
                }
                .font(.win98FallbackBody)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.win98Background)
                .border(Color.win98DarkGray, width: 1)
                .border(Color.win98LightGray, width: 1)

                // Main content area of the music player
                VStack(spacing: 10) {
                    // Placeholder for Album Art
                    Image("ffx_cover") // Assuming you'll add 'ffx_cover.jpg' to your Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .background(Color.win98DarkGray)
                        .border(Color.win98BorderDark, width: 2)
                        .border(Color.win98BorderLight, width: 2)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)

                    // Song Info (Id, Besald, FFX)
                    HStack {
                        Text("Id")
                            .font(.win98FallbackBody)
                            .padding(.horizontal, 5)
                            .frame(width: 50, alignment: .leading)
                            .win98SunkenBorder()
                        Text("Besald")
                            .font(.win98FallbackBody)
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .win98SunkenBorder()
                        Text("Besald") // Duplicate "Besald" from your original code
                            .font(.win98FallbackBody)
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .win98SunkenBorder()
                    }
                    .padding(.horizontal, 10)

                    Text("FFX") // Placeholder for album/track name
                        .font(.win98FallbackBody)
                        .padding(.horizontal, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .win98SunkenBorder()
                        .padding(.horizontal, 10)

                    // Playback Controls and Progress Bar
                    HStack(spacing: 10) {
                        Button(action: {}) {
                            Text("||")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 40, height: 25)
                                .background(Color.win98Background)
                                .win98RaisedBorder()
                        }
                        .buttonStyle(PlainButtonStyle())

                        Rectangle()
                            .fill(Color.win98DarkGray)
                            .frame(height: 8)
                            .overlay(
                                Rectangle()
                                    .fill(Color.win98Blue)
                                    .frame(width: 50, alignment: .leading)
                            )
                            .win98SunkenBorder()
                            .frame(maxWidth: .infinity)

                        Text("0:00/2:07")
                            .font(.win98FallbackTaskbar)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 10)

                    // Previous and Next Buttons
                    HStack(spacing: 10) {
                        Button(action: {}) {
                            Text("Previous")
                                .font(.win98FallbackButton)
                                .foregroundColor(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.win98Background)
                                .win98RaisedBorder()
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {}) {
                            Text("Next")
                                .font(.win98FallbackButton)
                                .foregroundColor(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.win98Background)
                                .win98RaisedBorder()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 10)
                }
                .background(Color.win98Background)
                .padding(.horizontal, 2)
                .padding(.bottom, 2)

                // Status Bar (484 object[s])
                HStack {
                    Text("484 object[s]")
                        .font(.win98FallbackTaskbar)
                        .foregroundColor(.black)
                        .padding(.horizontal, 5)
                    Spacer()
                }
                .frame(height: 20)
                .background(Color.win98Background)
                .win98SunkenBorder()
            }
            .border(Color.win98BorderDark, width: 2)
            .border(Color.win98BorderLight, width: 2)
        }
        .frame(width: 350, height: 500)
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView(isShowing: .constant(true))
    }
}
