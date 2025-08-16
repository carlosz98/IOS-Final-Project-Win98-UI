//
//  ContentView.swift
//  Win98App
//
//  Created by Zabala Alexander on 6/3/25.
//

import SwiftUI

// MARK: - Colors
// This section defines custom static properties on `Color` to encapsulate the specific
// RGB values for the Windows 98 color palette. This makes it easy to reuse these
// colors throughout the application and maintain a consistent theme.
extension Color {
    static let win98Background = Color(red: 0.75, green: 0.75, blue: 0.75) // Light gray
    static let win98DarkGray = Color(red: 0.5, green: 0.5, blue: 0.5)     // Darker gray for borders
    static let win98LightGray = Color(red: 0.9, green: 0.9, blue: 0.9)    // Lighter gray for highlights
    static let win98Blue = Color(red: 0.0, green: 0.0, blue: 0.66)       // Classic Windows blue (e.g., title bars)
    static let win98BorderDark = Color(red: 0.25, green: 0.25, blue: 0.25) // Even darker for inner border shadow
    static let win98BorderLight = Color(red: 0.95, green: 0.95, blue: 0.95) // Even lighter for inner border highlight

    // Adding the specific Windows 98 desktop teal color based on common references
    static let win98DesktopTeal = Color(red: 0.0, green: 0.5, blue: 0.5) // A common representation of Windows 98 desktop teal
}

// MARK: - Fonts
// Similar to colors, this section provides `Font` extensions to define the desired
// typography for different text elements, aiming for a pixelated or monospaced look.
// Fallback fonts are included in case custom fonts are not available.
extension Font {
    static let win98Title = Font.custom("PixelEmulator", size: 18) // Placeholder, you might need to import a custom font
    static let win98Body = Font.custom("PixelEmulator", size: 14)  // Placeholder
    static let win98Button = Font.custom("PixelEmulator", size: 16) // Placeholder
    static let win98Taskbar = Font.custom("PixelEmulator", size: 12) // Placeholder for taskbar text

    // Adjusted font size for desktop icon labels to be smaller
    static let win98SmallBody = Font.system(size: 13, design: .monospaced) // Changed to size 13

    // Fallback fonts if custom fonts are not loaded
    static let win98FallbackTitle = Font.system(.title3, design: .monospaced).weight(.bold)
    static let win98FallbackBody = Font.system(.body, design: .monospaced)
    static let win98FallbackButton = Font.system(.headline, design: .monospaced)
    static let win98FallbackTaskbar = Font.system(.caption, design: .monospaced)
}

// MARK: - Custom View Modifiers
// This is a crucial section for encapsulating the complex border logic that creates
// the iconic 3D raised and sunken effects of Windows 98 UI elements.
/// A view modifier for creating the classic sunken/raised border effect.
struct Win98BorderModifier: ViewModifier {
    var isSunken: Bool = false // True for sunken, false for raised

    func body(content: Content) -> some View {
        content
            .border(isSunken ? Color.win98BorderDark : Color.win98BorderLight, width: 1)
            .border(isSunken ? Color.win98DarkGray : Color.win98LightGray, width: 1)
            .background(Color.win98Background)
    }
}

extension View {
    /// Applies a raised Windows 98 style border.
    func win98RaisedBorder() -> some View {
        self.modifier(Win98BorderModifier(isSunken: false))
    }

    /// Applies a sunken Windows 98 style border (e.g., for text fields).
    func win98SunkenBorder() -> some View {
        self.modifier(Win98BorderModifier(isSunken: true))
    }
}

// MARK: - Custom Components (Examples)
// This section defines reusable SwiftUI views and styles that mimic specific
// Windows 98 UI elements, suchs as buttons and window title bars.

/// A custom button style mimicking Windows 98 buttons.
struct Win98ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.win98FallbackButton) // Use fallback font
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.win98Background)
            .foregroundColor(.black)
            .overlay(
                Rectangle()
                    .stroke(configuration.isPressed ? Color.win98BorderLight : Color.win98BorderDark, lineWidth: 1)
                    .offset(x: 1, y: 1) // Shadow effect
            )
            .overlay(
                Rectangle()
                    .stroke(configuration.isPressed ? Color.win98BorderDark : Color.win98BorderLight, lineWidth: 1)
                    .offset(x: -1, y: -1) // Highlight effect
            )
            .contentShape(Rectangle()) // Ensures the entire area is tappable
    }
}

/// A simple Windows 98-style window title bar.
struct Win98TitleBar: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.win98FallbackTitle) // Use fallback font
                .foregroundColor(.white)
                .padding(.leading, 8)
            Spacer()
            // Example window controls (can be made functional later)
            HStack(spacing: 1) {
                Button(action: {}) {
                    Text("—")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 18)
                        .background(Color.win98Background)
                        .win98RaisedBorder()
                }
                Button(action: {}) {
                    Text("□")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 18)
                        .background(Color.win98Background)
                        .win98RaisedBorder()
                }
                Button(action: {}) {
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
        .border(Color.black, width: 1) // Outer black border for the title bar
    }
}

/// A custom desktop icon component.
struct DesktopIcon: View {
    let title: String
    // Changed from systemImageName to imageName to accept custom asset names
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                // Now using Image(imageName) to load your custom PNGs
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32) // Fixed frame for the image

                Text(title)
                    .font(.win98SmallBody) // Using the adjusted smaller font
                    .fontWeight(.bold) // Re-added bold font weight
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 85) // Increased width to accommodate longer text
            .padding(5) // Individual padding for the icon's clickable area
            .contentShape(Rectangle()) // Makes the entire area is tappable
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to avoid default button styling
    }
}

// NEW: Custom ButtonStyle for the Start button using images
struct StartButtonImageStyle: ButtonStyle {
    let staticImageName: String
    let clickedImageName: String

    func makeBody(configuration: Configuration) -> some View {
        Image(configuration.isPressed ? clickedImageName : staticImageName)
            .resizable()
            .scaledToFit()
            .scaledToFill()
            .offset(y: 40)// Changed to scaledToFill to ensure it fills the frame
            .clipped() // Clip content that extends beyond the frame
            // Removed offset(y: 1) to allow correct vertical centering
            .contentShape(Rectangle()) // Ensures the entire image area is tappable
    }
}


// MARK: - Main Content View
struct ContentView: View {
    @State private var sweepOffset: CGFloat = -1.0 // Controls the vertical position of the sweep bar

    var body: some View {
        ZStack { // This is the main ZStack for the desktop content and effects
            // Main desktop background - now using the classic Windows 98 teal color
            Color.win98DesktopTeal.ignoresSafeArea()

            // NEW: VStack to contain all UI content and apply safeAreaPadding
            VStack(spacing: 0) { // Use spacing: 0 to avoid extra space between icon area and taskbar
                // Desktop Icons - Arranged in a VStack for vertical layout, aligned to top-left
                VStack(alignment: .leading) { // This is the outer VStack for the icons
                    VStack(alignment: .leading, spacing: 15) { // Vertical stacking of icons
                        // Icons should now align correctly as individual padding is removed
                        DesktopIcon(title: "My Computer", imageName: "icon1") {
                            print("My Computer clicked!")
                            // Add action to open My Computer window
                        }

                        DesktopIcon(title: "Music", imageName: "icon2") {
                            print("Projects clicked!")
                            // Add action to open Projects folder
                        }

                        DesktopIcon(title: "Web Browser", imageName: "icon3") {
                            print("Recycle Bin clicked!")
                            // Add action for Recycle Bin
                        }
                    }
                    .padding(.top, 70) // Overall padding from the top of the desktop
                    .padding(.leading, 5) // Adjusted overall padding from the left edge (was 10)

                    Spacer() // This Spacer pushes the inner VStack to the top
                }
                // Explicitly set frame to fill available space and align content to topLeading
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)


                // Taskbar at the bottom
                VStack {
                    Spacer() // Pushes taskbar to the bottom
                    HStack {
                        // Start Button - Now using custom image style
                        Button(action: {
                            print("Start button clicked!")
                            // Add action to open Start Menu
                        }) {
                            EmptyView() // The label is now handled by the custom ButtonStyle
                        }
                        .buttonStyle(StartButtonImageStyle(staticImageName: "win1", clickedImageName: "win2"))
                        // Explicit frame for the button to fit taskbar
                        .frame(width: 95, height: 28) // Increased width to 95, height kept at 28
                        .background(Color.win98Background) // Apply background for the button area
                        .win98RaisedBorder() // Apply the classic raised border
                        .padding(.leading, 5) // Add some leading padding to the button itself
                        .padding(.top, 0) // Adjusted top padding to remove vertical offset


                        // Separator line
                        Rectangle()
                            .fill(Color.win98DarkGray)
                            .frame(width: 1, height: 20)
                            .padding(.horizontal, 5)

                        // Quick Launch / Open Applications (placeholder)
                        Text("Running Apps / Quick Launch Area")
                            .font(.win98FallbackTaskbar)
                            .foregroundColor(.black)

                        Spacer() // Pushes items to the left

                        // System Tray (placeholder for clock, volume, etc.)
                        Text("12:00 AM") // Example time
                            .font(.win98FallbackTaskbar)
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.win98Background)
                            .win98SunkenBorder() // Sunken border for system tray area
                            .padding(.trailing, 5) // Padding from the right edge
                    }
                    .frame(height: 30) // Fixed height for the taskbar
                    .background(Color.win98Background)
                    .win98RaisedBorder() // Raised border for the taskbar itself
                }
            }
            .safeAreaPadding(.all) // NEW: Apply safeAreaPadding to the content VStack
            // Apply screen filter effects to the ZStack (the desktop content)
            .cornerRadius(10) // Subtle rounded corners for screen
            .overlay(
                // Dark vignette/filter effect
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.1)) // Subtle dark overlay
            )
            .shadow(radius: 5) // Subtle shadow to lift the screen from the bezel
            .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 0) // White glow effect

            // NEW: Scanline overlay for CRT effect
            // This creates subtle horizontal lines across the screen
            .overlay(
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ForEach(0..<Int(geometry.size.height / 2), id: \.self) { _ in
                            Rectangle()
                                .fill(Color.black.opacity(0.05)) // Very subtle black lines
                                .frame(height: 1)
                            Spacer(minLength: 1) // Space between scanlines
                        }
                    }
                }
            )

            // NEW: CRT Scanline Sweep Effect
            GeometryReader { geometry in
                let sweepBarHeight: CGFloat = 105 // Define the height of the sweep bar (updated to 105)
                // Calculate the full range of motion including the bar's height
                let totalSweepRange = geometry.size.height + sweepBarHeight
                // Map normalizedOffset from 0 to 1, where 0 is top-off-screen and 1 is bottom-off-screen
                let normalizedOffset = (sweepOffset + 1.0) / 2.0
                // Calculate yOffset to move the bar from top-off-screen to bottom-off-screen
                let yOffset = normalizedOffset * totalSweepRange - sweepBarHeight

                Rectangle()
                    .fill(Color.white.opacity(0.015)) // More transparent (was 0.03)
                    .frame(height: sweepBarHeight) // Use the defined height
                    .offset(y: yOffset) // Use the calculated offset
                    .animation(
                        .linear(duration: 6.0) // Slower sweep duration (was 4.0)
                        .repeatForever(autoreverses: false) // Repeats without going back up
                        .delay(9.0), // Adjusted delay for a total cycle of 15 seconds (6.0s sweep + 9.0s delay)
                        value: sweepOffset
                    )
                    .onAppear {
                        // Start the animation when the view appears
                        sweepOffset = 1.0 // Move from top (-1.0) to bottom (1.0)
                    }
            }

            // NEW: Film Grain Effect (subtle overlay)
            Rectangle()
                .fill(Color.gray)
                .opacity(0.01) // Very subtle opacity for the grain
                .blendMode(.overlay) // Blends with the underlying content
                .allowsHitTesting(false) // Ensures it doesn't block interactions
        }
        .ignoresSafeArea() // Apply ignoresSafeArea to the main ZStack
    }
}

#Preview {
    ContentView()
}
