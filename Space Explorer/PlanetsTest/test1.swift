import SwiftUI
import RealityKit
import Combine
import UIKit

enum PlanetVisual: Equatable {
    case standard
    case ringed
    
    init(from string: String) {
            switch string.lowercased() {
            case "ringed":
                self = .ringed
            default:
                self = .standard
            }
        }
}

struct PlanetRealityView: UIViewRepresentable {
    let planetId: String
    var visual: PlanetVisual = .standard

    var baseRadius: Float = 0.8
    var distance: Float = 1.2
    var rotationSpeed: Float = .pi / 20

    var planetDiameterFraction: CGFloat? = 0.75
    var scale: Float? = nil

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(
            frame: .zero,
            cameraMode: .nonAR,
            automaticallyConfigureSession: false
        )

        arView.environment.background = .color(.clear)
        arView.isOpaque = false
        arView.backgroundColor = .clear

        let anchor = AnchorEntity()
        let root = Entity()
        root.position = [0, 0, -distance]
        anchor.addChild(root)
        arView.scene.addAnchor(anchor)

        context.coordinator.root = root
        context.coordinator.rotationSpeed = rotationSpeed
        context.coordinator.build(planetId: planetId, visual: visual, radius: baseRadius)

        applySizing(on: arView, root: root)

        context.coordinator.startAutoRotate(on: arView)

        let pan = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePan(_:))
        )
        arView.addGestureRecognizer(pan)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        context.coordinator.rotationSpeed = rotationSpeed

        if let root = context.coordinator.root {
            root.position = [0, 0, -distance]
            context.coordinator.rebuildIfNeeded(planetId: planetId, visual: visual, radius: baseRadius)
            applySizing(on: uiView, root: root)
        }
    }

    static func dismantleUIView(_ uiView: ARView, coordinator: Coordinator) {
        coordinator.updateCancellable?.cancel()
        coordinator.updateCancellable = nil
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    private func applySizing(on arView: ARView, root: Entity) {
        if let scale {
            root.scale = [scale, scale, scale]
            return
        }

        guard let frac = planetDiameterFraction else {
            root.scale = [1, 1, 1]
            return
        }

        let clamped = max(0.25, min(frac, 0.95))
        let s = Float(clamped) * 1.35
        root.scale = [s, s, s]
    }

    final class Coordinator: NSObject {
        weak var root: Entity?
        var updateCancellable: Cancellable?
        var rotationSpeed: Float = .pi / 20

        private var currentPlanetId: String = ""
        private var currentVisual: PlanetVisual = .standard
        private var currentRadius: Float = 0.8

        func rebuildIfNeeded(planetId: String, visual: PlanetVisual, radius: Float) {
            guard planetId != currentPlanetId || visual != currentVisual || radius != currentRadius else { return }
            build(planetId: planetId, visual: visual, radius: radius)
        }

        func build(planetId: String, visual: PlanetVisual, radius: Float) {
            guard let root else { return }

            root.children.removeAll()

            let sphere = makeSphere(textureName: "\(planetId)_diffuse", radius: radius)
            root.addChild(sphere)

            if visual == .ringed {
                let ring = makeRing(textureName: "\(planetId)_ring")
                root.addChild(ring)
            }

            currentPlanetId = planetId
            currentVisual = visual
            currentRadius = radius
        }

        func startAutoRotate(on arView: ARView) {
            updateCancellable = arView.scene.subscribe(to: SceneEvents.Update.self) { [weak self] event in
                guard let self, let entity = self.root else { return }

                let angle = self.rotationSpeed * Float(event.deltaTime)
                let delta = simd_quatf(angle: angle, axis: [0, 1, 0])

                var t = entity.transform
                t.rotation = delta * t.rotation
                entity.transform = t
            }
        }

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let view = gesture.view as? ARView, let entity = root else { return }

            let translation = gesture.translation(in: view)
            let sensitivity: Float = 0.005

            let dx = Float(translation.x) * sensitivity
            let dy = Float(translation.y) * sensitivity

            gesture.setTranslation(.zero, in: view)

            var t = entity.transform
            let yaw = simd_quatf(angle: -dx, axis: [0, 1, 0])
            let pitch = simd_quatf(angle: -dy, axis: [1, 0, 0])

            t.rotation = yaw * pitch * t.rotation
            entity.transform = t
        }

        private func makeSphere(textureName: String, radius: Float) -> ModelEntity {
            let mesh = MeshResource.generateSphere(radius: radius)
            var mat = UnlitMaterial()

            if let cg = UIImage(named: textureName)?.cgImage {
                let tex = try! TextureResource.generate(from: cg, options: .init(semantic: .color))
                mat.color = .init(texture: .init(tex))
            } else {
                mat.color = .init(tint: .gray)
            }

            return ModelEntity(mesh: mesh, materials: [mat])
        }

        private func makeRing(textureName: String) -> ModelEntity {
            let mesh = MeshResource.generatePlane(width: 2.4, depth: 2.4)
            var mat = UnlitMaterial()

            if let cg = UIImage(named: textureName)?.cgImage {
                let tex = try! TextureResource.generate(from: cg, options: .init(semantic: .color))
                mat.color = .init(texture: .init(tex))
                mat.opacityThreshold = 0.1
                mat.faceCulling = .none
            } else {
                mat.color = .init(tint: UIColor.white.withAlphaComponent(0.3))
            }

            let ring = ModelEntity(mesh: mesh, materials: [mat])
            ring.orientation = simd_quatf(angle: .pi / 12, axis: [1, 0, 0])
            return ring
        }
    }
}
