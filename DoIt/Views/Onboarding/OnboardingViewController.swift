//
//  OnboardingViewController.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private struct UIConstants {
        static let topPaddingPageContol = 15.0
        static let bottomPaddingCollection = -100.0
        static let stackViewButtonsPadding = 5.0
    }
    
    private lazy var collectionView: UICollectionView = {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        let sizeCell = CGSize(width: view.bounds.width, height: view.bounds.height - (topPadding! + bottomPadding!) - UIConstants.topPaddingPageContol + UIConstants.bottomPaddingCollection)
        layout.itemSize = sizeCell
        layout.scrollDirection = .horizontal
        collection.isPagingEnabled = true
        layout.minimumLineSpacing = 1
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: "onboardingCell")
        return collection
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var previousButton = CustomRoundedButton(title: OnboardingStrings.backButton.rawValue.localized, target: self, action: #selector(pageControlButtonTaped(button:)), tag: 0, width: UIScreen.main.bounds.width / 3, color: UIColor.AppColors.cancelColor)
    private lazy var nextButton = CustomRoundedButton(title: OnboardingStrings.nextButton.rawValue.localized, target: self, action: #selector(pageControlButtonTaped(button:)), tag: 1, width: UIScreen.main.bounds.width / 3, color: UIColor.AppColors.accentColor)
    private lazy var exitButton = CustomRoundedButton(title: OnboardingStrings.exitButton.rawValue.localized, target: self, action: #selector(pageControlButtonTaped(button:)), tag: 2, width: UIScreen.main.bounds.width / 3, color: UIColor.AppColors.exitColor)
    
    private let onboarding = [Onboarding(index: 0), Onboarding(index: 1), Onboarding(index: 2), Onboarding(index: 3)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        configureCollectionView()
        configureHorizontalStack()
        configurePageControl()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as? OnboardingCell else { return .init() }
        cell.delegate = self
        cell.fillOnboardingData(onboarding: onboarding[indexPath.item])
        return cell
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: UIConstants.bottomPaddingCollection).isActive = true
    }
    
    private func navigatePageControlButtons(page: Int) {
        if page > onboarding.count { return }
        if page == 0 {
            buttonContext(onFirstPage: true)
        } else if page == onboarding.count - 1 {
            buttonContext(onFirstPage: false)
        } else {
            buttonContext()
        }
    }
    
    private func buttonContext(onFirstPage: Bool) {
        previousButton.isHidden = onFirstPage
        nextButton.isHidden = !onFirstPage
        exitButton.isHidden = onFirstPage
    }

    private func buttonContext() {
        [previousButton, nextButton].forEach { button in
            button.isHidden = false
        }
        exitButton.isHidden = true
    }

    private func goToNextVC() {
        let taskViewController = CustomNavigationController(rootViewController: MainTabBarController())
        taskViewController.modalPresentationStyle = .fullScreen
        present(taskViewController, animated: true, completion: nil)
    }
    
    func closeButtonPressed() {
        goToNextVC()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPosition)
        let currentPage = pageControl.currentPage
        switch currentPage {
        case 0:
            buttonContext(onFirstPage: true)
        case 1:
            buttonContext()
        case onboarding.count - 2:
            buttonContext()
        case onboarding.count - 1:
            buttonContext(onFirstPage: false)
        default:
            buttonContext()
        }
    }
    
    private func configureHorizontalStack() {
        let horizontalStack = UIStackView(arrangedSubviews: [previousButton, nextButton, exitButton])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = UIConstants.stackViewButtonsPadding
        
        view.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIConstants.stackViewButtonsPadding).isActive = true
        horizontalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIConstants.stackViewButtonsPadding).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.stackViewButtonsPadding).isActive = true
        
        buttonContext(onFirstPage: true)
    }
    
    private func configurePageControl(){
        view.addSubview(pageControl)
        pageControl.numberOfPages = onboarding.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: UIConstants.topPaddingPageContol).isActive = true
    }
    
    @objc private func pageControlButtonTaped(button: CustomRoundedButton) {
        switch button.tag {
        case 0:
            pageControl.currentPage -= 1
        case 2:
            goToNextVC()
        default:
            pageControl.currentPage += 1
        }
        navigatePageControlButtons(page: pageControl.currentPage)
        let indexPath: IndexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
