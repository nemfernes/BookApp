//
//  SplashViewController.swift
//  BookApp
//
//  Created by Dmitry Kirpichev on 22.11.2023.
//

import UIKit
import SnapKit

protocol SplashViewControllerProtocol: AnyObject {
    func simulate()
}

class SplashViewController: UIViewController {

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash_background")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.splashPink
        label.font = UIFont(name: Font.georgiaBoldItalic, size: 52)
        label.text = "Book App"
        return label
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.splashGray
        label.font = UIFont(name: Font.nunitoSansBold, size: 24)
        label.text = "Welcome to Book App"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.progressBar
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 3
        return view
    }()
    
    var presenter: SplashPresenterProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
        self.presenter.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashViewController: Designable {
    func setupView() {
        
    }
    
    func addSubviews() {
        [
            backgroundImageView,
            titleLabel,
            headerLabel,
            containerView,
            progressView
        ].forEach(self.view.addSubview)
        
    }
    
    func makeConstraints() {
        self.backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.headerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(headerLabel.snp.top).inset(-12)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(6)
        }
        
        self.progressView.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(containerView)
            make.width.equalTo(10)
        }
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    
    func simulate() {
        let progressArray = [0.5, 1.0, 1.0]
        var count = 1
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {return}
            if (count == progressArray.count) {
                timer.invalidate()
                self.presenter.goToHome()
            }
            let width = Int(self.containerView.frame.width * progressArray[count - 1])
            let anim = UIViewPropertyAnimator(duration: 1.0, curve: UIView.AnimationCurve.linear, animations: { [weak self] in
                guard let self = self else {return}
                progressView.snp.updateConstraints { make in
                    make.width.equalTo(width)
                    }
                self.view.layoutIfNeeded()
            })
            anim.startAnimation()
            count += 1
        }
    }
}
