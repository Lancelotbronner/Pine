//
//  ApplicationModel.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-26.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI
import Combine

@Observable
final class ApplicationModel {
	let sidebar = SidebarSynchronizer()
}

final class SidebarSynchronizer: ObservableObject {
	let objectWillChange = ObservableObjectPublisher()
}

extension EnvironmentValues {
	@Entry var application = ApplicationModel()
}
