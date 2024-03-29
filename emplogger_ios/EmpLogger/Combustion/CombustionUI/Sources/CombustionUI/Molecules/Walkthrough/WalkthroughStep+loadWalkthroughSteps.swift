//
//  WalkthroughStep+loadWalkthroughSteps.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerCore

extension WalkthroughStep: ComposedLogging {
    
    /// Load walkthrough steps asynchronously from their respective url or local path
    ///
    /// Populates the walkthrough step with it's AnimatedImage for animating in the view.
    public static func loadWalkthroughSteps(_ steps: [WalkthroughStep]) async throws -> [WalkthroughStep] {
        await withTaskGroup(of: (id: UUID, animation: AnimatedImage?).self) { group in
            var downloadedSteps = steps
            
            // Create a parallel task for each url to download and add it to the group
            for step in steps {
                group.addTask {
                    var animation: AnimatedImage?
                    
                    do {
                        if let url = step.url {
                            // Retrieve our downloaded animation
                            animation = try await AnimatedImage.loadedFrom(url: url)
                        } else if let path = step.localFile {
                            // Retrieve our local animation
                            animation = try AnimatedImage.loadedFrom(localPath: path)
                        }
                    } catch {
                        self.log("Could not load walkthrough step: \(error)", .error)
                    }
                    
                    return (id: step.id, animation: animation)
                }
            }
            
            // Parallel wait for all steps to finish their task
            for await step in group {
                // Add our downloaded animation to our step
                if let index = downloadedSteps.firstIndex(where: { step.id == $0.id }) {
                    downloadedSteps[index].animation = step.animation
                }
            }
            
            return downloadedSteps
        }
    }
}
