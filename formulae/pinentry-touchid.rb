class PinentryTouchid < Formula
  desc "Custom GPG pinentry program for macOS that allows using Touch ID for fetching the password from the macOS keychain."
  url "https://github.com/ratza/pinentry-touchid/archive/a4257f3b5a853ca4d45bc28c29373504a22077f9.zip"
  sha256 "eea965626428b4e3c4e7a91e34f261c61e0b53e81d0b6c0469d248352ff9aa45"
  license "Apache-2.0"

  homepage "https://github.com/ratza/pinentry-touchid"
  version "0.0.4"

  depends_on "go" => :build
  depends_on "pinentry"
  depends_on "pinentry-mac"
  depends_on :macos

  def install
    system "go", "build", *std_go_args
  end
end
