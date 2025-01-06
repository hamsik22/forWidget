//
//  ForWidgetExtensionBundle.swift
//  ForWidgetExtension
//
//  Created by 황석현 on 1/6/25.
//

import WidgetKit
import SwiftUI

@main
struct ForWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        ForWidgetExtension()
        ForWidgetExtensionControl()
        ForWidgetExtensionLiveActivity()
    }
}
