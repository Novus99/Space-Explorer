import SwiftUI
import RealityKit
import ARKit
import Combine

// Konfiguracja jednej planety
struct PlanetConfig {
    let name: String
    let radius: Float          // promień kuli
    let orbitRadius: Float     // odległość od Słońca
    let orbitSpeed: Float      // rad/s
    let selfRotationSpeed: Float // rad/s
    let textureName: String
    let hasRings: Bool
    let ringTextureName: String?
}

// „Instancja” planety w scenie
struct PlanetInstance {
    let config: PlanetConfig
    let orbitEntity: Entity      // pivot do ruchu planety po orbicie
    let planetEntity: ModelEntity
}

struct SolarSystemRealityView: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)

        // 👉 Kamera jakby „z góry pod delikatnym kątem”
        let anchor = AnchorEntity(world: [0, 0, -10])
        anchor.orientation = simd_quatf(angle: -.pi / 6, axis: [1, 0, 0]) // ok. -30° wokół X
        arView.scene.addAnchor(anchor)

        // ===== SŁOŃCE =====
        let sunMesh = MeshResource.generateSphere(radius: 0.6)
        var sunMaterial = UnlitMaterial()

        if let img = UIImage(named: "sun_diffuse"),
           let cg = img.cgImage {
            let tex = try! TextureResource.generate(from: cg,
                                                    options: .init(semantic: .color))
            sunMaterial.color = .init(texture: .init(tex))
        } else {
            sunMaterial.color = .init(tint: .yellow)
        }

        let sunEntity = ModelEntity(mesh: sunMesh, materials: [sunMaterial])
        anchor.addChild(sunEntity)

        // ===== PLANETY – konfiguracja „dużego” układu =====
        let planetsConfig: [PlanetConfig] = [
            PlanetConfig(
                name: "Mercury",
                radius: 0.15,
                orbitRadius: 1.2,
                orbitSpeed: .pi / 10,
                selfRotationSpeed: .pi / 6,
                textureName: "mercury_diffuse",
                hasRings: false,
                ringTextureName: nil
            ),
            PlanetConfig(
                name: "Venus",
                radius: 0.22,
                orbitRadius: 1.7,
                orbitSpeed: .pi / 16,
                selfRotationSpeed: .pi / 8,
                textureName: "venus_diffuse",
                hasRings: false,
                ringTextureName: nil
            ),
            PlanetConfig(
                name: "Earth",
                radius: 0.25,
                orbitRadius: 2.3,
                orbitSpeed: .pi / 20,
                selfRotationSpeed: .pi / 4,
                textureName: "earth_diffuse",
                hasRings: false,
                ringTextureName: nil
            ),
            PlanetConfig(
                name: "Mars",
                radius: 0.2,
                orbitRadius: 2.9,
                orbitSpeed: .pi / 24,
                selfRotationSpeed: .pi / 5,
                textureName: "mars_diffuse",
                hasRings: false,
                ringTextureName: nil
            ),
            PlanetConfig(
                name: "Jupiter",
                radius: 0.4,
                orbitRadius: 3.8,
                orbitSpeed: .pi / 32,
                selfRotationSpeed: .pi / 3,
                textureName: "jupiter_diffuse",
                hasRings: false,
                ringTextureName: nil
            ),
            PlanetConfig(
                name: "Saturn",
                radius: 0.35,
                orbitRadius: 4.6,
                orbitSpeed: .pi / 40,
                selfRotationSpeed: .pi / 3.5,
                textureName: "saturn_diffuse",
                hasRings: true,
                ringTextureName: "saturn_ring"
            )
        ]

        for config in planetsConfig {
            let instance = buildPlanet(config: config, in: anchor)
            context.coordinator.planets.append(instance)
        }

        context.coordinator.startAnimation(on: arView)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    // MARK: - Budowanie pojedynczej planety + orbity

    private func buildPlanet(config: PlanetConfig,
                             in anchor: AnchorEntity) -> PlanetInstance {

        // 1) STATYCZNA ORBITA – tylko ring, NIE kręci się z planetą
        let orbitRingMesh = MeshResource.generatePlane(
            width: config.orbitRadius * 2.0,
            depth: config.orbitRadius * 2.0
        )
        var orbitMat = UnlitMaterial()

        if let orbitImg = UIImage(named: "orbit_ring"),
           let orbitCg = orbitImg.cgImage {
            let orbitTex = try! TextureResource.generate(
                from: orbitCg,
                options: .init(semantic: .color)
            )
            orbitMat.color = .init(texture: .init(orbitTex))
            orbitMat.opacityThreshold = 0.1       // wykorzystanie alph kanału z PNG
            orbitMat.faceCulling = .none          // widoczne z obu stron
        } else {
            // Fallback – delikatny, półprzezroczysty dysk (ale raczej zawsze chcesz mieć orbit_ring)
            orbitMat.color = .init(tint: UIColor.white.withAlphaComponent(0.15))
            orbitMat.faceCulling = .none
        }

        let orbitVisual = ModelEntity(mesh: orbitRingMesh, materials: [orbitMat])
        orbitVisual.position = [0, 0.01, 0]       // minimalnie nad „zerem”, żeby uniknąć z-fightingu
        // 👇 KLUCZOWE: orbitVisual dodajemy bezpośrednio do anchor – będzie STAŁY
        anchor.addChild(orbitVisual)

        // 2) PIVOT ORBITALNY – TYLKO do ruchu planety
        let orbitEntity = Entity()
        orbitEntity.position = [0, 0, 0]
        anchor.addChild(orbitEntity)

        // 🟤 KULA PLANETY
        let mesh = MeshResource.generateSphere(radius: config.radius)
        var material = UnlitMaterial()

        if let img = UIImage(named: config.textureName),
           let cg = img.cgImage {
            let tex = try! TextureResource.generate(
                from: cg,
                options: .init(semantic: .color)
            )
            material.color = .init(texture: .init(tex))
        } else {
            material.color = .init(tint: .gray)
        }

        let planetEntity = ModelEntity(mesh: mesh, materials: [material])
        planetEntity.name = config.name

        // 🔥 LOSOWY START NA ORBICIE
        let angle = Float.random(in: 0..<(2 * Float.pi))
        let x = cos(angle) * config.orbitRadius
        let z = sin(angle) * config.orbitRadius
        planetEntity.position = [x, 0, z]

        // Planeta jest dzieckiem orbitEntity – pivot obraca planetę WZDŁUŻ stałej orbity
        orbitEntity.addChild(planetEntity)

        // 🪐 Saturn – pierścień wokół planety
        if config.hasRings, let ringTexName = config.ringTextureName {
            let ringMesh = MeshResource.generatePlane(
                width: config.radius * 4.0,
                depth: config.radius * 4.0
            )
            var ringMat = UnlitMaterial()

            if let ringImg = UIImage(named: ringTexName),
               let ringCg = ringImg.cgImage {
                let ringTexture = try! TextureResource.generate(
                    from: ringCg,
                    options: .init(semantic: .color)
                )
                ringMat.color = .init(texture: .init(ringTexture))
                ringMat.opacityThreshold = 0.1
                ringMat.faceCulling = .none
            } else {
                ringMat.color = .init(tint: UIColor.white.withAlphaComponent(0.3))
                ringMat.faceCulling = .none
            }

            let ringEntity = ModelEntity(mesh: ringMesh, materials: [ringMat])
            ringEntity.orientation = simd_quatf(angle: .pi / 12, axis: [1, 0, 0]) // lekki tilt
            ringEntity.position = [0, 0, 0]

            planetEntity.addChild(ringEntity)
        }

        return PlanetInstance(config: config,
                              orbitEntity: orbitEntity,
                              planetEntity: planetEntity)
    }

    // MARK: - Koordynator (animacje)

    class Coordinator: NSObject {
        var planets: [PlanetInstance] = []
        var updateCancellable: Cancellable?

        func startAnimation(on arView: ARView) {
            updateCancellable = arView.scene.subscribe(to: SceneEvents.Update.self) {
                [weak self] event in
                guard let self = self else { return }

                let delta = Float(event.deltaTime)

                for instance in self.planets {
                    // Ruch po orbicie – OBRACAMY TYLKO pivot orbitEntity
                    let orbitAngle = instance.config.orbitSpeed * delta
                    let orbitDelta = simd_quatf(angle: orbitAngle, axis: [0, 1, 0])

                    var orbitTransform = instance.orbitEntity.transform
                    orbitTransform.rotation = orbitDelta * orbitTransform.rotation
                    instance.orbitEntity.transform = orbitTransform

                    // Obrót wokół własnej osi – planeta się kręci
                    let selfAngle = instance.config.selfRotationSpeed * delta
                    let selfDelta = simd_quatf(angle: selfAngle, axis: [0, 1, 0])

                    var planetTransform = instance.planetEntity.transform
                    planetTransform.rotation = selfDelta * planetTransform.rotation
                    instance.planetEntity.transform = planetTransform
                }
            }
        }
    }
}
