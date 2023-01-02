//
//  PersonalViewController.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import UIKit
import CommonUI
import Resources

final class PersonalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: PersonalViewOutput
    
    private lazy var avatarImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.contentMode = .center
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.image = Resources.Images.Personal.sampleAvatarImage
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnAvatarImageView))
        imageView.addGestureRecognizer(tap)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameTextView: UITextView = {
        let textView = UITextView()
        textView.text = Texts.Personal.whatsYourName
        textView.font = Fonts.title2()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var yourRecipesTab: ProfileTabView = {
        let tab = ProfileTabView(image: Images.Personal.personal,
                                 selectedImage: Images.Personal.personalSelected,
                                 text: Texts.Personal.yourRecipes)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTappingOnRecipesTab))
        tab.addGestureRecognizer(tapGestureRecognizer)
        return tab
    }()
    private lazy var favouritesTab: ProfileTabView = {
        let tab = ProfileTabView(image: Images.Personal.favourites,
                                 selectedImage: Images.Personal.favouritesSelected,
                                 text: Texts.Personal.favourites)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTappingOnFavouritesTab))
        tab.addGestureRecognizer(tapGestureRecognizer)
        return tab
    }()
    
    private lazy var tabsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yourRecipesTab, favouritesTab])
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var recipesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.register(SmallRecipeCollectionViewCell.self, forCellWithReuseIdentifier: SmallRecipeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    
    init(presenter: PersonalViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    @objc private func handleTapOnAvatarImageView() {
        present(avatarImagePicker, animated: true)
    }
    
    @objc private func handleTappingOnRecipesTab() {
        yourRecipesTab.isSelected = true
        favouritesTab.isSelected = false
    }
    
    @objc private func handleTappingOnFavouritesTab() {
        yourRecipesTab.isSelected = false
        favouritesTab.isSelected = true
    }
    
    private func setupView() {
        title = Texts.Personal.title
        view.backgroundColor = Colors.systemBackground
        
        yourRecipesTab.isSelected = true
        favouritesTab.isSelected = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        
        topView.addSubview(avatarImageView)
        topView.addSubview(usernameTextView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(tabsStackView)
        contentView.addSubview(recipesCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80),
            
            avatarImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topView.topAnchor),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            
            usernameTextView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameTextView.topAnchor.constraint(equalTo: topView.topAnchor),
            usernameTextView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            usernameTextView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            tabsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            tabsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            tabsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            tabsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            recipesCollectionView.topAnchor.constraint(equalTo: tabsStackView.bottomAnchor),
            recipesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension PersonalViewController: PersonalViewInput {
}

extension PersonalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        avatarImageView.image = image
        picker.dismiss(animated: true)
    }
}

extension PersonalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallRecipeCollectionViewCell.identifier, for: indexPath) as? SmallRecipeCollectionViewCell else {
            fatalError("Could not cast to `FilterCollectionViewCell` for indexPath \(indexPath) in cellForItemAt")
        }
//        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 2 - 24, height: view.frame.size.height * 0.25)
    }
}
