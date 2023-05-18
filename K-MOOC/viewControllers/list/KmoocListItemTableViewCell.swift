import UIKit

class KmoocListItemTableViewCell: UITableViewCell {
    static let CellIdentifier = "LectureItem"
    
    var viewModel: KmoocListItemTableViewCellViewModel? {
        didSet {
            configureUI()
        }
    }
    
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var orgName: UILabel!
    @IBOutlet var duration: UILabel!

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        guard let viewModel = viewModel else { return }
        ImageLoader.loadImage(url: viewModel.thumbnail) { [weak self] image in
            self?.thumbnail.image = image
            self?.name.text = viewModel.name
            self?.orgName.text = viewModel.orgName
            self?.duration.text = viewModel.duration
        }
        
    }
}
