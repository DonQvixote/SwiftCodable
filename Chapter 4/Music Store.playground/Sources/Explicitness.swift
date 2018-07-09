// iTunes Search API 的搜过结果遵循 RIAA （美国唱片工业协会）的标准
// 更多信息请查看 http://itunes.apple.com/WebObjects/MZStore.woa/wa/parentalAdvisory

import Foundation

public enum Explicitness: String, Decodable {
    // 歌词或封面包含敏感内容
    case explicit
    
    // 敏感内容“净化版”歌词
    case cleaned
    
    // 没有敏感歌词
    case notExplicit
}
