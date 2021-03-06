require "bundler/gem_tasks"
require "rake/testtask"
require 'golos_cloud'
require 'awesome_print'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

task :console do
  exec "irb -r golos_cloud -I ./lib"
end

task :build do
  exec 'gem build golos_cloud.gemspec'
end

task :push do
  exec "gem push golos_cloud-#{GolosCloud::VERSION}.gem"
end

desc 'Lists sum of transfers grouped by date, from, and to.'
task :transfers, [:minimum_amount, :symbol, :days_ago] do |t, args|
  now = Time.now.utc
  minimum_amount = (args[:minimum_amount] || '1000000').to_f
  symbol = (args[:symbol] || 'GOLOS').upcase
  after_timestamp = now - ((args[:days_ago] || '30').to_i * 86400)
  
  # Only type: transfer; ignore savings, vestings
  transfers = GolosCloud::Tx::Transfer.where(type: 'transfer')
  transfers = transfers.where('amount > ?', minimum_amount)
  transfers = transfers.where('amount_symbol = ?', symbol)
  transfers = transfers.where('timestamp > ?', after_timestamp)
  transfers = transfers.group('CAST(timestamp AS DATE)', :from, :to)
  transfers = transfers.order('cast_timestamp_as_date ASC')
  
  puts "Daily transfer sum over #{'%.3f' % minimum_amount} #{symbol} since #{after_timestamp} ..."
  ap transfers.sum(:amount)
end

desc 'Lists apps grouped by date, app/version.'
task :apps, [:app, :days_ago] do |t, args|
  now = Time.now.utc
  app = args[:app]
  after_timestamp = now - ((args[:days_ago] || '7').to_i * 86400)
  
  comments = GolosCloud::Comment.normalized_json
  comments = comments.app(app) if !!app
  comments = comments.where('created > ?', after_timestamp)
  comments = comments.group('CAST(created AS DATE)', "JSON_VALUE(json_metadata, '$.app')")
  comments = comments.order('cast_created_as_date ASC')
  
  matching = " matching \"#{app}\"" if !!app
  puts "Daily app#{matching} count since #{after_timestamp} ..."
  ap comments.count(:all)
end

desc 'Do all crosschecks of given account.'
task :crosscheck, [:account] do |t, args|
  account = args[:account]
    
  Rake::Task["crosscheck:powerdowns"].invoke(account)
  Rake::Task["crosscheck:powerups"].invoke(account)
  Rake::Task["crosscheck:transfers"].invoke(account)
  Rake::Task["crosscheck:vesting_from"].invoke(account)
  Rake::Task["crosscheck:vesting_to"].invoke(account)
end
  
namespace :crosscheck do
  desc 'List of accounts grouped by transfer count crosschecked by memo of given account.'
  task :transfers, [:account] do |t, args|
    exchanges = %w(bittrex poloniex openledger blocktrades)
    account = args[:account]
    
    if account.nil? || account == ''
      puts 'Account name required.'
      exit
    elsif exchanges.include? account
      puts 'That procedure is not recommended.'
      exit
    end
    
    all = GolosCloud::Tx::Transfer.where(type: 'transfer')
    transfers = all.where(to: exchanges)
    transfers = if account =~ /%/
      table = GolosCloud::Tx::Transfer.arel_table
      transfers.where(table[:from].matches(account))
    else
      transfers.where(from: account)
    end
    crosscheck_transfers = all.where(memo: transfers.select(:memo))
    
    if transfers.none?
      puts "No match."
    else
      from = transfers.pluck(:from).uniq.join(', ')
      puts "Accounts grouped by transfer count using commom memos as #{from} on common exchanges ..."
      ap crosscheck_transfers.group(:from).order('count_all').count(:all)
    end
  end
  
  desc 'List of accounts grouped by vesting transfers from a given account'
  task :vesting_from, [:account] do |t, args|
    account = args[:account]
    
    if account.nil? || account == ''
      puts 'Account name required.'
      exit
    end
    
    table = GolosCloud::Tx::Transfer.arel_table
    all = GolosCloud::Tx::Transfer.where(type: 'transfer_to_vesting')
    transfers = all.where(table[:from].not_eq(:to))
    transfers = transfers.where.not(to: '')
    transfers = if account =~ /%/
      table = GolosCloud::Tx::Transfer.arel_table
      transfers.where(table[:from].matches(account))
    else
      transfers.where(from: account)
    end
    
    if transfers.none?
      puts "No match."
    else
      from = transfers.pluck(:from).uniq.join(', ')
      puts "Accounts grouped by vesting transfer count from #{from} ..."
      ap transfers.group(:to).order('count_all').count(:all)
    end
  end
  
  desc 'List of accounts grouped by vesting transfers to a given account'
  task :vesting_to, [:account] do |t, args|
    account = args[:account]
    
    if account.nil? || account == ''
      puts 'Account name required.'
      exit
    end
    
    table = GolosCloud::Tx::Transfer.arel_table
    all = GolosCloud::Tx::Transfer.where(type: 'transfer_to_vesting')
    transfers = all.where(table[:from].not_eq(table[:to]))
    transfers = transfers.where.not(to: '')
    transfers = if account =~ /%/
      table = GolosCloud::Tx::Transfer.arel_table
      transfers.where(table[:to].matches(account))
    else
      transfers.where(to: account)
    end
    
    if transfers.none?
      puts "No match."
    else
      from = transfers.pluck(:to).uniq.join(', ')
      puts "Accounts grouped by vesting transfer count to #{from} ..."
      ap transfers.group(:from).order('count_all').count(:all)
    end
  end
  
  desc 'List of accounts grouped by powerdown sums crosschecked by given account.'
  task :powerdowns, [:account] do |t, args|
    account = args[:account]
    
    if account.nil? || account == ''
      puts 'Account name required.'
      exit
    end
    
    table = GolosCloud::Vo::FillVestingWithdraw.arel_table
    all = GolosCloud::Vo::FillVestingWithdraw.where(table[:from_account].not_eq(table[:to_account]))
    powerdowns = if account =~ /%/
      all.where(table[:from_account].matches(account))
    else
      all.where(from_account: account)
    end
    
    if powerdowns.none?
      puts "No match."
    else
      from = powerdowns.pluck(:from_account).uniq.join(', ')
      puts "Powerdowns grouped by sum from #{from} ..."
      ap powerdowns.group(:to_account).
        order('sum_try_parse_replace_withdrawn_gests_as_float').
        sum("TRY_PARSE(REPLACE(withdrawn, ' GESTS', '') AS float)")
    end
  end
  
  desc 'List of accounts grouped by powerup sums crosschecked by given account.'
  task :powerups, [:account] do |t, args|
    account = args[:account]
    
    if account.nil? || account == ''
      puts 'Account name required.'
      exit
    end
    
    table = GolosCloud::Vo::FillVestingWithdraw.arel_table
    all = GolosCloud::Vo::FillVestingWithdraw.where(table[:from_account].not_eq(table[:to_account]))
    powerups = if account =~ /%/
      all.where(table[:to_account].matches(account))
    else
      all.where(to_account: account)
    end
    
    if powerups.none?
      puts "No match."
    else
      to = powerups.pluck(:to_account).uniq.join(', ')
      puts "Powerups grouped by sum to #{to} ..."
      ap powerups.group(:from_account).
        order('sum_try_parse_replace_withdrawn_gests_as_float').
        sum("TRY_PARSE(REPLACE(withdrawn, ' GESTS', '') AS float)")
    end
  end
end

namespace :rewards do
  desc 'Lists author rewards grouped by date.'
  task :author, [:symbol, :days_ago] do |t, args|
    now = Time.now.utc
    symbol = (args[:symbol] || 'GBG').upcase
    after_timestamp = now - ((args[:days_ago] || '7').to_i * 86400)
    
    rewards = GolosCloud::Vo::AuthorReward
    rewards = rewards.where('timestamp > ?', after_timestamp)
    rewards = rewards.group('CAST(timestamp AS DATE)')
    rewards = rewards.order('cast_timestamp_as_date ASC')
    
    puts "Daily author reward #{symbol} sum grouped by date since #{after_timestamp} ..."
    
    case symbol
    when 'GBG' then ap rewards.sum(:sdb_payout)
    when 'GOLOS' then ap rewards.sum(:steem_payout)
    when 'GESTS' then ap rewards.sum(:vesting_payout)
    when 'MGESTS'
      ap rewards.sum('vesting_payout / 1000000')
    else; puts "Unknown symbol: #{symbol}.  Symbols supported: GBG, GOLOS, GESTS, MGESTS"
    end
  end

  desc 'Lists curation rewards grouped by date.'
  task :curation, [:symbol, :days_ago] do |t, args|
    now = Time.now.utc
    symbol = (args[:symbol] || 'MGESTS').upcase
    after_timestamp = now - ((args[:days_ago] || '7').to_i * 86400)
    
    rewards = GolosCloud::Vo::CurationReward
    rewards = rewards.where('timestamp > ?', after_timestamp)
    rewards = rewards.group('CAST(timestamp AS DATE)')
    rewards = rewards.order('cast_timestamp_as_date ASC')
    
    puts "Daily curation reward #{symbol} sum grouped by date since #{after_timestamp} ..."
    
    case symbol
    when 'GESTS'
      ap rewards.sum("TRY_PARSE(REPLACE(reward, ' GESTS', '') AS float)")
    when 'MGESTS'
      ap rewards.sum("TRY_PARSE(REPLACE(reward, ' GESTS', '') AS float) / 1000000")
    else; puts "Unknown symbol: #{symbol}.  Symbols supported: GESTS, MGESTS"
    end
  end
end

desc 'Lists proxied grouped by month.'
task :proxied, [:days_ago] do |t, args|
  now = Time.now.utc
  after_timestamp = now - ((args[:days_ago] || '7').to_i * 86400)
  
  proxied = GolosCloud::Tx::AccountWitnessProxy
  proxied = proxied.where('timestamp > ?', after_timestamp)
  proxied = proxied.group("FORMAT(timestamp, 'yyyy-MM')", :proxy)
  proxied = proxied.order('format_timestamp_yyyy_mm ASC')
  
  puts "Daily proxied grouped by month since #{after_timestamp} ..."
  
  ap proxied.count(:all)
end

# Doesn't look like this table exists.
# desc 'List conversion GBG conversion request sums grouped by day.'
# task :convert, [:days_ago] do |t, args|
#   now = Time.now.utc
#   after_timestamp = now - ((args[:days_ago] || '3.5').to_f * 86400)
# 
#   converts = GolosCloud::Vo::FillConvertRequest
#   converts = converts.where('timestamp > ?', after_timestamp)
#   converts = converts.group('CAST(timestamp AS DATE)')
#   converts = converts.order('cast_timestamp_as_date ASC')
# 
#   puts "Daily conversion requests failled sum grouped by date since #{after_timestamp} ..."
#   ap converts.sum(:amount)
# end
