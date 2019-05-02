//
//  ViewController.swift
//  RealWorldTracking
//
//  Created by apple on 02/05/19.
//  Copyright © 2019 appsmall. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DebugOptions : It simply helps us to debug the app by showing us the world origin was properly detected
        // featurePoints :  are simply information about features in the world around you that the device detected. The device remembers all of that information to precisely pin point of position at all times.
        // worldOrigin : is your starting position in the real world. So, soon as you launch the app, the world tracking detects everything in your environment and keeps track of you started the starting position is your worldOrigin
        //
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin ]
        
        // The device will be able to track its position and orientation at all times.
        self.sceneView.session.run(configuration)
        
        // SceneKit automatically adds lights to a scene
        self.sceneView.autoenablesDefaultLighting = true
    }

    /*
        DIFFUSE: Represents the color across the entire surface about the box
        SCNVector3: Represents a 3-dimensional vector. We need a 3-dimensional vector, since the nodes position is based on 3 axis (x, y and z axis).
    */
    @IBAction func addNodeBtnPressed(_ sender: UIButton) {
        // SCNNode : It has no shape. no size and no color
        let node = SCNNode()
        
        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3 )
        //node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
        //node.geometry = SCNSphere(radius: 0.1)
        //node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.2, height: 0.3)
        //node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        //node.geometry = SCNPlane(width: 0.2, height: 0.2)
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        /*let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: (CGPoint(x: 0.2, y: 0.3)))
        path.addLine(to: (CGPoint(x: 0.4, y: 0.2)))
        path.addLine(to: (CGPoint(x: 0.4, y: 0)))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape*/
        
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        node.position = SCNVector3(x, y, z)
        
        node.position = SCNVector3(0.2, 0.3, -0.2)
        self.sceneView.scene.rootNode.addChildNode(node)
        
        // Adding Cylinder Node
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.position = SCNVector3(0, -0.05, 0)
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.addChildNode(boxNode)
        //self.sceneView.scene.rootNode.addChildNode(cylinderNode)
        
        // Adding SCNPlane for door node
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        boxNode.addChildNode(doorNode)
    }
    
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        self.restartSession()
    }
    
    func restartSession() {
        // It stops keeping track of your position and orientation
        self.sceneView.session.pause()
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            // Removes the SCNBox node from its parent’s array of child nodes
            node.removeFromParentNode()
        }
        
        // .resetTracking : The session does not continue device position/motion tracking from the previous configuration
        // .removeExistingAnchors : Any anchor objects associated with the session in its previous configuration are removed
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

