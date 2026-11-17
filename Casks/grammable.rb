cask "grammable" do
  version "0.1.0"
  sha256 "f84604e83878bedbe6ae6f06bee95625223cd4661d1cfc6930a8277bb6756a71"

  url "https://github.com/UdayaLakmal/Grammable/releases/download/v#{version}/Grammable-#{version}.zip"
  name "Grammable"
  desc "Free AI grammar checker and rewriter using Claude Code, Codex, Gemini or Ollama"
  homepage "https://github.com/UdayaLakmal/Grammable"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Grammable.app"

  # Releases are not yet notarized; clear the download quarantine so macOS opens the app.
  # (Uses postflight because install steps have no quarantine operation. Remove once notarized.)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Grammable.app"]
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
