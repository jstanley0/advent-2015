require 'digest'
key = ARGV.first || 'yzbqklnj'
puts (0..).find { |i| Digest::MD5.hexdigest("#{key}#{i}").start_with?("000000") }
