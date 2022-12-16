//
//  ViewController.swift
//  AR Solar
//
//  Created by Parth Antala on 2022-12-13.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var i = true
    var textNode = SCNNode()
    var textDetailNode = SCNNode()
    var textDistanceNode = SCNNode()
    var textYearNode = SCNNode()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc
        func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            let location = gestureRecognize.location(in: sceneView)
            let hitResults = sceneView.hitTest(location, options: [:])

            // check that we clicked on at least one object
            if hitResults.count > 0 {
                // retrieved the first clicked object
                let tappedPiece = hitResults[0].node
                print(tappedPiece.name)
                setCard(tappedPiece: tappedPiece)
      
            }

        }
    
    func setCard(tappedPiece: SCNNode) {
        if tappedPiece.name == "earth" {
            
            let textGeometry = SCNText(string: "Earth", extrusionDepth: 1.0)
            
            textGeometry.firstMaterial?.diffuse.contents = UIColor.blue
            textGeometry.flatness = 0
            textNode = SCNNode(geometry: textGeometry)
            
            textNode.position = SCNVector3(
                tappedPiece.position.x, tappedPiece.position.y , tappedPiece.position.z + 0.04)
          
            textNode.scale = SCNVector3(0.002, 0.002, 0.002)
            textNode.eulerAngles.y = -.pi / 2
            sceneView.scene.rootNode.addChildNode(textNode)
            
            let textDetailGeometry = SCNText(string: "Diameter: 12,742 KM", extrusionDepth: 1.0)

            textDetailGeometry.firstMaterial?.diffuse.contents = UIColor.white
            textDetailGeometry.flatness = 0
            textDetailNode = SCNNode(geometry: textDetailGeometry)

            textDetailNode.position = SCNVector3(
                tappedPiece.position.x, tappedPiece.position.y + -0.01 , tappedPiece.position.z + 0.04)

            textDetailNode.scale = SCNVector3(0.001, 0.001, 0.001)
            textDetailNode.eulerAngles.y = -.pi / 2
            sceneView.scene.rootNode.addChildNode(textDetailNode)
            
            let textYearGeometry = SCNText(string: "Lenght of year: 365 Earth Days", extrusionDepth: 1.0)

            textYearGeometry.firstMaterial?.diffuse.contents = UIColor.white
            textYearGeometry.flatness = 0
            textYearNode = SCNNode(geometry: textYearGeometry)

            textYearNode.position = SCNVector3(
                tappedPiece.position.x, tappedPiece.position.y + -0.02 , tappedPiece.position.z + 0.04)

            textYearNode.scale = SCNVector3(0.001, 0.001, 0.001)
            textYearNode.eulerAngles.y = -.pi / 2
            sceneView.scene.rootNode.addChildNode(textYearNode)
            
            let textDistanceGeometry = SCNText(string: "Distance from sun: 91,484,821 MI ", extrusionDepth: 1.0)

            textDistanceGeometry.firstMaterial?.diffuse.contents = UIColor.white
            textDistanceGeometry.flatness = 0
            textDistanceNode = SCNNode(geometry: textDistanceGeometry)

            textDistanceNode.position = SCNVector3(
                tappedPiece.position.x, tappedPiece.position.y + -0.03 , tappedPiece.position.z + 0.04)

            textDistanceNode.scale = SCNVector3(0.001, 0.001, 0.001)
            textDistanceNode.eulerAngles.y = -.pi / 2
            sceneView.scene.rootNode.addChildNode(textDistanceNode)

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if i {
            if let touchLocation = touches.first?.location(in: sceneView) {
                let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
                
                if let hitResult = hitTestResults.first {
                    addSystem(at: hitResult)
                }
                
            }
            i = false
        }
    }
    
    func addSystem(at hitResult : ARHitTestResult) {
        let x: Float = 0.55
        let sun = SCNSphere(radius: 0.8 / 2)
        let sunMaterial = SCNMaterial()
        sunMaterial.diffuse.contents = UIImage(named: "art.scnassets/sun.jpg")
        sun.materials = [sunMaterial]
        sun.name = "sun"
        let sunNode = SCNNode(geometry: sun)
        sunNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        sunNode.name = "sun"
        sceneView.scene.rootNode.addChildNode(sunNode)
    
        let mercury = SCNSphere(radius: 0.004879)
        let mercuryMaterial = SCNMaterial()
        mercuryMaterial.diffuse.contents = UIImage(named: "art.scnassets/mercury.jpg")
        mercury.materials = [mercuryMaterial]

        let mercuryNode = SCNNode(geometry: mercury)
        mercuryNode.name = "mercury"
        mercuryNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.038 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(mercuryNode)
        
        
        let venus = SCNSphere(radius: 0.009)
        let venusMaterial = SCNMaterial()
        venusMaterial.diffuse.contents = UIImage(named: "art.scnassets/venus.jpg")
        venus.materials = [venusMaterial]

        let venusNode = SCNNode(geometry: venus)
        venusNode.name = "venus"
        venusNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.072 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(venusNode)
        
        let earth = SCNSphere(radius: 0.01)
        let earthMaterial = SCNMaterial()
        earthMaterial.diffuse.contents = UIImage(named: "art.scnassets/earth.jpg")
        earth.materials = [earthMaterial]

        let earthNode = SCNNode(geometry: earth)
        earthNode.name = "earth"
        earthNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.1 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(earthNode)
        
        let mars = SCNSphere(radius: 0.005)
        let marsMaterial = SCNMaterial()
        marsMaterial.diffuse.contents = UIImage(named: "art.scnassets/mars.jpg")
        mars.materials = [marsMaterial]

        let marsNode = SCNNode(geometry: mars)
        marsNode.name = "mars"
        marsNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.15 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(marsNode)
        
        let jupiter = SCNSphere(radius: 0.11)
        let jupiterMaterial = SCNMaterial()
        jupiterMaterial.diffuse.contents = UIImage(named: "art.scnassets/jupiter.jpg")
        jupiter.materials = [jupiterMaterial]

        let jupiterNode = SCNNode(geometry: jupiter)
        jupiterNode.name = "jupiter"
        jupiterNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.52 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(jupiterNode)
        
        let saturn = SCNSphere(radius: 0.09)
        let saturnMaterial = SCNMaterial()
        saturnMaterial.diffuse.contents = UIImage(named: "art.scnassets/saturn.jpg")
        saturn.materials = [marsMaterial]
    
        let saturnNode = SCNNode(geometry: saturn)
        saturnNode.name = "saturn"
        saturnNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 0.95 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(saturnNode)
        
        let uranus = SCNSphere(radius: 0.04)
        let uranusMaterial = SCNMaterial()
        uranusMaterial.diffuse.contents = UIImage(named: "art.scnassets/uranus.jpg")
        uranus.materials = [uranusMaterial]

        let uranusNode = SCNNode(geometry: uranus)
        uranusNode.name = "uranus"
        uranusNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 1.92 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(uranusNode)
        
        let neptune = SCNSphere(radius: 0.03)
        let neptuneMaterial = SCNMaterial()
        neptuneMaterial.diffuse.contents = UIImage(named: "art.scnassets/neptune.jpg")
        neptune.materials = [neptuneMaterial]

        let neptuneNode = SCNNode(geometry: neptune)
        neptuneNode.name = "neptune"
        neptuneNode.position = SCNVector3(hitResult.worldTransform.columns.3.x + 3.01 + x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(neptuneNode)
        
        
    }
    
    private func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let touchLocation = sender.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        if !hitResults.isEmpty {
            
            guard let hitResult = hitResults.first else {
                return
            }
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
