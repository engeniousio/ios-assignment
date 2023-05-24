//
//  MockRepositoryService.swift
//  engenious-challenge
//
//  Created by nikita on 24.05.2023.
//

import Combine

class MockRepositoryService: RepositoryService {
	
	func getUserRepos(username: String) -> Future<[Repo], Error> {
		return Future { promise in
			promise(.success([
				Repo(name: "Test Name 1", description: "Test Description 1", url: "https://google.com"),
				Repo(name: "Test Name 2", description: "Test Description 2", url: "https://google.com"),
				Repo(name: "Test Name 3", description: "Test Description 3", url: "https://google.com")
			]))
		}
	}
	
}
