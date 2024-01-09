Completed tasks:
#1. Refactor code style - 1 point
#2. Refactor design - https://www.figma.com/file/4E2qJsN9ZU5hMX4Bnz8vuK/repo-test?node-id=0%3A1 - 2 points
#3. Refactor architecture to MVVM - 2 points
#4. Refactor networking layer to Combine - 2 points
#5. Make it able to use both combine и non-combine network layers - 1 point
Combine network layer
https://github.com/mishadovhiy/ios-assignment/blob/main/engenious-challenge/Model/NetworkService/RepositoryService.swift#L26 

non-combine network layer
https://github.com/mishadovhiy/ios-assignment/blob/main/engenious-challenge/Model/NetworkService/RepositoryService.swift#L14C10-L14C25

NetworkPublisher
https://github.com/mishadovhiy/ios-assignment/blob/main/engenious-challenge/Model/NetworkService/NetworkPublisher.swift#L12

#6. Make a unit test for network layer - 1 point
created small unit test
https://github.com/mishadovhiy/ios-assignment/blob/main/engenious-challengeTests/NetworkServiceTests.swift#L15
calls async method getRepositories to check that results for passed username are not nill 

