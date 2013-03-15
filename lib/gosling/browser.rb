module Gosling
  class Browser
    def self.driver
      @@webdriver ||= webdriver
      bring_browser_to_foreground()
      @@webdriver
    end
    
    def self.reset
      return self.driver if @@webdriver.nil?
      self.clear_cookies
      self.close
      @@webdriver = self.driver
    end

    def self.webdriver
      @driver_type = Gosling.driver_type
      user_defined_switches = Gosling.driver_switches
      
      case @driver_type
      when :chrome
        default_switches = %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --allow-running-insecure-content]
      else
        default_switches = []
      end 
      switches = user_defined_switches.concat(default_switches).uniq       
      puts "initializing #{@driver_type} browser with #{switches}"    
      
      switches.length > 0 ? Selenium::WebDriver.for(@driver_type, :switches => switches) : Selenium::WebDriver.for(@driver_type)
    end
    
    def self.clear_cookies
      return if @@webdriver.nil?
      @@webdriver.manage.delete_all_cookies
    end
    
    def self.close
      @@webdriver.close unless @@webdriver.nil?
      @@webdriver = nil
    end

    def self.quit
      @@webdriver.quit unless @@webdriver.nil?
      @@webdriver = nil
    end
    
    def self.bring_browser_to_foreground
      browser_name = Gosling.driver_type.to_s
      browser_name[0] = browser_name[0].capitalize
      `osascript -e 'tell application "System Events"\n tell process "#{browser_name}"\n set frontmost to true\n end tell\n end tell' >& /dev/null`
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

    def self.text
      self.find_element(:tag_name => "body").text
    end
  end
end