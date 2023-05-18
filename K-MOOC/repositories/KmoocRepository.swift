import Foundation

class KmoocRepository: NSObject {
    /**
     * 국가평생교육진흥원_K-MOOC_강좌정보API
     * https://www.data.go.kr/data/15042355/openapi.do
     */

    private let httpClient = HttpClient(baseUrl: "http://apis.data.go.kr/B552881/kmooc")
    private let serviceKey =
        "XVxOMSZ70W298ghokOf%2FHLbcGN1dn%2BTIUo7VXeKn7RU5ulkaYWdxquve8NIbwvBLcb%2BT6096HColuycWG%2F20fg%3D%3D"

    func list(completed: @escaping (LectureList) -> Void) {
        httpClient.getJson(path: "/courseList",
                           params: ["serviceKey": serviceKey, "Mobile": 1]
        ) { [weak self] result in
            if let json = try? result.get() {
                guard let jsonObject = self?.getJSONObject(json: json) else { return }
                let paresedJSON = self?.parseLectureListJSON(json: jsonObject)
                completed(paresedJSON!)
            }
        }
    }

    func next(currentPage: LectureList, completed: @escaping (LectureList) -> Void) {
        let nextPageUrl = currentPage.next
        httpClient.getJson(path: nextPageUrl, params: [:]) { [weak self] result in
            if let json = try? result.get() {
                guard let jsonObject = self?.getJSONObject(json: json) else { return }
                let paresedJSON = self?.parseLectureListJSON(json: jsonObject)
                completed(paresedJSON!)
            }
        }
    }

    func detail(courseId: String, completed: @escaping (Lecture) -> Void) {
        httpClient.getJson(path: "/courseDetail",
                           params: ["CourseId": courseId, "serviceKey": serviceKey]) { [weak self] result in
            if let json = try? result.get() {
                guard let jsonObject = self?.getJSONObject(json: json),
                      let parsedJSON = self?.parseLectureJSON(json: jsonObject) else { return }
                completed(parsedJSON)
            }
        }
    }
    
    func getJSONObject(json: String) -> [String: Any] {
        let jsonData = json.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        return jsonObject
    }
    
    func parseLectureJSON(json: [String: Any]) -> Lecture {
        let image = (json["media"] as! [String: Any])["image"] as! [String: Any]
        let lecture = Lecture(id: json["id"] as? String ?? "",
                              number: json["number"] as? String ?? "",
                              name: json["name"] as? String ?? "",
                              classfyName: json["classfy_name"] as? String ?? "",
                              middleClassfyName: json["middle_classfy"] as? String ?? "",
                              courseImage: image["small"] as! String,
                              courseImageLarge: image["large"] as! String,
                              shortDescription: json["short_description"] as? String ?? "",
                              orgName: json["org_name"] as? String ?? "",
                              start: DateUtil.parseDate(json["start"] as? String ?? ""),
                              end: DateUtil.parseDate(json["end"] as? String ?? ""),
                              teachers: json["teachers"] as? String,
                              overview: json["overview"] as? String)
        return lecture
    }
    
    func parseLectureListJSON(json: [String: Any]) -> LectureList? {
        guard let pagination = json["pagination"] as? [String: Any] else { return nil }
        return LectureList(count: pagination["count"] as? Int ?? 0,
                                      numPages: pagination["numPages"] as? Int ?? 0,
                                      previous: pagination["previous"] as? String ?? "",
                                      next: pagination["next"] as? String ?? "",
                                      lectures: (json["results"] as! [[String: Any]]).map(parseLectureJSON))
         
    }
    
    
}
