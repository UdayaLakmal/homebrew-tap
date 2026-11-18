cask "grammable" do
  version "0.1.4"
  sha256 "33dc16cc9fe976c99e74978301b1d1e8f93ac665dbdcb322fcf402285ba665a9"

  url "https://github.com/UdayaLakmal/Grammable/releases/download/v#{version}/Grammable-#{version}.zip"
  name "Grammable"
  desc "Free AI grammar checker and rewriter using Claude Code, Codex, Gemini or Ollama"
  homepage "https://github.com/UdayaLakmal/Grammable"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Grammable.app"

  # Releases are not yet notarized; clear the download quarantine so macOS opens the app.
  # Remove once notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Grammable.app"],
        writable_paths: ["Grammable.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.udayalakmal.grammable"

  zap trash: [
    "~/.grammable",
    "~/Library/Logs/Grammable",
    "~/Library/Preferences/io.github.udayalakmal.grammable.plist",
  ]

  caveats <<~EOS
    Grammable lives in the menu bar. On first launch, allow it in:
      System Settings → Privacy & Security → Accessibility

    After upgrading, remove and re-add Grammable in that list if the
    G button stops appearing.
  EOS
end
