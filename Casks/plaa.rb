cask "plaa" do
  arch arm: "arm64", intel: "x86_64"

  version "0.6.0"
  sha256 arm:   "189ab4d839b7c7a395afec2b8ea89df774cabf34976d46066da2000f83ab6d76",
         intel: "3b50d4ab953728058aead85d6bad2bf0ba6ad78363925e6d6fa7746967e56c35"

  url "https://github.com/scrambletools/plaa/releases/download/v#{version}/plaa-#{version}-#{arch}.pkg"
  name "plaa"
  desc "Media player for video and audio files and streams"
  homepage "https://plaa.run/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  pkg "plaa-#{version}-#{arch}.pkg"

  uninstall launchctl: "run.plaa.bpf",
            pkgutil:   "run.plaa"

  zap trash: [
    "~/Library/Application Support/plaa",
    "~/Library/Caches/plaa",
    "~/Library/Saved Application State/run.plaa.savedState",
  ]
end
