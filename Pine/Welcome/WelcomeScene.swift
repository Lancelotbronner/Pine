//
//  WelcomeScene.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI

struct WelcomeScene: Scene {
	var body: some Scene {
		Window("Welcome to Pine", id: "welcome") {
			SplashViewRepresentable()
		}
		.windowStyle(.hiddenTitleBar)
		.windowBackgroundDragBehavior(.enabled)
		//		window?.titleVisibility = .hidden
		//		window?.titlebarAppearsTransparent = true
		//		window?.isMovableByWindowBackground = true
	}
}

private struct SplashViewRepresentable: NSViewControllerRepresentable {
	func makeNSViewController(context: Context) -> NSSplashScreenViewController {
		NSSplashScreenViewController(environment: context.environment)
	}

	func updateNSViewController(_ nsView: NSSplashScreenViewController, context: Context) {
		
	}
}
