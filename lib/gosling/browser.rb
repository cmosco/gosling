module Gosling
  class Browser
    def self.driver
      @@webdriver ||= webdriver
      bring_chrome_to_foreground()
      @@webdriver
    end
    
    def self.reset
      return self.driver if @@webdriver.nil?
      @@webdriver.close
      @@webdriver = nil
      self.driver
    end

    def self.webdriver
      Selenium::WebDriver.for(:chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --allow-running-insecure-content])
    end
    
    def self.clear_cookies
      return if @@webdriver.nil?
      @@webdriver.manage.delete_all_cookies
    end
    
    def self.close
      @@webdriver.close unless @@webdriver.nil?
    end

    def self.quit
      @@webdriver.quit unless @@webdriver.nil?
      @@webdriver = nil
    end

    def self.bring_chrome_to_foreground
      `osascript -e 'tell application "System Events"\n tell process "Chrome"\n set frontmost to true\n end tell\n end tell' >& /dev/null`
    end

    def self.chrome_file_chooser(target_file_path)
      `osascript -e 'tell application "System Events"\n tell process "Chrome"\n set frontmost to true\n keystroke "g" using {shift down, command down}\n keystroke "#{target_file_path}"\n delay 1\n keystroke return\n delay 3\n keystroke return\n end tell\n end tell' >& /dev/null`
    end

    def self.chrome_press_return
      `osascript -e 'tell application "System Events"\n tell process "Chrome"\n set frontmost to true\n keystroke return\nend tell\n end tell\n' >& /dev/null`
    end
  
    def self.method_missing(sym, *args, &block)
      return self.driver if @@webdriver.nil?
      @@webdriver.send sym, *args, &block
    end
  end
end