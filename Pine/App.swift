//
//  App.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI

@main
struct Pine: App {
	@State private var model = ApplicationModel()

	var body: some Scene {
		WelcomeScene()
			.environment(\.application, model)
		MarkdownScene()
			.environment(\.application, model)
	}
}
