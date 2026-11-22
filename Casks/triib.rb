cask "triib" do
  arch arm: "arm64", intel: "x86_64"

  version "1.5.4"
  sha256 arm:   "a56a5c53f80bb380cb3ad02ad1743a11ad676d7fbc67037f26d2ede9da99f34a",
         intel: "0d4fd4faa74aef46707b92df21f15a8d6788fae3c61bb0f54485971221615d85"

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
