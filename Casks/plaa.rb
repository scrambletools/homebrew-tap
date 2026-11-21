cask "plaa" do
  arch arm: "arm64", intel: "x86_64"

  version "0.6.1"
  sha256 arm:   "6e15263924313a34bcbfb7d12bc9595a0ed2743f4cc6cd669dfd916ad0202bb1",
         intel: "36d4f903abd4b793fd555f964d22bb369daa5aba1ec0d8a4b756f657567507fd"

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
