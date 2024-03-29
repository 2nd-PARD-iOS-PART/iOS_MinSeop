//
//  DetailViewController.swift
//  HW7
//
//  Created by 김민섭 on 2023/11/14.
//

import UIKit

// MARK: - 필요한 전역 변수 선언
var detailData: DataList?
let detailAge: UILabel = {
    let labels = UILabel()
    labels.text = "age: \(detailData!.age)"
    return labels
}()
let detailPart: UILabel = {
    let label = UILabel()
    label.text = "part: \(detailData!.part)"
    return label
}()

class DetailViewController: UIViewController {
    // 초기화 메소드_데이터 전달 시 필요한 필수함수
    init(data: DataList) {
        detailData = data
        super.init(nibName: nil, bundle: nil)
    }
    // 필수함수
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    func setUI() {
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = detailData?.name
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            return label
        }()
        let deleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Delete", for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
            return button
        }()
        let editButton: UIButton = {
            let button = UIButton()
            button.setTitle("Edit", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(editTappted), for: .touchUpInside)
            return button
        }()
        let imageData: UIImageView = {
            let img = UIImageView()
            if let urlString = detailData?.imgURL, let url = URL(string: urlString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            img.image = UIImage(data: data)
                        }
                    }
                }
            }
            img.contentMode = .scaleAspectFit
            return img
        }()
        
        view.addSubview(deleteButton)
        view.addSubview(nameLabel)
        view.addSubview(editButton)
        view.addSubview(imageData)
        view.addSubview(detailAge)
        view.addSubview(detailPart)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        imageData.translatesAutoresizingMaskIntoConstraints = false
        detailAge.translatesAutoresizingMaskIntoConstraints = false
        detailPart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageData.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageData.widthAnchor.constraint(equalToConstant: 300),
            imageData.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            detailAge.topAnchor.constraint(equalTo: imageData.bottomAnchor, constant: -10),
            detailAge.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            detailAge.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailAge.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailPart.topAnchor.constraint(equalTo: detailAge.topAnchor, constant: 50),
            detailPart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            detailPart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailPart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func deleteTapped() {
        let alert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: "삭제한 내용은 다시 되돌릴 수 없습니다.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            // 서버에서 해당 데이터를 삭제하기 위해 함수 호출
            deleteRequest(name: detailData!.name)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    @objc func editTappted() {
        let updateDataVC = UpdateViewController(data: detailData!)
        print("button tapped")
        // edit 버튼을 탭할 경우, 수정하기 위한 모달창 띄우기
        editRequest(with: detailData!.name, age: String(detailData!.age), part: detailData!.part)
        self.present(updateDataVC, animated: true, completion: nil)
    }
    
    func editRequest(with name: String, age: String, part: String) {
    }
}

