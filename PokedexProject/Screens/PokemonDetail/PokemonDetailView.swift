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
    
//    let detailLabel = PokemonDetailLabelView()
    
   private func setupLayout() {
//       detailLabel.layer.cornerRadius = 20
//       detailLabel.translatesAutoresizingMaskIntoConstraints = false
//       detailLabel.clipsToBounds = true
        addSubview(imageView)
//        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
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
    
    private func loadImage(url: URL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
                
            }
            .resume()
    }
    
    func configure(detail: Detail) {
        DispatchQueue.main.async {
//            self.detailLabel.nameLabel.text = detail.name
//            self.detailLabel.numberLabel.text = "#\(detail.id)"
            self.loadImage(url: detail.imageUrl)
        }
        
    }
}
