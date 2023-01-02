//
//  ProfileTabView.swift
//  Personal
//
//  Created by Егор Бадмаев on 30.12.2022.
//

import UIKit
import Resources

final class ProfileTabView: UIStackView {
    
    // MARK: - Public Properties
    
    public var isSelected = false {
        didSet {
            if isSelected {
                iconImageView.tintColor = Colors.appColor
                iconImageView.image = selectedImage
                titleLabel.textColor = Colors.appColor
            } else {
                iconImageView.tintColor = Colors.tertiaryLabel
                iconImageView.image = image
                titleLabel.textColor = Colors.tertiaryLabel
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var selectedImage: UIImage?
    private var image: UIImage?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.buttonTitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init(image: UIImage?, selectedImage: UIImage?, text: String) {
        super.init(frame: .zero)
        
        self.selectedImage = selectedImage
        self.image = image
        titleLabel.text = text
        
        addArrangedSubview(iconImageView)
        addArrangedSubview(titleLabel)
        axis = .horizontal
        spacing = 6
        distribution = .fillProportionally
//        alignment = .center
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
