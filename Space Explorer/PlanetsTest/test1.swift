import SwiftUI
import RealityKit
import ARKit
import Combine

enum PlanetKind {
    case earth
    case saturn
}

struct PlanetRealityView: UIViewRepresentable {
    let kind: PlanetKind

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Konfiguracja AR (świat 3D)
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)

        // ROOT – wspólny dla wszystkich planet (obracamy jego)
        let planetRoot = Entity()
        planetRoot.position = [0, 0, -1.2]

        switch kind {
        case .earth:
            buildEarth(into: planetRoot)
        case .saturn:
            buildSaturn(into: planetRoot)
        }

        let anchor = AnchorEntity(world: .zero)
        anchor.addChild(planetRoot)
        arView.scene.addAnchor(anchor)

        // Przekazujemy root do koordynatora
        context.coordinator.modelEntity = planetRoot

        // Gest obracania palcem
        let pan = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePan(_:))
        )
        arView.addGestureRecognizer(pan)

        // Auto-obrót
        context.coordinator.startAutoRotate(on: arView)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    // MARK: - Budowanie planet

    private func buildEarth(into root: Entity) {
        // kula Ziemi
        let mesh = MeshResource.generateSphere(radius: 0.8)

        var material = UnlitMaterial()
        if let image = UIImage(named: "earth_diffuse"),
           let cgImage = image.cgImage {
            let texture = try! TextureResource.generate(
                from: cgImage,
                options: .init(semantic: .color)
            )
            material.color = .init(texture: .init(texture))
        } else {
            material.color = .init(tint: .gray)
        }

        let earthEntity = ModelEntity(mesh: mesh, materials: [material])
        root.addChild(earthEntity)
    }

    private func buildSaturn(into root: Entity) {
        // --- KULA SATURNA ---
        let planetMesh = MeshResource.generateSphere(radius: 0.8)
        var planetMat = UnlitMaterial()

        if let image = UIImage(named: "saturn_diffuse"),
           let cgImage = image.cgImage {
            let texture = try! TextureResource.generate(
                from: cgImage,
                options: .init(semantic: .color)
            )
            planetMat.color = .init(texture: .init(texture))
        } else {
            planetMat.color = .init(tint: .gray)
        }

        let saturnSphere = ModelEntity(mesh: planetMesh, materials: [planetMat])

        // --- PIERŚCIEŃ ---
        let ringMesh = MeshResource.generatePlane(width: 2.4, depth: 2.4)
        var ringMat = UnlitMaterial()

        if let ringImg = UIImage(named: "saturn_ring"),
           let ringCg = ringImg.cgImage {
            let ringTex = try! TextureResource.generate(
                from: ringCg,
                options: .init(semantic: .color)
            )
            ringMat.color = .init(texture: .init(ringTex))
            ringMat.opacityThreshold = 0.1        // dziura z alpha w PNG
            ringMat.faceCulling = .none           // widoczny z obu stron
        } else {
            ringMat.color = .init(tint: UIColor.white.withAlphaComponent(0.3))
        }

        let ringEntity = ModelEntity(mesh: ringMesh, materials: [ringMat])

        // Plane jest w XZ, więc delikatny tilt (bardziej poziomo, ok. 15°)
        ringEntity.orientation = simd_quatf(angle: .pi / 12, axis: [1, 0, 0])
        ringEntity.position = [0, 0, 0]

        // --- SKŁADAMY SATURNA ---
        root.addChild(saturnSphere)
        root.addChild(ringEntity)
    }

    // MARK: - Koordynator

    class Coordinator: NSObject {
        weak var modelEntity: Entity?
        var updateCancellable: Cancellable?
        var rotationSpeed: Float = .pi / 20  // rad/s (im mniejsze, tym wolniej)

        // Auto-obrót – subskrypcja update’ów sceny
        func startAutoRotate(on arView: ARView) {
            updateCancellable = arView.scene.subscribe(to: SceneEvents.Update.self) { [weak self] event in
                guard let self = self,
                      let entity = self.modelEntity else { return }

                let angle = self.rotationSpeed * Float(event.deltaTime)
                let deltaRotation = simd_quatf(angle: angle, axis: [0, 1, 0])

                var transform = entity.transform
                transform.rotation = deltaRotation * transform.rotation
                entity.transform = transform
            }
        }

        // Obrót palcem
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard
                let view = gesture.view as? ARView,
                let entity = modelEntity
            else { return }

            let translation = gesture.translation(in: view)
            let sensitivity: Float = 0.005

            let deltaX = Float(translation.x) * sensitivity
            let deltaY = Float(translation.y) * sensitivity

            gesture.setTranslation(.zero, in: view)

            var transform = entity.transform

            let yaw = simd_quatf(angle: -deltaX, axis: [0, 1, 0])
            let pitch = simd_quatf(angle: -deltaY, axis: [1, 0, 0])

            transform.rotation = yaw * pitch * transform.rotation
            entity.transform = transform
        }
    }
}
