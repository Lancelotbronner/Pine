//
//  MarkdownEditor.swift
//  Pine
//
//  Created by Christophe Bronner on 2025-01-26.
//  Copyright © 2025 Luka Kerr. All rights reserved.
//

import SwiftUI

struct MarkdownEditor: View {
	let document: MarkdownDocument

	var body: some View {
		MarkdownTextViewRepresentable()
	}
}

private struct MarkdownTextViewRepresentable: NSViewRepresentable {
	func makeNSView(context: Context) -> MarkdownTextView {
		let nsview = MarkdownTextView()
		nsview.delegate = context.coordinator
		nsview.allowsUndo = true
		nsview.isEditable = true
		nsview.usesFindBar = true
		nsview.isRichText = false
		nsview.isSelectable = true
		nsview.font = preferences.font
		nsview.drawsBackground = false
		nsview.autoresizingMask = [.width, .height]
		nsview.insertionPointColor = .gray
		nsview.isVerticallyResizable = true
		nsview.isHorizontallyResizable = false
		nsview.textContainerInset = NSSize(width: 10.0, height: 10.0)
		nsview.baseWritingDirection = preferences.writingDirection

		let touchBar = NSTouchBar()
		nsview.touchBar = touchBar

		let identifiers: [NSTouchBarItem.Identifier] = [.h1, .h2, .h3, .bold, .italic, .code, .math, .image]
		touchBar.delegate = context.coordinator
		touchBar.customizationIdentifier = .editorBar
		touchBar.defaultItemIdentifiers = identifiers
		touchBar.customizationAllowedItemIdentifiers = identifiers

		return nsview
	}

	func updateNSView(_ nsView: MarkdownTextView, context: Context) {

	}

	func makeCoordinator() -> Coordinator {
		Coordinator()
	}

	final class Coordinator: NSObject, NSTextViewDelegate, NSTouchBarDelegate { }
}

private extension MarkdownTextViewRepresentable.Coordinator {

	func textView(
		_ textView: NSTextView,
		shouldChangeTypingAttributes oldTypingAttributes: [String: Any] = [:],
		toAttributes newTypingAttributes: [NSAttributedString.Key: Any] = [:]
	) -> [NSAttributedString.Key: Any] {
		self.generatePreview()
		return newTypingAttributes
	}

	@IBAction func bold(sender: NSMenuItem) {
		markdownTextView.replace(left: "**", right: "**")
		reloadUI()
	}

	@IBAction func italic(sender: NSMenuItem) {
		markdownTextView.replace(left: "_", right: "_")
		reloadUI()
	}

	@IBAction func strikethrough(sender: NSMenuItem) {
		markdownTextView.replace(left: "~~", right: "~~")
		reloadUI()
	}

	@IBAction func code(sender: NSMenuItem) {
		markdownTextView.replace(left: "`", right: "`")
		reloadUI()
	}

	@IBAction func codeBlock(sender: NSMenuItem) {
		markdownTextView.replace(left: "```\n", right: "\n```", newLineIfSelected: true)
		reloadUI()
	}

	@IBAction func h1(sender: NSMenuItem) {
		markdownTextView.replace(left: "# ", atLineStart: true)
		reloadUI()
	}

	@IBAction func h2(sender: NSMenuItem) {
		markdownTextView.replace(left: "## ", atLineStart: true)
		reloadUI()
	}

	@IBAction func h3(sender: NSMenuItem) {
		markdownTextView.replace(left: "### ", atLineStart: true)
		reloadUI()
	}

	@IBAction func h4(sender: NSMenuItem) {
		markdownTextView.replace(left: "#### ", atLineStart: true)
		reloadUI()
	}

	@IBAction func h5(sender: NSMenuItem) {
		markdownTextView.replace(left: "##### ", atLineStart: true)
		reloadUI()
	}

	@IBAction func h6(sender: NSMenuItem) {
		markdownTextView.replace(left: "###### ", atLineStart: true)
		reloadUI()
	}

	@IBAction func math(sender: NSMenuItem) {
		markdownTextView.replace(left: "$", right: "$")
		reloadUI()
	}

	@IBAction func mathBlock(sender: NSMenuItem) {
		markdownTextView.replace(left: "$$\n", right: "\n$$", newLineIfSelected: true)
		reloadUI()
	}

	@IBAction func image(sender: NSMenuItem) {
		markdownTextView.replace(left: "![", right: "]()")
		reloadUI()
	}

	@IBAction func HTMLImage(sender: NSMenuItem) {
		markdownTextView.replace(left: "<img src=\"", right: "\" width=\"\">")
		reloadUI()
	}

	func touchBar(
		_ touchBar: NSTouchBar,
		makeItemForIdentifier identifier: NSTouchBarItem.Identifier
	) -> NSTouchBarItem? {
		let item = NSCustomTouchBarItem(identifier: identifier)

		switch identifier {
		case .h1:
			item.view = NSButton(title: "H1", target: self, action: #selector(h1))
			item.customizationLabel = "Heading 1"
			return item

		case .h2:
			item.view = NSButton(title: "H2", target: self, action: #selector(h2))
			item.customizationLabel = "Heading 2"
			return item

		case .h3:
			item.view = NSButton(title: "H3", target: self, action: #selector(h3))
			item.customizationLabel = "Heading 3"
			return item

		case .bold:
			guard let img = NSImage(named: NSImage.touchBarTextBoldTemplateName) else { return nil }
			item.view = NSButton(image: img, target: self, action: #selector(bold))
			item.customizationLabel = "Bold"
			return item

		case .italic:
			guard let img = NSImage(named: NSImage.touchBarTextItalicTemplateName) else { return nil }
			item.view = NSButton(image: img, target: self, action: #selector(italic))
			item.customizationLabel = "Italic"
			return item

		case .code:
			item.view = NSButton(title: "<>", target: self, action: #selector(codeBlock))
			item.customizationLabel = "Code Block"
			return item

		case .math:
			item.view = NSButton(title: "$$", target: self, action: #selector(mathBlock))
			item.customizationLabel = "Math Block"
			return item

		case .image:
			guard let img = NSImage(named: "Image") else { return nil }
			item.view = NSButton(image: img, target: self, action: #selector(image))
			item.customizationLabel = "Image"
			return item

		default:
			return nil
		}
	}

}
