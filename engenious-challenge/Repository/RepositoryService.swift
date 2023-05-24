//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by nikita on 24.05.2023.
//

import Combine

protocol RepositoryService {
	
	func getUserRepos(username: String) -> Future<[Repo], Error>
	
}
