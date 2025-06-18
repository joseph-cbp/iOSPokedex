//
//  PokemonDetailView.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 14/06/25.
//
import UIKit
import Foundation

class PokemonDetailView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, numberLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
   private func setupLayout() {
        addSubview(imageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(url: String){
        
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    [weak self] in
                    self?.imageView.image = image
                }
                
            }
            .resume()
        } else {
            print("não consigo converter")
        }
    }
    
    func configure(detail: Detail) {
        DispatchQueue.main.async {
            self.nameLabel.text = detail.name
            self.numberLabel.text = "#\(detail.id)"
            self.loadImage(url: detail.imageUrl)
        }
        
    }
}
