//
//  ModelData.swift
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
import Observation

// create and observable object that structs can access
@Observable class ModelData {
    private init() { }
    
    static let shared = ModelData()
    
    // Creates a default profile
    var profile = Profile.default
    var ARview = ARView()
    var identifiedPerson = "None" //Aqui debe ser None
    var model  = try! VNCoreMLModel(for: FaceRecognizerFinal(configuration: .init()).model)
    
    // call the continuouslyUpdate function every half second
    var timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
        continuouslyUpdate()
    })
}

struct ColorPalette {
    let rojo = Color.init(red: 234/255, green: 0/255, blue: 41/255)
    let rojoClaro = Color.init(red: 255/255, green: 33/255, blue: 64/255)
    let gris = Color.init(red: 237/255, green: 237/255, blue: 237/255)
    let verde = Color.init(red: 0/255, green: 185/255, blue: 32/255)
    let c5 = Color.init(red: 119/255, green: 220/255, blue: 137/255)
    let barraBlanco = Color.init(red: 255/255, green: 255/255, blue: 255/255)
    let grisOscuro = Color.init(red: 100/255, green: 100/255, blue: 100/255)
}
