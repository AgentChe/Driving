//
//  ColorsPalette.swift
//  CDL
//
//  Created by Vitaliy Zagorodnov on 06.05.2021.
//

import UIKit

enum NavigationPalette {
    static let navigationBackground = UIColor(integralRed: 64, green: 116, blue: 110)
    static let navigationTint = UIColor.white
    static let navigationTrackTint = UIColor(integralRed: 51, green: 92, blue: 88)
    static let navigationProgressTint = UIColor.white
    static let tabTint = UIColor(integralRed: 64, green: 116, blue: 110)
    static let tabBarBackground = UIColor(integralRed: 246, green: 245, blue: 237)
}

enum TrophyPalette {
    static let background = UIColor(integralRed: 138, green: 171, blue: 197)
    static let title = UIColor.white
    static let buttonTint = UIColor.white
    static let buttonBackground = UIColor(integralRed: 64, green: 116, blue: 110)
}

enum StudyPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let primaryButton = UIColor(integralRed: 250, green: 210, blue: 133)
    static let secondaryButton = UIColor(integralRed: 51, green: 92, blue: 88)
    static let primaryButtonText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let secondaryButtonText = UIColor.white
    static let title = UIColor(integralRed: 51, green: 51, blue: 51)
    
    enum Brief {
        static let selected = UIColor(integralRed: 51, green: 92, blue: 88)
        static let text = UIColor.white
        static let selectedText = UIColor.white
        static let weekdayText = UIColor.white
    }
    
    enum Course {
        static let selected = UIColor(integralRed: 64, green: 116, blue: 110)
        static let deselected = UIColor(integralRed: 239, green: 238, blue: 229)
        static let title = UIColor(integralRed: 51, green: 51, blue: 51)
        static let subtitle = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
        static let selectedText = UIColor.white
        static let addCourse = UIColor(integralRed: 233, green: 233, blue: 226)
        static let progressText = UIColor(integralRed: 64, green: 116, blue: 110)
    }
    
    enum Mode {
        static let background = UIColor.white
        static let iconBackground = UIColor(integralRed: 64, green: 116, blue: 110)
        static let iconTint = UIColor.white
        static let markBackground = UIColor(integralRed: 250, green: 210, blue: 133)
        static let markText = UIColor(integralRed: 51, green: 51, blue: 51)
        static let title = UIColor(integralRed: 51, green: 51, blue: 51)
    }
}

enum ScorePalette {
    static let background = UIColor(integralRed: 250, green: 210, blue: 133)
    static let containerBackground = UIColor.white
    static let title = UIColor(integralRed: 51, green: 51, blue: 51)
    static let progress = UIColor(integralRed: 51, green: 51, blue: 51)
    static let progressWarning = UIColor(integralRed: 241, green: 104, blue: 91)
}

enum TestPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let primaryButton = UIColor(integralRed: 64, green: 116, blue: 110)
    static let secondaryButton = UIColor(integralRed: 224, green: 222, blue: 206)
    static let primaryTint = UIColor.white
    static let secondaryTint = UIColor(integralRed: 51, green: 51, blue: 51)
    static let questionText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let explanationTitle = UIColor(integralRed: 51, green: 51, blue: 51)
    static let explanationText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let bottomGradients = [UIColor.clear.cgColor, UIColor(integralRed: 246, green: 245, blue: 237).cgColor]
    
    enum Answer {
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
        static let selectedText = UIColor.white
        static let selectedBorder = UIColor(integralRed: 64, green: 116, blue: 110)
        static let initialBorder = UIColor(integralRed: 239, green: 238, blue: 229)
        static let warningBorder = UIColor(integralRed: 143, green: 207, blue: 99)
        static let initialBackground = UIColor.white
        static let incorrectBackground = UIColor(integralRed: 246, green: 105, blue: 105)
        static let correctBackground = UIColor(integralRed: 86, green: 172, blue: 131)
        static let warningBackground = UIColor(integralRed: 143, green: 207, blue: 99, alpha: 0.2)
    }
    
    enum QuestionNumber {
        static let background = UIColor.white
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
        static let selectedBackground = UIColor(integralRed: 64, green: 116, blue: 110)
        static let selectedText = UIColor.white
    }
}

enum CourseDetailsPalette {
    static let primaryButton = UIColor.white
    static let primaryTint = UIColor(integralRed: 64, green: 116, blue: 110)
    static let secondaryButton = UIColor(integralRed: 64, green: 116, blue: 110)
    static let secondaryTint = UIColor.white
    static let correctGradient = UIColor(integralRed: 86, green: 172, blue: 131)
    static let incorrectGradient = UIColor(integralRed: 246, green: 105, blue: 105)
    static let emptyGradient = UIColor(integralRed: 239, green: 238, blue: 229)
    static let title = UIColor(integralRed: 239, green: 238, blue: 229)
    static let subtitle = UIColor(integralRed: 51, green: 51, blue: 51)
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let itemBackground = UIColor.white
}

enum SettingsPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let itemBackground = UIColor.white
    static let itemTitle = UIColor(integralRed: 51, green: 51, blue: 51)
    static let buttonTint = UIColor(integralRed: 51, green: 51, blue: 51)
    static let unlockBackground = UIColor(integralRed: 250, green: 210, blue: 133)
    static let unlockTint = UIColor(integralRed: 51, green: 51, blue: 51)
    static let progress = UIColor(integralRed: 64, green: 116, blue: 110)
}

enum CoursePalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
}

enum PaygatePalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let continueButton = UIColor(integralRed: 64, green: 116, blue: 110)
    static let continueTint = UIColor.white
    static let primaryText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let secondaryText = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
    
    enum Option {
        static let selectedBackground = UIColor(integralRed: 64, green: 116, blue: 110)
        static let deselectedBorder = UIColor.white
        static let selectedText = UIColor.white
        static let deselectText = UIColor(integralRed: 51, green: 51, blue: 51)
        static let saveSelectedBackground = UIColor(integralRed: 250, green: 210, blue: 133)
        static let saveDeselectedBackground = UIColor(integralRed: 250, green: 210, blue: 133)
        static let saveSelectedText = UIColor(integralRed: 51, green: 51, blue: 51)
        static let saveDeselectedText = UIColor(integralRed: 51, green: 51, blue: 51)
    }
}

enum TestStatsPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let primaryButton = UIColor(integralRed: 64, green: 116, blue: 110)
    static let secondaryButton = UIColor(integralRed: 224, green: 222, blue: 206)
    static let primaryText = UIColor.white
    static let secondaryText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let correct = UIColor(integralRed: 86, green: 172, blue: 131)
    static let incorrect = UIColor(integralRed: 246, green: 105, blue: 105)
    static let passingScore = UIColor(integralRed: 51, green: 51, blue: 51)
    static let answerText = UIColor.white
    static let separator = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.05)
    
    enum Filter {
        static let selected = UIColor(integralRed: 51, green: 51, blue: 51)
        static let deselected = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.6)
    }
    
    enum CommunityResult {
        static let value = UIColor(integralRed: 51, green: 51, blue: 51)
        static let subtitle = UIColor(integralRed: 51, green: 51, blue: 51)
    }
    
    enum Progress {
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
    }
}

enum StatsPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let separator = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.05)
    
    enum Description {
        static let background = UIColor.white
        static let title = UIColor(integralRed: 51, green: 51, blue: 51)
        static let value = UIColor(integralRed: 51, green: 51, blue: 51)
    }
    
    enum Progress {
        static let testTaken = UIColor(integralRed: 64, green: 116, blue: 110)
        static let correctAnswers = UIColor(integralRed: 250, green: 210, blue: 133)
        static let questionsTaken = UIColor(integralRed: 229, green: 135, blue: 86)
    }
    
    enum MainStats {
        static let title = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
        static let value = UIColor(integralRed: 51, green: 51, blue: 51)
    }
}

enum Splash {
    static let background = UIColor(integralRed: 64, green: 116, blue: 110)
    static let primaryText = UIColor.white
    static let secondaryText = UIColor(integralRed: 250, green: 210, blue: 133)
}

enum FlashcardPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    
    enum Card {
        static let background = UIColor.white
        static let progress = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
        static let question = UIColor(integralRed: 51, green: 51, blue: 51)
        static let answer = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
        static let buttonTint = UIColor(integralRed: 51, green: 51, blue: 51)
        static let selectedButton = UIColor(integralRed: 64, green: 116, blue: 110)
        static let initialButton = UIColor(integralRed: 239, green: 238, blue: 229)
    }
}

enum TryAgainPalette {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let title = UIColor(integralRed: 51, green: 51, blue: 51)
    static let subTitle = UIColor(integralRed: 51, green: 51, blue: 51, alpha: 0.8)
    static let tryAgainButtonBackground = UIColor(integralRed: 64, green: 116, blue: 110)
}

enum Onboarding {
    static let background = UIColor(integralRed: 246, green: 245, blue: 237)
    static let primaryText = UIColor(integralRed: 51, green: 51, blue: 51)
    static let primaryButton = UIColor(integralRed: 64, green: 116, blue: 110)
    static let primaryButtonTint = UIColor.white
    static let pickerText = UIColor(integralRed: 51, green: 51, blue: 51)
    
    enum Goal {
        static let background = UIColor.white
        static let selectedBackground = UIColor(integralRed: 250, green: 210, blue: 133)
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
        static let selectedText = UIColor(integralRed: 51, green: 51, blue: 51)
    }
    
    enum Slider {
        static let minimumTrackTint = UIColor(integralRed: 234, green: 233, blue: 26)
        static let maximumTrackTint = UIColor(integralRed: 64, green: 116, blue: 110)
    }
    
    enum Preloader {
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
        static let progressTrack = UIColor(integralRed: 217, green: 215, blue: 202)
        static let progress = UIColor(integralRed: 254, green: 227, blue: 175)
    }
    
    enum Progress {
        static let track = UIColor(integralRed: 239, green: 238, blue: 229)
        static let progress = UIColor(integralRed: 64, green: 116, blue: 110)
    }
    
    enum Topics {
        static let text = UIColor(integralRed: 51, green: 51, blue: 51)
        static let selectedText = UIColor(integralRed: 51, green: 51, blue: 51)
        static let background = UIColor.white
        static let selectedBackground = UIColor(integralRed: 250, green: 210, blue: 133)
    }
}
