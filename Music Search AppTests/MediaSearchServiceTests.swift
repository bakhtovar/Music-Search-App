//
//  MediaSearchServiceTests.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import XCTest
@testable import Music_Search_App

class MusicSearchAppTests: XCTestCase {
    
    // MARK: - Setup
    var mediaSearchService: MediaSearchService!

    override func setUpWithError() throws {
        mediaSearchService = MediaSearchService()
    }

    override func tearDownWithError() throws {
        mediaSearchService = nil
    }
    
    // MARK: - Test for empty query returning an error
    func testSearchMedia_emptyQuery_shouldReturnEmptyResults() {
        // Expectation for async call
        let expectation = self.expectation(description: "Search with empty query returns empty results")

        // Call search with an empty query
        mediaSearchService.searchMedia(query: "") { result in
            // Assert that the status is success
            XCTAssertEqual(result?.status, .success)
            // Assert that the resultCount is 0
            XCTAssertEqual(result?.data?.resultCount, 0)
            // Assert that the results array is empty
            XCTAssertTrue(result?.data?.results.isEmpty ?? false)
            expectation.fulfill()
        }

        // Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for valid query returning results
    func testSearchMedia_validQuery_shouldReturnResults() {
        let expectation = self.expectation(description: "Search returns valid results")
        
        // Call search with a valid query
        mediaSearchService.searchMedia(query: "Taylor Swift") { result in
            // Assert that data is returned
            XCTAssertNotNil(result?.data)
            // Assert that the results contain at least one item
            XCTAssertGreaterThan(result?.data?.results.count ?? 0, 0)
            // Assert that the status is success
            XCTAssertEqual(result?.status, .success)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - Test for search history saving
    func testSaveSearchQuery_savesToHistory() {
        let viewModel = MusicSearchViewModel()
        
        // Call saveSearchQuery with a test query
        viewModel.saveSearchQuery("Swift")
        
        // Retrieve history and assert it contains the test query
        let history = viewModel.getSearchHistory()
        XCTAssertTrue(history.contains("Swift"))
        // Assert that the first element in history is the test query
        XCTAssertEqual(history.first, "Swift")
    }
    
    // MARK: - Test for filtering search suggestions
    func testFilterSuggestions_shouldReturnFilteredResults() {
        let viewModel = MusicSearchViewModel()
        
        // Save two queries in history
        viewModel.saveSearchQuery("Swift")
        viewModel.saveSearchQuery("Taylor Swift")
        
        // Call filterSuggestions with partial input and assert filtered results
        viewModel.filterSuggestions(for: "Tay")
        XCTAssertEqual(viewModel.filteredSuggestions, ["Taylor Swift"])
    }

    // MARK: - Test for artist lookup returning details
    func testLookupArtist_returnsArtistDetails() {
        let expectation = self.expectation(description: "Artist lookup returns valid artist details")
        
        // Call lookupArtist with a valid artist ID
        mediaSearchService.lookupArtist(artistId: 1467743200) { result in // "artistName":"Dcp Labs"
            // Assert that the first artist detail is not nil
            XCTAssertNotNil(result?.data?.results.first)
            // Assert that the result status is success
            XCTAssertEqual(result?.status, .success)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test for search bar input updating the view model
    func testSearchBar_searchTextUpdatesViewModel() {
        let searchVC = MusicSearchVC()
        searchVC.loadViewIfNeeded()
        
        // Simulate text input in the search bar
        searchVC.searchBar(UISearchBar(), textDidChange: "Swift")
        // Assert that the search text in the view controller matches the input
        XCTAssertEqual(searchVC.searchText, "Swift")
    }
}

