//
//  MarkdownContentView.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI

struct MarkdownContentView: View {
	let document: MarkdownDocument

	var body: some View {
		NavigationSplitView {
			MarkdownSidebar(document: document)
		} detail: {

		}
		.toolbar {

		}
	}
}
