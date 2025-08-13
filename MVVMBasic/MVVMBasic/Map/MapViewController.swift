//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

enum FoodType: String {
    case all = "전체"
    case korean = "한식"
    case western = "양식"
    case chinese = "중식"
    case japenese = "일식"
    case snack = "분식"
}

class MapViewController: UIViewController {
     
    let viewModel = MapViewModel()
    
    private let mapView = MKMapView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        setUpOutputClosure()
    }
    
    // 탭에서 해당 뷰에 들어가야 실행됨
    private func setUpOutputClosure() {
        // bind 에 closure 전달하면서 바로 실행될 수 있도록 매개변수 isfirstExecute에 true 값 전달
        viewModel.outputFoodList.lazyBind { restaurantList in
            self.removeAllAnnotations()
            self.addAnnotations(restaurantList: restaurantList)
        }
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.517768, longitude: 126.885785)
        let region = MKCoordinateRegion(
            center: centerCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func removeAllAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    private func addAnnotations(restaurantList: [Restaurant]) {
        for location in restaurantList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.name
            annotation.subtitle = location.address
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "전체", style: .default) { _ in
            print("전체 음식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.all
        }
        
        let alert2Action = UIAlertAction(title: "한식", style: .default) { _ in
            print("한식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.korean
        }
        
        let alert3Action = UIAlertAction(title: "양식", style: .default) { _ in
            print("양식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.western
        }
        
        let alert4Action = UIAlertAction(title: "중식", style: .default) { _ in
            print("중식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.chinese
        }
        
        let alert5Action = UIAlertAction(title: "일식", style: .default) { _ in
            print("일식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.japenese
        }
        
        let alert6Action = UIAlertAction(title: "분식", style: .default) { _ in
            print("분식이 선택되었습니다.")
            self.viewModel.inputFoodType.value = FoodType.snack
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(alert4Action)
        alertController.addAction(alert5Action)
        alertController.addAction(alert6Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
