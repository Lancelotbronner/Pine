//
//  MarkdownScene.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI

struct MarkdownScene: Scene {
	var body: some Scene {
		DocumentGroup(newDocument: MarkdownDocument()) { configuration in
			
		}
		.commands {
			
		}
	}
}
