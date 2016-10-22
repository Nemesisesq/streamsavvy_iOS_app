//
//  EpisodeTableViewControllerExtension.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/17/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation

extension EpisodeCollectionViewController: UITableViewDelegate, UITableViewDataSource {
        
        // MARK: UITableViewDelegate
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if  (selectedIndex != indexPath.row){
                        selectedIndex = nil
                        tableView.reloadData()
                        selectedIndex = indexPath.row
                } else {
                        selectedIndex = nil
                }
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                tableView.reloadData()
                let cell = tableView.cellForRow(at: indexPath) as! EpisodeTableViewCell
                cell.linkCollectionView.reloadData()
        }
        
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                if let cell = cell as? EpisodeTableViewCell {
                        
                        cell.linkCollectionView.reloadData()
                }
        }
        // MARK: UITableViewDataSource
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                let width = self.view.frame.size.width
                
                
                if (selectedIndex == indexPath.row){
                        return width * 0.9
                }
                
                return width * 0.4
                
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                if seasonKeys != nil && currentIndex != nil {
                        if let y = self.seasonKeys?[currentIndex!]{
                                key = y
                        }
                        if let x = self.seasons?[key] {
                                season = x
                                return season.count
                        }
                }
                
                return 0
                
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EpiTableViewCell", for: indexPath) as! EpisodeTableViewCell
                
                episode = season[indexPath.row]
                
                // let episode = self.seasons[seasonky(currentIndex)]?[indexPath.row]
                
                cell.seEp?.text = "Episode \(episode!.episodeNumber!)"
                
                cell.linkCollectionView.isHidden = (selectedIndex != indexPath.row)
                
                cell.epTitle?.text = "\(episode!.title!)"
                
                cell.episode = episode
                
                SDWebModel.loadImage(for: cell.episodeImage, withRemoteURL: episode?.thumbnail608X342)
                
                cell.episodeImage?.contentMode = .scaleAspectFill
                
                
                return cell
        }
        
}
