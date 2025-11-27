//
//  PokemonDetailViewController.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 14/06/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    var viewModel: PokemonDetailViewModel
    var url: URL
    
    let contentView: PokemonDetailView = {
        let view = PokemonDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailLabelView: PokemonDetailLabelView = {
       let view = PokemonDetailLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    private func setupUI() {
        view.addSubview(contentView)
        view.addSubview(detailLabelView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            detailLabelView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            detailLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailLabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchPokemonDetail()
    }
    
    init(url: URL) {
        
        self.viewModel = PokemonDetailViewModel(url: url)
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradient(pokemon: Detail) {
        let gradient = CAGradientLayer()
        
        let colors = pokemon.types.map { $0.getColor().cgColor }
        gradient.colors = colors
        gradient.startPoint = .init(x: 0.5, y: 0)
        gradient.endPoint = .init(x: 0.5, y: 1)
        gradient.type = .radial
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let gradient = view.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = view.bounds
        }
    }
    
    private func setupBackgroundColor(pokemon: Detail) {
        DispatchQueue.main.async { [weak self] in
            self?.view.backgroundColor = pokemon.types.first?.getColor()
        }
    }
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func didSuccessfullyFetchPokemonDetail(pokemon: Detail) {
        contentView.configure(detail: pokemon)
        detailLabelView.configure(detail: pokemon)
        setupBackgroundColor(pokemon: pokemon)
    }
    
    func didFailToFetchPokemonDetail(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
