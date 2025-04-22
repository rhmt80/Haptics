import CoreHaptics

class HapticManager {
    private var engine: CHHapticEngine?

    init() {
        prepareEngine()
    }

    private func prepareEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics not supported on this device.")
            return
        }

        do {
            let newEngine = try CHHapticEngine()

            newEngine.stoppedHandler = { reason in
                print("Haptic engine stopped: \(reason.rawValue)")
            }

            newEngine.resetHandler = { [weak self] in
                print("Haptic engine reset — restarting...")
                do {
                    try self?.engine?.start()
                } catch {
                    print("Failed to restart haptic engine: \(error.localizedDescription)")
                }
            }

            try newEngine.start()
            self.engine = newEngine
        } catch {
            print("Haptic engine initialization failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Core Haptic Execution

    private func playPattern(_ events: [CHHapticEvent]) {
        guard let engine = engine else {
            print("Haptic engine is unavailable.")
            return
        }

        do {
            try engine.start() // no isRunning check needed
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Pattern error: \(error.localizedDescription)")
        }
    }

    // MARK: - Basic Haptics

    func playContinuousHaptic(duration: TimeInterval = 1.0, intensity: Float = 0.5) {
        let event = CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [.init(parameterID: .hapticIntensity, value: intensity),
                                               .init(parameterID: .hapticSharpness, value: 0.5)],
                                  relativeTime: 0,
                                  duration: duration)
        playPattern([event])
    }

    func playRampUpHaptic() {
        let events: [CHHapticEvent] = (0..<10).map { i in
            let time = Double(i) * 0.1
            return CHHapticEvent(eventType: .hapticTransient,
                                 parameters: [.init(parameterID: .hapticIntensity, value: Float(i) * 0.2),
                                              .init(parameterID: .hapticSharpness, value: Float(i) * 0.1)],
                                 relativeTime: time)
        }
        playPattern(events)
    }

    func playPulseHaptic() {
        let events = stride(from: 0, to: 1.0, by: 0.2).map { time in
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.9),
                                       .init(parameterID: .hapticSharpness, value: 1.0)],
                          relativeTime: time)
        }
        playPattern(events)
    }

    func playExplosionHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 1),
                                       .init(parameterID: .hapticSharpness, value: 1)],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.8),
                                       .init(parameterID: .hapticSharpness, value: 0.6)],
                          relativeTime: 0.1),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.6),
                                       .init(parameterID: .hapticSharpness, value: 0.3)],
                          relativeTime: 0.2)
        ]
        playPattern(events)
    }

    func playHeartbeatHaptic() {
        playSoftHeartbeatHaptic()
    }

    func playSoftHeartbeatHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5),
                                       .init(parameterID: .hapticSharpness, value: 0.3)],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.4),
                                       .init(parameterID: .hapticSharpness, value: 0.2)],
                          relativeTime: 0.25)
        ]
        playPattern(events)
    }

    // MARK: - Emotional Haptics

    func playHugHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.3),
                                       .init(parameterID: .hapticSharpness, value: 0.2)],
                          relativeTime: 0,
                          duration: 1.5),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.2),
                                       .init(parameterID: .hapticSharpness, value: 0.1)],
                          relativeTime: 1.6)
        ]
        playPattern(events)
    }

    func playWarmthHaptic() {
        let warmth = CHHapticEvent(eventType: .hapticContinuous,
                                   parameters: [.init(parameterID: .hapticIntensity, value: 0.2),
                                                .init(parameterID: .hapticSharpness, value: 0.1)],
                                   relativeTime: 0,
                                   duration: 2.0)
        playPattern([warmth])
    }

    func playLaughterHaptic() {
        let events = stride(from: 0.0, to: 1.0, by: 0.15).map { t in
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5),
                                       .init(parameterID: .hapticSharpness, value: 0.6)],
                          relativeTime: t)
        }
        playPattern(events)
    }

    func playMissingYouHaptic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.65),
                                       .init(parameterID: .hapticSharpness, value: 0.5)],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5),
                                       .init(parameterID: .hapticSharpness, value: 0.3)],
                          relativeTime: 1.0)
        ]
        playPattern(events)
    }
}
