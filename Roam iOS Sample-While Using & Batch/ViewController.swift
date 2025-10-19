//
//  ViewController.swift
//  Roam iOS Sample-While Using & Batch
//
//  Created by Dinesh Kumar on 16/10/25.
//

import UIKit
import Roam
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Properties
    private let locationManager = CLLocationManager()

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Roam iOS Sample [While Using & Batch]"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request Location - While Using", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let startTrackingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Tracking", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        locationManager.delegate = self
        
        setupLayout()
        
        requestButton.addTarget(self, action: #selector(requestLocationPermission), for: .touchUpInside)
        startTrackingButton.addTarget(self, action: #selector(startTrackingAction), for: .touchUpInside)

    }

    // MARK: - Button Actions
    @objc private func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    @objc private func startTrackingAction() {
        if !Roam.isLocationTracking() {
            Roam.startTracking { message, error in
                if let message = message {
                    print("Tracking started: \(message)")
                } else if let error = error {
                    print("Error: \(error.message ?? "Unknown")")
                }
            }
        }
    }

    // MARK: - Layout Setup
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(requestButton)
        view.addSubview(startTrackingButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            requestButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestButton.widthAnchor.constraint(equalToConstant: 320),
            requestButton.heightAnchor.constraint(equalToConstant: 50),

            startTrackingButton.topAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: 20),
            startTrackingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTrackingButton.widthAnchor.constraint(equalTo: requestButton.widthAnchor),
            startTrackingButton.heightAnchor.constraint(equalTo: requestButton.heightAnchor)
        ])
    }
}
