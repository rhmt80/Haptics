//import SwiftUI
//
//struct ContentView: View {
//    let hapticManager = HapticManager()
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 32) {
//                    header
//
//                    section(title: "🎛️ Basic Haptics", buttons: [
//                        ("Continuous Vibration", { hapticManager.playContinuousHaptic() }),
//                        ("Ramp-Up Feedback", { hapticManager.playRampUpHaptic() }),
//                        ("Pulse Sequence", { hapticManager.playPulseHaptic() }),
//                        ("Explosion / Impact", { hapticManager.playExplosionHaptic() }),
//                        ("Regular Heartbeat", { hapticManager.playHeartbeatHaptic() })
//                    ])
//
//                    section(title: "💓 Emotional Haptics", buttons: [
//                        ("💞 Hug", { hapticManager.playHugHaptic() }),
//                        ("🫀 Soft Heartbeat", { hapticManager.playSoftHeartbeatHaptic() }),
//                        ("🔥 Warmth", { hapticManager.playWarmthHaptic() }),
//                        ("😂 Laughter", { hapticManager.playLaughterHaptic() }),
//                        ("💔 Missing You", { hapticManager.playMissingYouHaptic() })
//                    ])
//
//                    Spacer(minLength: 40)
//                }
//                .padding()
//            }
//            .navigationTitle("Haptic Explorer")
//        }
//    }
//
//    // MARK: - UI Components
//
//    var header: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("🎧 Haptic Explorer")
//                .font(.largeTitle.bold())
//            Text("Tap a button to feel each haptic pattern.")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        .padding(.top, 20)
//    }
//
//    func section(title: String, buttons: [(String, () -> Void)]) -> some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text(title)
//                .font(.headline)
//                .padding(.bottom, 2)
//
//            ForEach(buttons, id: \.0) { title, action in
//                Button(action: action) {
//                    Text(title)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(.ultraThinMaterial)
//                        .cornerRadius(14)
//                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
//                }
//                .buttonStyle(.plain)
//            }
//        }
//    }
//}
//// MARK: - Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.light)
//        ContentView()
//            .preferredColorScheme(.dark)
//    }
//}

import SwiftUI

struct ContentView: View {
    let hapticManager = HapticManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    header
                    
                    // Basic Haptics Section
                    SectionView(title: "Basic Haptics") {
                        HapticButton(title: "Pulse", icon: "dot.radiowaves.left.and.right", action: hapticManager.playPulseHaptic)
                        HapticButton(title: "Regular Heartbeat", icon: "heart.fill", action: hapticManager.playHeartbeatHaptic)
                    }
                    
                    // Emotional Haptics Section
                    SectionView(title: "Emotional Haptics") {
                        HapticButton(title: "Hug", icon: "person.2.fill", action: hapticManager.playHugHaptic)
                        HapticButton(title: "Soft Heartbeat", icon: "heart.fill", action: hapticManager.playSoftHeartbeatHaptic)
                        HapticButton(title: "Warmth", icon: "flame.fill", action: hapticManager.playWarmthHaptic)
                        HapticButton(title: "Laughter", icon: "face.smiling.fill", action: hapticManager.playLaughterHaptic)
                        HapticButton(title: "Missing You", icon: "arrow.up.heart.fill", action: hapticManager.playMissingYouHaptic)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Haptic Explorer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Haptic Explorer")
                .font(.largeTitle.bold())
                .padding(.top, 8)
            Text("Experience carefully crafted haptic patterns")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - UI Components

struct SectionView<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
            
            VStack(spacing: 10) {
                content()
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            )
        }
    }
}

struct HapticButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 28, height: 28)
                    .foregroundColor(.accentColor)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.secondary.opacity(0.7))
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(GlassButtonStyle())
    }
}

struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
