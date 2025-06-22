//
//  Untitled.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 22/06/25.
//

import UIKit

class PokemonStatusBar: UIView {
    private var baseStatus: Int = 0
    private var colorBar: UIColor = .clear
    
    let statusTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let baseStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.trackTintColor = .systemGray6
        progressView.progressTintColor = .systemBlue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let minStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let maxStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        addSubview(statusTitle)
        addSubview(baseStatusLabel)
        addSubview(statusBar)
        addSubview(minStatusLabel)
        addSubview(maxStatusLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            statusTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statusTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            baseStatusLabel.leadingAnchor.constraint(equalTo: statusTitle.trailingAnchor, constant: 12),
            baseStatusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maxStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            maxStatusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            minStatusLabel.trailingAnchor.constraint(equalTo: maxStatusLabel.leadingAnchor, constant: -8),
            minStatusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            statusBar.leadingAnchor.constraint(equalTo: baseStatusLabel.trailingAnchor, constant: 8),
            statusBar.trailingAnchor.constraint(equalTo: minStatusLabel.leadingAnchor, constant: -8),
            statusBar.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
        ])
    }
    
    init(){
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with status: StatusDetail, color: UIColor) {
        let (minStats, maxStats) = calculateMaximumAndMinimum(base: status.baseStat)
        statusTitle.text = status.name
        baseStatusLabel.text = "\(status.baseStat)"
        maxStatusLabel.text = "\(maxStats)"
        minStatusLabel.text = "\(minStats)"
        statusBar.progress = Float(status.baseStat) / Float(maxStats)
        statusBar.progressTintColor = color
        
    }
    
    private func calculateMaximumAndMinimum(base: Int) -> (Int, Int){
        
        /// Status = ((2 * Base + IV + (EV/4)) * Nível / 100) + Nível + 10
        let minValue = ((2 * base + 0 + (0 / 4)) * 100 / 100) + 100 + 10
        let maxValue = ((2 * base + 31 + (255 / 4)) * 100 / 100) + 100 + 10
        
        return (minValue, maxValue)
    }
}
