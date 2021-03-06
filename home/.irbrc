begin
  # load wirble
  require 'rubygems'
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
  require 'irb/completion'
  require 'irb/ext/save-history'
  ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_NO_DUPS] = true
  #IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
end

Thread.current['ums_ticket'] = 'giao@brightroll.com=user:admin'
Thread.current['ums_user'] = 'giao@brightroll.com'

script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end
