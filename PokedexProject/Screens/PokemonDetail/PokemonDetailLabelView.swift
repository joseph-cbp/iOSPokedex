//
//  PokemonDetailLabelView.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 18/06/25.
//

import UIKit

class PokemonDetailLabelView: UIView {
    
    let nameBackground: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .systemGray6
        uiView.clipsToBounds = true
        uiView.layer.cornerRadius = 15
        
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blue
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberBackground: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .systemGray6
        uiView.clipsToBounds = true
        uiView.layer.cornerRadius = 15
        
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .blue
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(nameBackground)
        addSubview(numberBackground)
        nameBackground.addSubview(nameLabel)
        numberBackground.addSubview(numberLabel)
        addSubview(statusStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            numberBackground.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            numberBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            numberBackground.heightAnchor.constraint(equalToConstant: 30),
            numberBackground.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            numberLabel.centerYAnchor.constraint(equalTo: numberBackground.centerYAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: numberBackground.centerXAnchor),
            
            nameBackground.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameBackground.leadingAnchor.constraint(equalTo: numberBackground.trailingAnchor, constant: 8),
            nameBackground.heightAnchor.constraint(equalToConstant: 30),
            nameBackground.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            nameLabel.centerYAnchor.constraint(equalTo: nameBackground.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: nameBackground.centerXAnchor),
            
            statusStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            statusStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
    
    private func populateStackView(with status: [StatusDetail], color: UIColor) {
        for stat in status {
            let statusView = PokemonStatusBar()
            statusView.configure(with: stat, color: color)
            statusStackView.addArrangedSubview(statusView)
        }
    }
    
    func configure(detail: Detail) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = detail.name
            self?.numberLabel.text = "#\(String(detail.id).extractPokemonNumber() ?? 000)"
            
            self?.populateStackView(with: detail.stats, color: detail.types.first?.getColor() ?? .gray)
        }
    }
}
