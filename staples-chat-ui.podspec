Pod::Spec.new do |s|
  s.name                        = "staples-chat-ui"
  s.version                     = '0.0.1'
  s.summary                     = "Staples cards for the Staples App."
  s.homepage                    = 'https://www.staples.com/'
  s.author                      = { 'Kevin Coleman'   => 'kcoleman731@gmail.com',
                                    'Taylor Halliday' => 'tayhalla@gmail.com',
                                  }
  s.source                      = { git: "https://github.com/kcoleman731/swipe-keyboard.git", tag: "#{s.version}" }
  s.platform                    = :ios, '8.0'

  s.requires_arc                = true
  s.source_files                = 'Code/**/*.{h,m}'
  s.public_header_files         = 'Code/**/*.h'
  s.ios.resource_bundle         = { 'StaplesResources' => ['Code/**/*.xib', 'Code/**/*.xcassets'],}
                                  
  s.ios.frameworks              = %w{ UIKit }
  s.ios.deployment_target       = '8.0'

  s.dependency                  'LayerKit', '>= 0.22.0'
  s.dependency                  'Atlas', '>= 0.22.0'
  s.dependency                  'SDWebImage', '~> 3.8.1'
  s.dependency                  'EDColor', '~> 1.0.0'
  s.dependency                  'ZXingObjC', '~> 3.0'
end
