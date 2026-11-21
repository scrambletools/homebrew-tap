cask "triib" do
  arch arm: "arm64", intel: "x86_64"

  version "1.5.1"
  sha256 arm:   "2f4e3eb21210b2d8f5aaee0decfa858f5c0c5a5e48476709b5b78a1894d1060a",
         intel: "6c5b3ac9ab791bab7c45d460f8d70a97cf98e359c4dff4d4e24eb16f9f3eba17"

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
