//
//  View+DetectOrientation.swift
//  pos
//
//  Created by Brian Chou on 2024/2/3.
//

import SwiftUI

extension View {
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View {
        modifier(DetectOrientation(orientation: orientation))
    }
}
