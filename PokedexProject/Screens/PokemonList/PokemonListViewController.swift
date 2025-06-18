//
//  PokemonListViewController.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//
import UIKit

class PokemonListViewController: UIViewController {
    private lazy var viewModel: PokemonListViewModel = .init()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 90
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view = tableView
        
        viewModel.fetchPokemons()
    }
}


extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemons[indexPath.row]
        print("Selecionado:", pokemon.name, pokemon.pokemonUrl ?? "sem URL")
        if let url = pokemon.pokemonUrl{
            navigationController?.pushViewController(PokemonDetailViewController(url: url), animated: false)
        }
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func didUpdatePokemonList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ message: String) {
        DispatchQueue.main.async {
            print("Erro ao carregar lista \(message)")
        }
    }
    
}

#Preview{
    PokemonListViewController()
}
