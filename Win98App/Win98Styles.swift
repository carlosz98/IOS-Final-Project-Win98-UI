import SwiftUI

// This file contains shared SwiftUI extensions and components
// for creating a Windows 98 style UI.
// Both ContentView and MusicPlayerView (and other future views)
// should reference these definitions by importing this file.

// MARK: - Colors
extension Color {
    static let win98Background = Color(red: 0.75, green: 0.75, blue: 0.75) // Light gray
    static let win98DarkGray = Color(red: 0.5, green: 0.5, blue: 0.5)     // Darker gray for borders
    static let win98LightGray = Color(red: 0.9, green: 0.9, blue: 0.9)    // Lighter gray for highlights
    static let win98Blue = Color(red: 0.0, green: 0.0, blue: 0.66)      // Classic Windows blue (e.g., title bars)
    static let win98BorderDark = Color(red: 0.25, green: 0.25, blue: 0.25) // Even darker for inner border shadow
    static let win98BorderLight = Color(red: 0.95, green: 0.95, blue: 0.95) // Even lighter for inner border highlight

    static let win98DesktopTeal = Color(red: 0.0, green: 0.5, blue: 0.5) // A common representation of Windows 98 desktop teal
}

// MARK: - Fonts
extension Font {
    // Placeholder custom fonts - remember to import these into your Xcode project
    static let win98Title = Font.custom("PixelEmulator", size: 18)
    static let win98Body = Font.custom("PixelEmulator", size: 14)
    static let win98Button = Font.custom("PixelEmulator", size: 16)
    static let win98Taskbar = Font.custom("PixelEmulator", size: 12)

    static let win98SmallBody = Font.system(size: 11, design: .monospaced)

    // Fallback fonts if custom fonts are not loaded
    static let win98FallbackTitle = Font.system(.title3, design: .monospaced).weight(.bold)
    static let win98FallbackBody = Font.system(.body, design: .monospaced)
    static let win98FallbackButton = Font.system(.headline, design: .monospaced)
    static let win98FallbackTaskbar = Font.system(.caption, design: .monospaced)
}

// MARK: - Custom View Modifiers
struct Win98BorderModifier: ViewModifier {
    var isSunken: Bool = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .stroke(isSunken ? Color.win98BorderDark : Color.win98BorderLight, lineWidth: 1)
                    .offset(x: isSunken ? 1 : -1, y: isSunken ? 1 : -1)
            )
            .overlay(
                Rectangle()
                    .stroke(isSunken ? Color.win98BorderLight : Color.win98BorderDark, lineWidth: 1)
                    .offset(x: isSunken ? -1 : 1, y: isSunken ? -1 : 1)
            )
            .overlay(
                Rectangle()
                    .stroke(isSunken ? Color.win98DarkGray : Color.win98LightGray, lineWidth: 1)
            )
            .background(Color.win98Background)
    }
}

extension View {
    func win98RaisedBorder() -> some View {
        self.modifier(Win98BorderModifier(isSunken: false))
    }

    func win98SunkenBorder() -> some View {
        self.modifier(Win98BorderModifier(isSunken: true))
    }
}

// MARK: - Custom Components
struct Win98ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.win98FallbackButton)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.win98Background)
            .foregroundColor(.black)
            .overlay(
                Rectangle()
                    .stroke(configuration.isPressed ? Color.win98BorderDark : Color.win98BorderLight, lineWidth: 1)
                    .offset(x: 1, y: 1)
            )
            .overlay(
                Rectangle()
                    .stroke(configuration.isPressed ? Color.win98BorderLight : Color.win98BorderDark, lineWidth: 1)
                    .offset(x: -1, y: -1)
            )
            .contentShape(Rectangle())
    }
}

struct Win98TitleBar: View {
    let title: String
    let onClose: (() -> Void)? // Optional closure for closing the window

    var body: some View {
        HStack {
            Text(title)
                .font(.win98FallbackTitle)
                .foregroundColor(.white)
                .padding(.leading, 8)
            Spacer()
            HStack(spacing: 1) {
                Button(action: {}) { // Minimize
                    Text("—")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 18)
                        .background(Color.win98Background)
                        .win98RaisedBorder()
                }
                Button(action: {}) { // Maximize
                    Text("□")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 18)
                        .background(Color.win98Background)
                        .win98RaisedBorder()
                }
                Button(action: {
                    onClose?()
                }) { // Close
                    Text("X")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 18)
                        .background(Color.win98Background)
                        .win98RaisedBorder()
                }
            }
            .padding(.trailing, 2)
        }
        .frame(height: 24)
        .background(Color.win98Blue)
        .border(Color.black, width: 1)
    }
}

struct DesktopIcon: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                Text(title)
                    .font(.win98SmallBody)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 75)
            .padding(2)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct StartButtonImageStyle: ButtonStyle {
    let staticImageName: String
    let clickedImageName: String

    func makeBody(configuration: Configuration) -> some View {
        Image(configuration.isPressed ? clickedImageName : staticImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 95, height: 28)
            .contentShape(Rectangle())
    }
}

struct TaskbarIcon: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .padding(2)
    }
}
