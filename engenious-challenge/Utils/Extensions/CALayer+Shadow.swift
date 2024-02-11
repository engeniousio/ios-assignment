//
//  CALayer+Shadow.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 11.02.2024.
//

import QuartzCore

extension CALayer {
    struct ShadowConfig {
        let opacity: Float
        let color: CGColor
        let offset: CGSize
        
        static var repoCellDropShadow: ShadowConfig {
            .init(
                opacity: 0.1,
                color: AppColor.blueColor.cgColor,
                offset: CGSize(width: 0, height: 5)
            )
        }
    }
    
    func shadow(config: ShadowConfig) {
        shadowColor = config.color
        shadowOpacity = config.opacity
        shadowOffset = config.offset
    }
}
