cask "prev" do
  arch arm: "arm64", intel: "x86_64"

  version "2.4.2"
  sha256 arm:   "0d1d0420c31c07898fcf170d6ef3f1052c48c785b1d0e0f0039dd6e7331ea764",
         intel: "9e7bdaf1ab30d3df0cd139158e1ff42994834f885aa0a6d0854a8e8a09e7f099"

  url "https://github.com/scrambletoolsllc/prev/releases/download/v#{version}/prev-#{version}-#{arch}.dmg"
  name "prev"
  desc "View, mark up and sign PDFs and images"
  homepage "https://prev.run/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "prev.app"

  zap trash: [
    "~/Library/Application Support/prev",
    "~/Library/Caches/prev",
    "~/Library/Saved Application State/run.prev.savedState",
  ]
end
