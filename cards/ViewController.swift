//
//  ViewController.swift
//  cards
//
//  Created by Dhruvil Patel on 7/5/20.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    //var nameee:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
       // sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting=true
//        sceneView.autoenablesDefaultLighting = false;
//
//        let estimate: ARLightEstimate!
//        estimate = self.sceneView.session.currentFrame?.lightEstimate
//        let light: SCNLight!
//        light = sceneView.light
//        light.intensity = estimate.ambientIntensity
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack=ARReferenceImage.referenceImages(inGroupNamed: "cards", bundle: Bundle.main)
        {
        configuration.trackingImages=imageToTrack
        configuration.maximumNumberOfTrackedImages=2
            print("Images successfully added")
        }
        
    

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? { //this basically return 3d object (i.e "SCNNode") while it takes input "anchor" which is when new image is detected this func gets called
        let node=SCNNode()
        
       if let imageAnchor = anchor as? ARImageAnchor //means if anchor that is detected is image then only proceed further and make new plane on top of it
        {
         //  print(imageAnchor.referenceImage.name)
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents=UIColor(white: 1, alpha: 0.5) //this will make the new plane alittle bit transparent so that we can the card below
            let planeNode=SCNNode(geometry: plane) //this will make 3d plane on top of the card
            planeNode.eulerAngles.x = -.pi/2 //since plane that we are getting is vertical so we have to rotate it with x axis in anticlockwise direction in order to make it parallel with the card so rotate by -90
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "panda"{
                if let pokeScene=SCNScene(named: "art.scnassets/snorlaxx.scn")
                {
                    if let pokeNode=pokeScene.rootNode.childNodes.first //this will make a node to that pokescene which is our new 3-d mokel snorlax.scn
                    {
            
                        pokeNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(pokeNode)
                        
                       // Adding light to scene
                        let lightNode = SCNNode()
                        lightNode.light = SCNLight()
                        lightNode.light?.type = .omni
                        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
                        planeNode.addChildNode(lightNode)
                        
                        // 6: Creating and adding ambien light to scene
                        let ambientLightNode = SCNNode()
                        ambientLightNode.light = SCNLight()
                        ambientLightNode.light?.type = .ambient
                        ambientLightNode.light?.color = UIColor.darkGray
                        planeNode.addChildNode(ambientLightNode)
                    }
                }
                }
          if imageAnchor.referenceImage.name == "pikachu"
            {
                 if let pokeScene=SCNScene(named: "art.scnassets/pikachuu.scn")
                 {
                     if let pokeNode=pokeScene.rootNode.childNodes.first //this will make a node to that pokescene which is our new 3-d mokel snorlax.scn
                     {
                         //pokeNode.transform=SCNMatrix4MakeRotation(.pi/2, 1, 0, 0)
                         pokeNode.eulerAngles.x = .pi/2
                         planeNode.addChildNode(pokeNode)
                        
                        // Adding light to scene
                        let lightNode = SCNNode()
                        lightNode.light = SCNLight()
                        lightNode.light?.type = .omni
                        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
                        planeNode.addChildNode(lightNode)
                        
                        // 6: Creating and adding ambien light to scene
                        let ambientLightNode = SCNNode()
                        ambientLightNode.light = SCNLight()
                        ambientLightNode.light?.type = .ambient
                        ambientLightNode.light?.color = UIColor.darkGray
                        planeNode.addChildNode(ambientLightNode)
                     }
                 }
            }
            
        }
        
        
        
        
        
        return node
    }
}
