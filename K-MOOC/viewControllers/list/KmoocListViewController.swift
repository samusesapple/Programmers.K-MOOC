import UIKit

class KmoocListViewController: UITableViewController {
    @IBOutlet var viewModel: KmoocListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
        let activity = UIActivityIndicatorView()
        view.addSubview(activity)
        activity.tintColor = .red
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activity.startAnimating()
        
        viewModel.needToStartIndicator = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        
        viewModel.lectureListFetched = { [weak self] in
            print("LectureListFetched")
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
        
        viewModel.needToStopIndicator = { [weak activity] in
            activity?.stopAnimating()
            activity?.isHidden = true
        }
        
        viewModel.list()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KmoocDetail",
           let lecture = sender as? Lecture,
           let detail = segue.destination as? KmoocDetailViewController {
            detail.viewModel.lectureId = lecture.id
            print("lecture ID - \(lecture.id)")
        }
    }
    
    // MARK: - Actions
    
    @objc func refreshTableView() {
        viewModel.list()
    }
    
}

// MARK: - tableView

extension KmoocListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.lecturesCount())
        return viewModel.lecturesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KmoocListItemTableViewCell.CellIdentifier) as! KmoocListItemTableViewCell
        let cellViewModel = KmoocListItemTableViewCellViewModel(lecture: viewModel.lecture(at: indexPath.row))
        cell.viewModel = cellViewModel
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lecture = viewModel.lecture(at: indexPath.row)
        performSegue(withIdentifier: "KmoocDetail", sender: lecture)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            print("다음 페이지 넘어감")
            viewModel.next()
        } else {
            print("스크롤 실패")
        }
    }
}
