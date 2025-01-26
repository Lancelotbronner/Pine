//
//  MarkdownDocument.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

struct MarkdownDocument {
	var contents: AttributedString

	init() {
		contents = AttributedString()
	}
}

extension UTType {
	static let markdown = UTType(importedAs: "net.daringfireball.markdown", conformingTo: .text)
}

extension MarkdownDocument: FileDocument {
	static let readableContentTypes: [UTType] = [.markdown]

	init(configuration: ReadConfiguration) throws {
		guard configuration.file.isRegularFile, let data = configuration.file.regularFileContents else {
			throw CocoaError(.fileReadCorruptFile)
		}
		var options = AttributedString.MarkdownParsingOptions()
		contents = try AttributedString(markdown: data, options: options, baseURL: nil)
	}
	
	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		let plain = contents.description.data(using: .utf8) ?? Data()
		return FileWrapper(regularFileWithContents: plain)
	}

}
