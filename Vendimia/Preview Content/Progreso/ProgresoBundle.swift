//
//  ProgresoBundle.swift
//  Progreso
//
//  Created by iOS Lab on 24/04/24.
//

import WidgetKit
import SwiftUI

@main
struct ProgresoBundle: WidgetBundle {
    var body: some Widget {
        Progreso()
        ProgresoLiveActivity()
    }
}
