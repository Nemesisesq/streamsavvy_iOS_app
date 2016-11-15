# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift

use_frameworks!

target 'Stream Savvy' do

pod 'AFNetworking', '~> 3.0'
pod 'SDWebImage', '~>3.7'
pod 'SCLAlertView-Objective-C'
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
pod 'FBSDKShareKit'
pod 'MBProgressHUD', '~> 1.0.0'
pod 'Toast', '~> 3.0'
pod 'Alamofire', '~> 4.0'
pod "PromiseKit", "~> 4.0"
pod "PromiseKit/Alamofire", "~> 4.0"
pod "Gloss", "~> 1.0"
pod 'Dollar'
pod 'UICollectionViewLeftAlignedLayout'
pod 'Lock', "~> 1.27"
pod 'Auth0', '1.0.0'
pod 'SimpleKeychain', '~> 0.7'
pod 'ADMozaicCollectionViewLayout', '~> 2.0'
pod "MarqueeLabel/Swift"
pod 'UIScrollView-InfiniteScroll'
pod "MBRateApp"
pod "Harpy"


platform :ios, '10.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

target 'Stream SavvyTests' do

end

target 'Stream SavvyUITests' do

end


