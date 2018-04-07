//
//  Telegraph_TestTests.swift
//  Telegraph_TestTests
//
//  Created by Administrator on 05/04/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import XCTest
import UIKit

@testable import Telegraph_Test

class Telegraph_TestTests: XCTestCase {
  
   var  vc :  ViewController!
   var  articles: [CollectionViewModel]!
    var tableView: UITableView!
    
    var cell: ArticleCell!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = vc.view
        //calls the viewdidload
       articles =  (UIApplication.shared.delegate as! AppDelegate).articles
        
         tableView =  vc.tableView
        
        cell =  tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
  
    
    func testLoadingViewSetsTableViewDataSource() {
        XCTAssertTrue(vc.tableView.dataSource is ViewController)
    }
    
    func testLoadingViewSetsTableViewDelegate() {
        XCTAssertTrue(vc.tableView.delegate is ViewController)
    }
    
    func testLoadingViewDataSourceEqualDelegate() {
        XCTAssertEqual(
            vc.tableView.dataSource as? ViewController,
            vc.tableView.delegate as? ViewController)
    }
    
    
    
    func testHasheadlineLabel() {
        XCTAssertTrue(cell.headlineLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasdescriptionLabel() {
        XCTAssertTrue(cell.descriptionLabel.isDescendant(of: cell.contentView))
    }
    
    func test_HasRatingLabel() {
        XCTAssertTrue(cell.ratingLabel.isDescendant(of: cell.contentView))
    }
    
    func testNumberOfSections_IsOne() {
        let numberOfSections = vc.tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testViewModelHasrecords() {
     //   articles: [CollectionViewModel] =  (UIApplication.shared.delegate as! AppDelegate).articles
         XCTAssertTrue(articles.count > 0, "There should be records")
    }
    
   
    
    func testReturnViewModelId() {
        let id =   vc.articles[0].id
        XCTAssertEqual(id, 1, "first record id not 1")
    }
    
    func testReturnViewModelHeadline() {
        let headline =   vc.articles[0].headline
       XCTAssertEqual( headline, "The revenant", "headline check")
    }
    
    func testlistWithCommaSeparation() {
        let testlist = "Amy Winehouse, Mitch Winehouse, Janis Winehouse, Blake Fielder-Civil (archive footage)."
     let actorslist =   vc.articles[7].actors
        let listGenerated =  vc.listWithCommaSeparation(list: actorslist!)
          XCTAssertEqual(testlist, listGenerated, "list not formatted correctly")
    }
    
}
