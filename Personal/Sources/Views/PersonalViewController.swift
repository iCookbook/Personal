//
//  PersonalViewController.swift
//  Personal
//
//  Created by Егор Бадмаев on 29.12.2022.
//

import UIKit
import CommonUI
import Resources
import Logger

final class PersonalViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: PersonalViewOutput
    
    /// Defines selected tab in `tabsStackView`.
    private var selectedTab = Tabs.personal
    
    /// Data to display.
    private var data = [RecipeEntity]()
    
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let topView = UIView()
    private let contentView = UIView()
    
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
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Texts.Personal.whatsYourName
        textField.font = Fonts.title2()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .allEditingEvents)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        layout.minimumLineSpacing = 16
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.layer.zPosition = 1
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        collectionView.register(SmallRecipeCollectionViewCell.self, forCellWithReuseIdentifier: SmallRecipeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let emptyDataLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = Fonts.subtitle()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let emptyDataImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()
    private lazy var emptyDataStackView: UIStackView = {
        let emptyDataStackView = UIStackView(arrangedSubviews: [emptyDataImageView, emptyDataLabel])
        emptyDataStackView.axis = .vertical
        emptyDataStackView.distribution = .equalCentering
        emptyDataStackView.spacing = 24
        emptyDataStackView.alignment = .center
        emptyDataStackView.translatesAutoresizingMaskIntoConstraints = false
        return emptyDataStackView
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
        hideKeyboardWhenTappedAround()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.fetchRecipes(for: selectedTab)
    }
    
    // MARK: - Private Methods
    
    @objc private func handleTapOnAvatarImageView() {
        present(avatarImagePicker, animated: true)
    }
    
    @objc private func handleTappingOnRecipesTab() {
        selectedTab = .personal
        onChangingTabEventHandler()
    }
    
    @objc private func handleTappingOnFavouritesTab() {
        selectedTab = .favourites
        onChangingTabEventHandler()
    }
    
    @objc private func addNewRecipe() {
        presenter.openRecipeFormModule()
    }
    
    private func onChangingTabEventHandler() {
        emptyDataLabel.text = nil
        emptyDataImageView.image = nil
        presenter.fetchRecipes(for: selectedTab)
        yourRecipesTab.isSelected = selectedTab == .personal
        favouritesTab.isSelected = selectedTab == .favourites
    }
    
    private func turnOnEmptyMode() {
        emptyDataLabel.text = selectedTab.emptyDataDescription
        emptyDataImageView.image = UIImage(data: selectedTab.emptyDataImage ?? Data())
        
        if !scrollView.subviews.contains(emptyDataStackView) {
            scrollView.addSubview(emptyDataStackView)
            
            NSLayoutConstraint.activate([
                emptyDataImageView.heightAnchor.constraint(equalToConstant: 120),
                emptyDataImageView.widthAnchor.constraint(equalToConstant: 120),
                
                emptyDataStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                emptyDataStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                emptyDataStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                emptyDataStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 24),
            ])
        }
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRecipe))
        title = Texts.Personal.title
        view.backgroundColor = Colors.systemBackground
        
        yourRecipesTab.isSelected = selectedTab == Tabs.personal
        favouritesTab.isSelected = selectedTab == Tabs.favourites
        
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(avatarImageView)
        topView.addSubview(usernameTextField)
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            
            usernameTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameTextField.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4),
            usernameTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            
            contentView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            tabsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tabsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            tabsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            recipesCollectionView.topAnchor.constraint(equalTo: tabsStackView.bottomAnchor, constant: 16),
            recipesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - PersonalViewInput

extension PersonalViewController: PersonalViewInput {
    
    func showUserAvatar(_ data: Data) {
        avatarImageView.image = UIImage(data: data)
    }
    
    func showUserName(_ name: String) {
        usernameTextField.text = name
    }
    
    func updateRecipes(_ entities: [RecipeEntity]) {
        data = entities
        
        UIView.transition(with: recipesCollectionView, duration: 0.55, options: [.allowUserInteraction, .transitionCrossDissolve], animations: {
            self.recipesCollectionView.reloadData()
        })
        
        if data.isEmpty {
            turnOnEmptyMode()
        } else {
            emptyDataLabel.text = nil
            emptyDataImageView.image = nil
        }
    }
}

// MARK: - Collection View

extension PersonalViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallRecipeCollectionViewCell.identifier, for: indexPath) as? SmallRecipeCollectionViewCell else {
            fatalError("Could not cast to `FilterCollectionViewCell` for indexPath \(indexPath) in cellForItemAt")
        }
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRecipe(data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 2 - 24, height: view.frame.size.height * 0.225)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension PersonalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true)
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            Logger.log("Could not define edited image", logType: .error)
            return
        }
        avatarImageView.image = image
        
        guard let data = image.pngData() else {
            Logger.log("Could convert edited image in raw data", logType: .warning)
            return
        }
        presenter.saveUserAvatar(data)
    }
}

// MARK: - UITextFieldDelegate

extension PersonalViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// Limiting input to 120 characters.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 120
    }
    
    @objc private func textFieldDidChanged(sender: UITextField) {
        presenter.saveUserName(sender.text ?? "")
    }
}
