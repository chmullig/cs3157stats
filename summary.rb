#!/usr/bin/env ruby

require 'mbox'
require 'date'
require 'csv'

unames = Hash.new { |hash, n| hash[n] = (0...8).map{(65+rand(26)).chr}.join }
CSV.open("commits.csv", "wb") do |csv|
    csv << ['name', 'lab', 'rawdate', 'datetime', 'files', 'insertions', 'deletions']

    Dir.glob('*/*.mbox') do |item|
        name, labn = item.match(/\/([A-z0-9]+)-lab(\d{1,2}).mbox$/).captures
        puts "working on: #{item}. Lab #{labn} of #{name}. mapped to #{unames[name]}...  "
        Mbox.open(item).each do |mail|
            #Thu, 18 Apr 2013 22:45:11 -0400
            d = DateTime.strptime(mail.headers['Date'], "%a, %d %b %Y %T %z")
            if match = mail.content[0].to_str.match(/^ (\d+) files? changed(?:, )?(?:(\d+) insertions?\(\+\))?(?:, )?(?:(\d+) deletions?\(-\))?$/)
                files, insertions, deletions = match.captures
            end
            csv << [unames[name], labn, mail.headers['Date'], d, files || 0, insertions || 0, deletions || 0]
        end #mail
    end #glob
end #csv
