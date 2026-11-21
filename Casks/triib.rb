cask "triib" do
  arch arm: "arm64", intel: "x86_64"

  version "1.5.0"
  sha256 arm:   "0017824541c70794ee76b8af6badf4c8cd995b9455689df2b70f9ccf8d0b1f64",
         intel: "2c65bac46483f2618bb2985254511cedc3db604c881c9a0ce298346f7a48247a"

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
