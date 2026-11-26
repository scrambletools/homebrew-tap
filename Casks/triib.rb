cask "triib" do
  arch arm: "arm64", intel: "x86_64"

  version "1.5.6"
  sha256 arm:   "b8c168e74a8483e8431995c60e35eefc04c7debf4f07311d25f76d835ea84723",
         intel: "f76dd8900088a6c1cbd65d53cf5a7daaf7578798c1bffa021852eab87b4a8b54"

  url "https://github.com/scrambletoolsllc/triib/releases/download/v#{version}/triib-#{version}-#{arch}.pkg"
  name "triib"
  desc "Discover, connect and set up AVB and Milan devices"
  homepage "https://triib.run/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  pkg "triib-#{version}-#{arch}.pkg"

  uninstall launchctl: "run.triib.bpf",
            pkgutil:   "run.triib",
            delete:    "/usr/local/bin/triib-cli"

  zap trash: [
    "~/Library/Application Support/triib",
    "~/Library/Caches/triib",
    "~/Library/Saved Application State/run.triib.savedState",
  ]

  caveats <<~EOS
    triib reaches raw Ethernet (/dev/bpf*) through the access_bpf group,
    which the installer adds you to; it takes effect at your next login.
  EOS
end
