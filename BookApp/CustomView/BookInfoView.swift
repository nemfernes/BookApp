import Foundation
import UIKit

class BookInfoView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansBold, size: 18)
        label.textColor = Color.textBlack
        label.textAlignment = .center
        return label
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.nunitoSansSemiBold, size: 12)
        label.textColor = Color.textGray
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }
    
    func setup(header: String, title: String) {
        self.titleLabel.text = header
        self.headerLabel.text = title
        
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookInfoView: Designable {
    func setupView() {
    }
    
    func addSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(headerLabel)
    }
    
    func makeConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        self.headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
}

