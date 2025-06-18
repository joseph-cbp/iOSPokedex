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
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1)
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
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate{
    func didSuccessfullyFetchPokemonDetail(pokemon: Detail) {
        contentView.configure(detail: pokemon)
    }
    
    func didFailToFetchPokemonDetail(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}
