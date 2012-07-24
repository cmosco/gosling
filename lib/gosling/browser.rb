module Gosling
  class Browser
    def self.driver
      @@driver ||= Selenium::WebDriver.for(:chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --allow-running-insecure-content])
      bring_chrome_to_foreground()
      @@driver
    end
    
    def self.reset
      return self.driver if @@driver.nil?
      @@driver.close
      @@driver = nil
      self.driver
    end
    
    def self.clear_cookies
      return if @@driver.nil?
      @@driver.manage.delete_all_cookies
    end
    
    def self.close
      @@driver.close unless @@driver.nil?
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
      @@driver.send sym, *args, &block
    end
  end
end