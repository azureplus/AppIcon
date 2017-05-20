//
//  ImageExtractor.swift
//  AppIcon
//
//  Created by Takeshi Ihara on 2017/05/10.
//
//

import Foundation

public struct ImageExtractor: Extractor {
    public typealias T = (base: String, ipad: Bool)
    public typealias U = (iconName: String, path: String)

    public static func extract(input: T, output: U) throws {
        do {
            try Command.createDirectory(output: output.path).execute()

            for appIconSet in AppIcons.all(ipad: input.ipad) {
                try extract(input: input, output: output, iconSet: appIconSet)
            }
        } catch {
            throw LocalError.extraction
        }
    }

    private static func extract(input: T, output: U, iconSet: AppIconSet) throws {
        for icon in iconSet.all {
            try Command.extractImage(base: input.base, output: "\(output.path)/\(icon.name(iconName: output.iconName))", size: icon.size).execute()
        }
    }
}
