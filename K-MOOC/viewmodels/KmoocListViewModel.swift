import Foundation

class KmoocListViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!
    
    private var lectureList: LectureList = LectureList.EMPTY 
    
    var lectureListFetched: () -> Void = { }
    
    var needToStartIndicator: () -> Void = { }
    var needToStopIndicator: () -> Void = { }
    
    func lecturesCount() -> Int {
        return lectureList.lectures.count
    }

    func lecture(at index: Int) -> Lecture {
        return lectureList.lectures[index]
    }

    func list() {
        needToStartIndicator()
        repository.list {
            self.lectureList = $0
            self.lectureListFetched()
            self.needToStopIndicator()
        }
    }

    func next() {
        repository.next(currentPage: lectureList) {
            var lectureList = $0
            lectureList.lectures.insert(contentsOf: self.lectureList.lectures, at: 0)
            self.lectureList = lectureList
            self.lectureListFetched()
            self.needToStopIndicator()
        }
    }
}
