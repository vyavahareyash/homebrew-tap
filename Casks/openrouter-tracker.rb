cask "openrouter-tracker" do
  version "1.1.4"
  sha256 "1d87b9c84f82321100b4fa89c39b8a70da4a6b4054db833d5288dadeebc51464"

  url "https://github.com/vyavahareyash/openrouter-tracker/releases/download/v#{version}/OpenRouterTracker.dmg"
  name "OpenRouter Tracker"
  desc "Native macOS desktop widget & companion app for OpenRouter balance and rate limits"
  homepage "https://github.com/vyavahareyash/openrouter-tracker"

  depends_on macos: :sonoma

  app "OpenRouterTracker.app"

  postflight do
    system_command "/usr/bin/xattr",
         args: ["-cr", "#{appdir}/OpenRouterTracker.app"]
    system_command "/usr/bin/pluginkit",
         args: ["-a", "#{appdir}/OpenRouterTracker.app/Contents/PlugIns/OpenRouterWidgetExtension.appex"]
    system_command "/usr/bin/pluginkit",
         args: ["-e", "use", "-i", "com.openrouter.tracker.widget"]
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
         args: ["-f", "-R", "-trusted", "#{appdir}/OpenRouterTracker.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/group.com.openrouter.tracker",
    "~/Library/Group Containers/group.com.openrouter.tracker",
    "~/Library/Preferences/com.openrouter.tracker.plist",
  ]
end
