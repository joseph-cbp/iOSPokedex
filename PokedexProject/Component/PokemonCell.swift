//
//  PokemonCell.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//

import UIKit

class PokemonCell: UITableViewCell {
    static let identifier = "PokemonCell"
    
    let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(.red)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var infoView: UIStackView = {
        let info = UIStackView(arrangedSubviews: [nameLabel, numberLabel])
        info.axis = .vertical
        info.spacing = 4
        info.translatesAutoresizingMaskIntoConstraints = false
        
        return info
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backGroundView)
        backGroundView.addSubview(pokemonImage)
        backGroundView.addSubview(infoView)
        
        contentView.backgroundColor = .systemBlue
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            backGroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backGroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backGroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            pokemonImage.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 2),
            pokemonImage.topAnchor.constraint(equalTo: backGroundView.topAnchor, constant: 2),
            pokemonImage.widthAnchor.constraint(equalToConstant: 90),
            pokemonImage.heightAnchor.constraint(equalToConstant: 90),
            
            infoView.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 8)
        ])
    }
    
    func configure(with pokemon: Pokemon){
        nameLabel.text = pokemon.name
        numberLabel.text = "#\(String(pokemon.number).extractPokemonNumber()!)"
        loadImage(url: pokemon.pokemonImage)
    }
    
    private func loadImage(url: String){
        
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    [weak self] in
                    self?.pokemonImage.image = image
                }
                
            }
            .resume()
        } else {
            print("não consigo converter")
        }
    }
}

