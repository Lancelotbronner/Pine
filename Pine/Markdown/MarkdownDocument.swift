//
//  MarkdownDocument.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-25.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

final class MarkdownDocument {


	init(data: Data) {

	}

	init() {
		
	}
}

extension UTType {
	static let markdown = UTType(importedAs: "net.daringfireball.markdown", conformingTo: .text)
}

extension MarkdownDocument: ReferenceFileDocument {
	static let readableContentTypes: [UTType] = [.markdown]

	convenience init(configuration: ReadConfiguration) throws {
		guard configuration.file.isRegularFile, let data = configuration.file.regularFileContents else {
			throw CocoaError(.fileReadCorruptFile)
		}
//		var options = AttributedString.MarkdownParsingOptions()
//		contents = try AttributedString(markdown: data, options: options, baseURL: nil)
		self.init(data: data)
	}

	func snapshot(contentType: UTType) throws -> Data {
		Data()
	}

	func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
		FileWrapper(regularFileWithContents: snapshot)
	}

}
