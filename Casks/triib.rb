cask "triib" do
  arch arm: "arm64", intel: "x86_64"

  version "1.5.5"
  sha256 arm:   "f494ddcfa4ea2ac101479ad55c7d0f203e690bb1da48394838136b68ef76207d",
         intel: "d36f42529d34ff36d6b7ebf6809f2bea31fe3900ac3b4293fc613daeb9ec3eb7"

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
