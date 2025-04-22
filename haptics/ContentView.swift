import SwiftUI

struct ContentView: View {
    let hapticManager = HapticManager()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    header

                    section(title: "🎛️ Basic Haptics", buttons: [
                        ("Continuous Vibration", { hapticManager.playContinuousHaptic() }),
                        ("Ramp-Up Feedback", { hapticManager.playRampUpHaptic() }),
                        ("Pulse Sequence", { hapticManager.playPulseHaptic() }),
                        ("Explosion / Impact", { hapticManager.playExplosionHaptic() }),
                        ("Regular Heartbeat", { hapticManager.playHeartbeatHaptic() })
                    ])

                    section(title: "💓 Emotional Haptics", buttons: [
                        ("💞 Hug", { hapticManager.playHugHaptic() }),
                        ("🫀 Soft Heartbeat", { hapticManager.playSoftHeartbeatHaptic() }),
                        ("🔥 Warmth", { hapticManager.playWarmthHaptic() }),
                        ("😂 Laughter", { hapticManager.playLaughterHaptic() }),
                        ("💔 Missing You", { hapticManager.playMissingYouHaptic() })
                    ])

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .navigationTitle("Haptic Explorer")
        }
    }

    // MARK: - UI Components

    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🎧 Haptic Explorer")
                .font(.largeTitle.bold())
            Text("Tap a button to feel each haptic pattern.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 20)
    }

    func section(title: String, buttons: [(String, () -> Void)]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 2)

            ForEach(buttons, id: \.0) { title, action in
                Button(action: action) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
