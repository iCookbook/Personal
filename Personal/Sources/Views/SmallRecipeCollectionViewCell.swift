//
//  SmallRecipeCollectionViewCell.swift
//  Personal
//
//  Created by Егор Бадмаев on 30.12.2022.
//

import UIKit
import Resources

final class SmallRecipeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.zPosition = 1
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    public let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.smallSemibold()
        label.textColor = .white
        label.layer.zPosition = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    public let recipeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.smallBody()
        label.textColor = .white
        label.layer.zPosition = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImageView.image = nil
        recipeTitleLabel.text = ""
        recipeSubtitleLabel.text = ""
    }
    
    public func setupView() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(blurEffectView)
        contentView.addSubview(recipeTitleLabel)
        contentView.addSubview(recipeSubtitleLabel)
        
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            recipeImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            blurEffectView.heightAnchor.constraint(equalToConstant: 60),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            recipeTitleLabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: layoutMargins.top),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: layoutMargins.left),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -layoutMargins.right),
            
            recipeSubtitleLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: layoutMargins.top / 2),
            recipeSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: layoutMargins.left),
            recipeSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -layoutMargins.right),
            
        ])
    }
    
    // MARK: - Public Methods
    
    public func configure(with data: RecipeEntity) {
        recipeImageView.setImage(by: data.imageData)
        recipeTitleLabel.text = data.title
        recipeSubtitleLabel.text = data.subtitle
    }
}
