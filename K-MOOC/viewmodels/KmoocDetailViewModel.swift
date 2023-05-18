import Foundation

class KmoocDetailViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!

    private var lecture = Lecture.EMPTY
    
    var lectureId: String = "" {
        didSet {
            detail()
        }
    }
    
    private func detail() {
        repository.detail(courseId: lectureId) { lecture in
            self.lecture = lecture
            self.configureUI()
            print(lecture.name)
        }
    }
    
    var configureUI: () -> Void = { }
    
    var getLectureInfo: Lecture {
        if lecture.classfyName.isEmpty {
            print("DeatilVM Lecture 비어있음")
        }
        return self.lecture
    }
    
    var getLectureAvailableDate: String {
        let startDate = DateUtil.formatDate(lecture.start)
        let endDate = DateUtil.formatDate(lecture.end)
        return "\(startDate) ~ \(endDate)"
    }
    
    var getLectureClassfyName: String {
        return "\(lecture.classfyName) / \(lecture.middleClassfyName)"
    }
}
