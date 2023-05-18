import UIKit
import WebKit

class KmoocDetailViewController: UIViewController {
    @IBOutlet var viewModel: KmoocDetailViewModel!

    @IBOutlet var lectureImage: UIImageView!
    @IBOutlet var lectureNumber: UILabel!
    @IBOutlet var lectureType: UILabel!
    @IBOutlet var lectureOrg: UILabel!
    @IBOutlet var lectureTeachers: UILabel!
    @IBOutlet var lectureDue: UILabel!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configureUI = { [weak self] in
            guard let lecture = self?.viewModel.getLectureInfo else { return }
            ImageLoader.loadImage(url: lecture.courseImageLarge) { [weak self] image in
                self?.lectureImage.image = image
                self?.lectureNumber.text = lecture.number
                self?.lectureType.text = self?.viewModel.getLectureClassfyName
                self?.lectureOrg.text = lecture.orgName
                self?.lectureTeachers.text = lecture.teachers
                self?.lectureDue.text = self?.viewModel.getLectureAvailableDate
                guard let urlString = lecture.overview else { return }
                self?.webView.loadHTMLString(urlString, baseURL: nil)
            }
        }
    }

}

