//
//  AudioVisualizationView.swift
//  GPTHelper
//
//  Created by DonHalab on 09.01.2024.
//

import UIKit

class AudioVisualizationView: UIView {
    let gptAnimate: UIImageView = {
        let gptAnimate = UIImageView()
        gptAnimate.image = UIImage(named: "gpt")
        gptAnimate.translatesAutoresizingMaskIntoConstraints = false
        return gptAnimate
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        addConstraint()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubview() {
        addSubview(gptAnimate)
    }

    func startAnimating() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.gptAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.gptAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    func stopAnimating() {
        gptAnimate.layer.removeAllAnimations()
    }

    func addConstraint() {
        NSLayoutConstraint.activate([
            gptAnimate.centerXAnchor.constraint(equalTo: centerXAnchor),
            gptAnimate.centerYAnchor.constraint(equalTo: centerYAnchor),
            gptAnimate.heightAnchor.constraint(equalToConstant: 200),
            gptAnimate.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
