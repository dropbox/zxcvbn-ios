Pod::Spec.new do |s|
  s.name          = "zxcvbn-ios"
  s.version       = "1.0.2"
  s.summary       = "A realistic password strength estimator."
  s.description   = <<-DESC
                    An obj-c port of zxcvbn, a password strength estimation library,
                    designed for iOS.

                    DBZxcvbn attempts to give sound password advice through pattern
                    matching and conservative entropy calculations. It finds 10k common
                    passwords, common American names and surnames, common English words,
                    and common patterns like dates, repeats (aaa), sequences (abcd),
                    and QWERTY patterns.
                    DESC
  s.homepage      = "https://github.com/dropbox/zxcvbn-ios"
  s.screenshots   = "https://raw.githubusercontent.com/dropbox/zxcvbn-ios/master/Zxcvbn/zxcvbn-example.png"
  s.license       = "MIT"
  s.author        = { "Leah Culver" => "leah@dropbox.com" }
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/dropbox/zxcvbn-ios.git", :tag => "v1.0.1"}
  s.source_files  = "Zxcvbn/**/*.{h,m}"
  s.exclude_files = "Zxcvbn/main.m", "Zxcvbn/DBAppDelegate.{h,m}", "Zxcvbn/DBCreateAccountViewController.{h,m}"
  s.resources     = "Zxcvbn/Zxcvbn/generated/*.json"
  s.requires_arc  = true
end
