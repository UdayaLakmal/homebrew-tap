cask "maccliphistory" do
  version "1.1.0"
  sha256 "b2b97bb09e2558e053eed15a047c1ae4a6cf8f476288d293a7c8ded621798416"

  url "https://github.com/UdayaLakmal/MacClipHistory/releases/download/v#{version}/MacClipHistory-#{version}.zip"
  name "MacClipHistory"
  desc "Clipboard history manager, like Windows Win+V"
  homepage "https://github.com/UdayaLakmal/MacClipHistory"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "MacClipHistory.app"

  # Releases are not yet notarized; clear the download quarantine so macOS opens the app.
  # Remove once notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MacClipHistory.app"],
        writable_paths: ["MacClipHistory.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.udayalakmal.maccliphistory"

  zap trash: "~/Library/Application Support/MacClipHistory"

  caveats <<~EOS
    MacClipHistory lives in the menu bar. Press ⌃⌘V to open your clipboard history.

    To let it paste for you, allow it in:
      System Settings → Privacy & Security → Accessibility

    After upgrading, remove and re-add MacClipHistory in that list if
    items are copied but not pasted.
  EOS
end
