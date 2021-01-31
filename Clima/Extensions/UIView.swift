//
//  UIView.swift
//  Clima
//
//  Created by Денис Богданенко on 31.01.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    func animateRotation(duration: TimeInterval, repeat: Bool, completion: ((Bool) -> ())?) {

        var options = UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveLinear.rawValue)

        if `repeat` {
            options.insert(.repeat)
        }

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: options, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform(rotationAngle: 2*CGFloat.pi)
            })

        }, completion: completion)

    }

}
