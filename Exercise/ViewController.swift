//
//  ViewController.swift
//  Exercise
//

import UIKit

class ViewController: UIViewController {
	var onAbout: (() -> Void) = {}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let todoButton = UIButton(type: .system)
		todoButton.translatesAutoresizingMaskIntoConstraints = false
		todoButton.setTitle("TO-DO: #", for: .normal)
		todoButton.setTitleColor(.systemBlue, for: .normal)

		let aboutButton = UIButton(type: .system)
		aboutButton.translatesAutoresizingMaskIntoConstraints = false
		aboutButton.setTitle("About", for: .normal)
		aboutButton.setTitleColor(.systemBlue, for: .normal)
		aboutButton.addTarget(self, action: #selector(aboutButtonTap), for: .touchUpInside)

		let stackView = UIStackView(arrangedSubviews: [todoButton, aboutButton])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = 16

		view.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
		])
	}

	@objc private func aboutButtonTap() {
		onAbout()
	}
}
