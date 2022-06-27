//
//  WeatherDiaryView.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 22.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryView: AnyObject {
    var delegate: WeatherDiaryDelegate { get }
    var onNewNoteTapped: (() -> Void)? { get set }
    func getData(data: [WeatherDiaryEntity])
}

final class WeatherDiaryView: UIView {
 
//MARK: - internal properties
    var delegate = WeatherDiaryDelegate()
    var data: [WeatherDiaryEntity]?
    var onNewNoteTapped: (() -> Void)?

//MARK: - private properties
    let tableView = UITableView()
    private let dataSource = WeatherDiaryViewDataSource()

//MARK: - init
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - private methods
private extension WeatherDiaryView {
    
    func setupUI() {
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.setupTable()
        self.configureTable()
    }
    
    func setupTable() {
        self.addSubview(self.tableView)
        self.tableView.backgroundColor = .clear
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configureTable () {
        self.tableView.delegate = self.delegate
        self.tableView.dataSource = self.dataSource
        self.tableView.separatorStyle = .none
        self.tableView.register(WeatherDiaryNoteCell.self, forCellReuseIdentifier: WeatherDiaryNoteCell.id)
    }
}

//MARK: - IWeatherDiaryView
extension WeatherDiaryView: IWeatherDiaryView {
    func getData(data: [WeatherDiaryEntity]) {
        self.dataSource.data = data
        self.tableView.reloadData()
    }
}
