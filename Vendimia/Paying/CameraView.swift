//
//  CameraView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI
import RealityKit
import CoreML
import Vision
import SceneKit
import ARKit

struct CameraView: View {
    var modelData: ModelData = .shared
    let colorP = ColorPalette()
    
    var body: some View {
        ZStack(alignment: .center) {
            ARViewContainer()
                .ignoresSafeArea()
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var recogd: ModelData = .shared
    
    func makeUIView(context: Context) -> ARView {
        let v = recogd.ARview
        return v
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

func continuouslyUpdate() {
    let modelData: ModelData = .shared
    
    // access what we need from the observed object
    let v = modelData.ARview
    let sess = v.session
    let config = ARFaceTrackingConfiguration()
    sess.run(config)
    let mod = modelData.model
    
    // access the current frame as an image
    let tempImage: CVPixelBuffer? = sess.currentFrame?.capturedImage
    
    //get the current camera frame from the live AR session
    if tempImage == nil {
        return
    }
    
    let tempciImage = CIImage(cvPixelBuffer: tempImage!)
    
    // create a reqeust to the Vision Core ML Model
    let request = VNCoreMLRequest(model: mod) { (request, error) in }
    
    //crop just the center of the captured camera frame to send to the ML model
    request.imageCropAndScaleOption = .centerCrop
    
    // perform the request
    let handler = VNImageRequestHandler(ciImage: tempciImage, orientation: .right)
    
    do {
        //send the request to the model
        try handler.perform([request])
    } catch {
        print(error)
    }
    
    guard let observations = request.results as? [VNClassificationObservation] else { return}
    
    // only proceed if the model prediction's confidence in the first result is greater than 90%
    if modelData.identifiedPerson != "None" { return }
    modelData.identifiedPerson = "None"
    if observations[0].confidence < 0.92  { return }
    
    // the model returns predictions in descending order of confidence
    // we want to select the first prediction, which has the higest confidence
    let topLabelObservation = observations[0].identifier
    
    let firstWord = topLabelObservation.components(separatedBy: [","])[0]
        
    if modelData.identifiedPerson != firstWord {
        DispatchQueue.main.async {
            modelData.identifiedPerson = firstWord
        }
    }
}


#Preview {
    CameraView()
}
