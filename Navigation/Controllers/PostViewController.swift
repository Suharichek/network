//
//  PostViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit

enum AppConfiguration: String {
    case one =  "https://swapi.dev/api/films/1"
    case two = "https://swapi.dev/api/people/2"
    case three = "https://swapi.dev/api/vehicles/3"
}


class PostViewController: UIViewController {
    struct NetworkService {
        static func request(for configuration: AppConfiguration) {
            if let url = URL(string: configuration.rawValue) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if error == nil, let data = data, let response = response as? HTTPURLResponse {
                        print("\nDATA: \(String(decoding: data, as: UTF8.self))")
                        print("\nRESPONSE STATUS: \(response.statusCode)")
                        print("\nRESPONSE HEADER: \(response.allHeaderFields)")
                    } else {
                        print("\nLOCAL ERROR: \(error?.localizedDescription ?? "Unknown error")")
                        print("\nDEBUG ERROR: \(error.debugDescription)")
                    }
                }
                task.resume()
            }
        }
    }
    
    public struct Info: Codable {
        var userId: Int
        var id: Int
        var title: String
        var completed: Bool
    }
    
    public struct Planet: Codable {
        var name: String
        var rotationPeriod: String
        var orbitalPeriod: String
        var diameter: String
        var climate: String
        var gravity: String
        var terrain: String
        var surfaceWater: String
        var population: String
        var residents: [String]
        var films: [String]
        var created: String
        var edited: String
        var url: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case rotationPeriod = "rotation_period"
            case orbitalPeriod = "orbital_period"
            case diameter
            case climate
            case gravity
            case terrain
            case surfaceWater = "surface_water"
            case population
            case residents
            case films
            case created
            case edited
            case url
        }
    }
    
    final class InfoNetworkManager {
        static let shared = InfoNetworkManager()
        public var infoModel = Info(userId: 1, id: 20, title: "ullam nobis libero sapiente ad optio sint", completed: true)
        private let stringURL = "https://jsonplaceholder.typicode.com/todos/"
        public func urlSession() {
            if let url = URL(string: stringURL) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let unwrappedData = data {
                        do {
                            let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                            if let object = serializedDictionary as? [String: Any] {
                                self.infoModel.userId = object["userId"] as? Int ?? 0
                                self.infoModel.id = object["id"] as? Int ?? 0
                                self.infoModel.title = object["title"] as? String ?? "unknown"
                                self.infoModel.completed = object["completed"] as? Bool ?? false
                                print("DONE: \(self.infoModel.userId )")
                            }
                        }
                        catch let error {
                            print("ERROR: \(error.localizedDescription)")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    final class PlanetsNetworkManager {
        static let shared = PlanetsNetworkManager()
        private var isFetched = false
        private let stringURL = "https://swapi.dev/api/planets/1"
        public var planet: Planet?
        func fetchPlanetsData() {
            guard isFetched == false else { return }
            if let url = URL(string: stringURL){
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let unwrappedData = data {
                        do {
                            self.planet = try JSONDecoder().decode(Planet.self, from: unwrappedData)
                            self.isFetched = true
                        }
                        catch let error {
                            print("PLANET ERROR: \(error.localizedDescription)")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    private lazy var urlTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return textView
    }()
    
    private lazy var planetTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return textView
    }()
    
    private lazy var jokeButton: CustomButton = {
        let button = CustomButton (
            title: "Информация из ссылок",
            titleColor: .white,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = button
        self.view.addSubview(urlTextView)
        self.view.addSubview(jokeButton)
        self.view.addSubview(planetTextView)
        setupFeedLayout()
        jokeButton.tapAction = { [weak self] in
            guard self != nil else { return }
            NetworkService.request(for: .one)
            self?.jsonInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func openInfo(){
        let rootVC = InfoViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
    
    func jsonInfo() {
        urlTextView.text = InfoNetworkManager.shared.infoModel.title
        planetTextView.text = "Orbital period is \(PlanetsNetworkManager.shared.planet!.orbitalPeriod)"
    }
    
    private func setupFeedLayout() {
        urlTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(200)
            
        }
        
        jokeButton.snp.makeConstraints { make in
            make.top.equalTo(urlTextView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        planetTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jokeButton.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    class InfoViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "Информация"
            view.addSubview(buttonAlert)
            setupButton()
            buttonAlert.tapAction = { [weak self] in
                guard let self = self else { return }
                self.showAlertButtonTapped()
            }
        }
        @IBAction func showAlertButtonTapped() {
            let alert = UIAlertController(title: "ВнИмАнИе", message: "Шо то идет не так...", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Понято", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Непонято", style: UIAlertAction.Style.destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        private lazy var buttonAlert: CustomButton = {
            let button = CustomButton (
                title: "Открыть предупреждение",
                titleColor: .black,
                backColor: .systemIndigo,
                backImage: UIImage()
            )
            return button
        }()
        
        func setupButton(){
            buttonAlert.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
        }
    }
}


