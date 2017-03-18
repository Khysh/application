//
//  GiveSpeechViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class GiveSpeechViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.registerNib(for: TextFieldPlateTableViewCell.self)
      tableView.registerNib(for: TextViewPlateTableViewCell.self)
      tableView.registerHeaderNib(for: DefaultTableHeaderView.self)
    }
  }

  var displayCollection: GiveSpeechDisplayCollection!

  @IBOutlet weak var sendSpeechButton: UIBarButtonItem!
//  @IBOutlet weak var titleLabel: UILabel!
//  @IBOutlet weak var titleTextField: UITextField!
//  @IBOutlet weak var descriptionTextView: TextViewWithPlaceholder! {
//    didSet {
//      descriptionTextView.layer.cornerRadius  = 5
//      descriptionTextView.layer.borderWidth   = 1
//      descriptionTextView.layer.borderColor   = UIColor.lightGray.withAlphaComponent(0.3).cgColor
//      descriptionTextView.placeholder         = "placeholder"
//    }
//  }

  override func viewDidLoad() {
    super.viewDidLoad()

    keyboardDelegate = self
    setupGestureRecognizer()

    displayCollection = GiveSpeechDisplayCollection()

    view.backgroundColor = UIColor(.lightGray)
    title = "Geve a speech".localized
  }

  func setupGestureRecognizer() {
    let dissmisKBTouch =
      UITapGestureRecognizer(target: self,
                             action: #selector(GiveSpeechViewController.dismissKeyboard))
    view.addGestureRecognizer(dissmisKBTouch)
  }

  func sendSpeech() {
    // Do stuff here ...
  }

  @IBAction func sendSpeechButtonPressed(_ sender: UIBarButtonItem) {
    sendSpeech()
  }

  func dismissKeyboard() {
    view.endEditing(true)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return displayCollection.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return displayCollection.height(for: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return displayCollection.headerHeight(for: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView() as DefaultTableHeaderView

    return header
  }
}

//// MARK: - UITextFieldDelegate
//extension GiveSpeechViewController {
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    if textField == titleTextField {
//      descriptionTextView.becomeFirstResponder()
//      return false
//    }
//    return true
//  }
//}

// MARK: - KeyboardHandlerDelegate
extension GiveSpeechViewController: KeyboardHandlerDelegate {
  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {

    var scrollViewContnetInsets = tableView.contentInset
    var indicatorContentInsets = tableView.scrollIndicatorInsets

    switch state {
    case .frameChanged:
      scrollViewContnetInsets.bottom = info.endFrame.height
      indicatorContentInsets.bottom = info.endFrame.height
    case .opened:
      scrollViewContnetInsets.bottom = info.endFrame.height
      indicatorContentInsets.bottom = info.endFrame.height
    case .hidden:
      scrollViewContnetInsets.bottom = 0
      indicatorContentInsets.bottom = 0
    }

    tableView.contentInset = scrollViewContnetInsets
    tableView.scrollIndicatorInsets = indicatorContentInsets
  }
}
